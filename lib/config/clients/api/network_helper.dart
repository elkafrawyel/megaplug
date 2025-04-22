import 'package:dio/dio.dart';
import 'package:megaplug/config/clients/api/api_result.dart';
import 'package:megaplug/config/clients/storage/storage_client.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_utils/get_utils.dart';

class NetworkHelper {
  static const int unAuthenticatedCode = 401;
  static const int serverErrorCode = 500;
  static const int notFoundCode = 404;

  static bool isSuccess(Response response) {
    return response.statusCode! >= 200 && response.statusCode! < 300;
  }

  ///Don't forget to cast it to function return type using [as] method
  static ApiFailure<T> handleCommonNetworkCases<T>(Response response) {
    bool isAr = StorageClient().isAr();
    Map? body;
    String errorMessage = '';
    try {
      body = response.data;
      if (response.statusCode == unAuthenticatedCode) {
        StorageClient().signOut();
        return ApiFailure(isAr ? 'يجب تسجيل الدخول' : 'Unauthenticated');
      } else if (response.statusCode == notFoundCode) {
        return ApiFailure(isAr ? 'رابط غير موجود' : 'Not Found Error');
      } else if (response.statusCode == serverErrorCode) {
        return ApiFailure(isAr ? 'خطأ في السيرفر' : 'Server Error');
      } else if (body != null &&
          body['errors'] != null &&
          body['errors'].isNotEmpty) {
        Map<String, dynamic> errorMap = body['errors'];
        errorMap.forEach((key, value) {
          List errors = value;
          errorMessage = '$errorMessage\n${errors.join('\n')}';
        });
        return ApiFailure(errorMessage);
      } else if (body != null && body['message'] != null) {
        return ApiFailure(body['message']);
      } else {
        return ApiFailure(isAr ? 'حدث خطأ ما' : 'General Error');
      }
    } catch (e) {
      return ApiFailure(isAr ? 'حدث خطأ ما' : 'General Error');
    }
  }

  static ApiFailure<T> handleDioError<T>(DioException error) {
    bool isAr = Get.locale?.languageCode == 'ar';

    if (error.type == DioExceptionType.connectionError) {
      return ApiFailure(isAr ? 'لا يوجد إتصال بالانترنت' : 'Network Error');
    } else if (error.type == DioExceptionType.connectionTimeout) {
      return ApiFailure(isAr ? 'انتهت مهلة الطلب' : 'Request Timeout');
    } else if (error.type == DioExceptionType.receiveTimeout) {
      return ApiFailure(isAr ? 'انتهت مهلة الارسال' : 'Receive Timeout');
    } else if (error.type == DioExceptionType.badCertificate) {
      return ApiFailure(isAr ? 'اتصال غير موثوق' : 'Bad Certificate');
    } else if (error.type == DioExceptionType.badResponse) {
      return ApiFailure(isAr ? 'خطا فالرد من الموقع' : 'Bad Response');
    } else {
      return ApiFailure(isAr ? 'للأسف حدث خطأ' : 'Unexpected Error Happened');
    }
  }
}
