import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:megaplug/config/clients/api/api_client.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:megaplug/config/helpers/logging_helper.dart';

import '../../../data/api_responses/user_response.dart';
import '../../../presentation/auth/login/login_screen.dart';

enum StorageClientKeys {
  language, //String
  notifications, //int
  apiToken, //String
  apiTokenType, //String
  isDarkMode, //bool
  intro, //int
  user, //jsonString
  transactionId, //String
}

class StorageClient {
  final GetStorage _box = GetStorage();

  Future init() async {
    await GetStorage.init();
    // await save(StorageClientKeys.language, 'en');
  }

  String getAppLanguage({BuildContext? context}) =>
      get(StorageClientKeys.language) ?? Get.deviceLocale?.languageCode ?? 'en';

  bool isLogged() => get(StorageClientKeys.apiToken) != null;

  bool isDarkMode() => get(StorageClientKeys.isDarkMode) ?? false;

  String? apiToken() => get(StorageClientKeys.apiToken);

  String? apiTokenType() => get(StorageClientKeys.apiTokenType);

  bool isAr() => getAppLanguage() == 'ar';

  /// ============= ============== ===================  =================
  Future save(StorageClientKeys storageClientKeys, dynamic value) async {
    await GetStorage().write(storageClientKeys.name, value);
  }

  dynamic get(StorageClientKeys storageClientKeys) {
    return GetStorage().read(storageClientKeys.name);
  }

  Future saveUser({UserResponse? userResponse}) async {
    if (userResponse?.accessToken != null && userResponse?.user != null) {
      await save(
        StorageClientKeys.user,
        jsonEncode(userResponse!.user!.toJson()),
      );

      await save(StorageClientKeys.apiToken, userResponse.accessToken);
      await save(StorageClientKeys.apiTokenType, userResponse.tokenType);
      APIClient.instance.updateTokenHeader(userResponse.accessToken,
          tokenType: userResponse.tokenType);
      AppLogger.log('User Saved Successfully !!');
    } else {
      AppLogger.log('User Failed To Be Saved !!');
    }
  }

  Future signOut() async {
    await _box.erase();
    String? language = getAppLanguage();
    Get.offAll(() => LoginScreen());
    await save(StorageClientKeys.intro, 1);
    await save(StorageClientKeys.language, language);
    APIClient.instance.updateTokenHeader(null);
  }
}
