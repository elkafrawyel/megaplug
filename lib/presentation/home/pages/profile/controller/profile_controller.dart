import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:megaplug/config/app_loader.dart';
import 'package:megaplug/config/clients/api/api_result.dart';
import 'package:megaplug/config/helpers/logging_helper.dart';
import 'package:megaplug/config/information_viewer.dart';
import 'package:megaplug/config/theme/color_extension.dart';
import 'package:megaplug/data/api_responses/edit_profile_response.dart';
import 'package:megaplug/data/api_responses/general_response.dart';
import 'package:megaplug/data/repositories/profile_repo.dart';
import 'package:megaplug/domain/entities/api/user_model.dart';
import 'package:megaplug/widgets/app_widgets/app_text_field/app_text_field.dart';

import '../../../../../config/clients/storage/storage_client.dart';

class ProfileController extends GetxController {
  static ProfileController get to => Get.find<ProfileController>();

  final ProfileRepositoryImpl _profileRepositoryImpl;

  ProfileController(this._profileRepositoryImpl);

  File? _profileImage;

  UserModel? userModel;

  File? get profileImage => _profileImage;

  @override
  onInit() {
    super.onInit();
    _getUserProfile();
  }

  Future _getUserProfile() async {
    ApiResult<UserModel> apiResult = _profileRepositoryImpl.getUserProfile();
    if (apiResult.isSuccess()) {
      userModel = apiResult.getData();
      update();
    } else {
      InformationViewer.showErrorToast(msg: apiResult.getError());
    }
  }

  set profileImage(File? value) {
    _profileImage = value;
    update();
  }

  Future<void> logout() async {
    AppLoader.loading();

    ApiResult<GeneralResponse> apiResult = await _profileRepositoryImpl.logout();

    AppLoader.dismiss();
    if (apiResult.isSuccess()) {
      Get.back();

      GeneralResponse generalResponse = apiResult.getData();
      // InformationViewer.showSuccessToast(msg: generalResponse.message);
      await StorageClient().signOut();
    } else {
      InformationViewer.showErrorToast(msg: apiResult.getError());
    }
  }

  Future<void> refreshData() async {
    await _getUserProfile();
  }

  void deleteAccount({required String reason}) async {
    AppLogger.logWithGetX('Deleting account with reason: $reason');
    AppLoader.loading();

    await Future.delayed(Duration(seconds: 2));
    AppLoader.dismiss();
    //to close the delete account popup
    Get.back();
  }

  Future<void> updateProfile({
    required BuildContext context,
    required GlobalKey<AppTextFormFieldState> emailState,
    required GlobalKey<AppTextFormFieldState> phoneState,
    required String name,
    required String email,
    required String phone,
  }) async {
    AppLoader.loading();

    ApiResult<EditProfileResponse> apiResult = await _profileRepositoryImpl.editProfile(
      name: name,
      email: email,
      phone: phone,
      profileImage: _profileImage,
    );

    AppLoader.dismiss();
    if (apiResult.isSuccess()) {
      EditProfileResponse editProfileResponse = apiResult.getData();
      InformationViewer.showSuccessToast(msg: editProfileResponse.message);
      if (editProfileResponse.data != null) {
        userModel = editProfileResponse.data?.user;
        update();
        await StorageClient().save(
          StorageClientKeys.user,
          jsonEncode(editProfileResponse.data?.toJson()),
        );
      }

      Get.back(result: true);
    } else {
      InformationViewer.showErrorToast(msg: apiResult.getError());
      InformationViewer.showSnackBar(
        msg: apiResult.getError().trimLeft(),
        bgColor: context.mounted ? context.kErrorColor : Colors.red,
      );
      List<String> errors = apiResult.getError().split('\n');

      for (String error in errors) {
        if (error.contains('phone')) {
          phoneState.currentState?.addApiError(error);
        } else if (error.contains('email')) {
          emailState.currentState?.addApiError(error);
        }
      }
    }
  }
}
