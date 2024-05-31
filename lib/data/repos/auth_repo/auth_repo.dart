import 'dart:io';
import 'package:get/get.dart';
import '../../../UI/values/constants.dart';
import '../../api_provider/api_provider.dart';

class AuthRepo extends GetxService {
  ApiProvider apiProvider;

  AuthRepo({
    required this.apiProvider,
  });

  Future<Response> signUpUserRepo(
      {required Map<String, dynamic> formData}) async {
    // int contentLength = utf8.encode(formData).length;
    return await apiProvider.setFormData(
        url: Constants.signUpPath,
        formData: formData,
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          "Accept": "application/json"
        });
  }

  Future<Response> loginRepo({required Map<String, dynamic> formData}) async {
    // int contentLength = utf8.encode(formData).length;
    return await apiProvider
        .setFormData(url: Constants.loginPath, formData: formData, headers: {
      HttpHeaders.contentTypeHeader: "application/json",
    });
  }

  Future<Response> socialLoginRepo(
      {required Map<String, dynamic> formData}) async {
    // int contentLength = utf8.encode(formData).length;
    return await apiProvider
        .setFormData(url: Constants.socialLogin, formData: formData, headers: {
      HttpHeaders.contentTypeHeader: "application/json",
    });
  }

  Future<Response> forgotPassword(
      {required Map<String, dynamic> formData}) async {
    // int contentLength = utf8.encode(formData).length;
    return await apiProvider.setFormData(
        url: Constants.forgotPassword,
        formData: formData,
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        });
  }

  Future<Response> verifyEmail({required Map<String, dynamic> formData}) async {
    // int contentLength = utf8.encode(formData).length;
    return await apiProvider
        .setFormData(url: Constants.otp, formData: formData, headers: {
      HttpHeaders.contentTypeHeader: "application/json",
    });
  }

  Future<Response> verifyEmailResetPassword(
      {required Map<String, dynamic> formData}) async {
    // int contentLength = utf8.encode(formData).length;
    return await apiProvider.setFormData(
        url: Constants.resetPasswordOtp,
        formData: formData,
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        });
  }

  Future<Response> resendOtpRepo(
      {required Map<String, dynamic> formData}) async {
    // int contentLength = utf8.encode(formData).length;
    return await apiProvider
        .setFormData(url: Constants.resendOtp, formData: formData, headers: {
      HttpHeaders.contentTypeHeader: "application/json",
    });
  }

  Future<Response> getUserProfile({required String accessToken}) async {
    return await apiProvider.getData(Constants.getUserProfile, headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      "Accept": "application/json",
      HttpHeaders.authorizationHeader: "Bearer $accessToken"
    });
  }

  Future<Response> updateUser(
      {required String accessToken, required Map<String, dynamic> map}) async {
    return await apiProvider.setFormDataImage(
        url: Constants.getUserProfile,
        formData: map,
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          "Accept": "application/json",
          HttpHeaders.authorizationHeader: "Bearer $accessToken"
        });
  }

  Future<Response> updatePasswordRepo(
      {required Map<String, dynamic> formData,
      required String accessToken}) async {
    // int contentLength = utf8.encode(formData).length;
    return await apiProvider.setFormData(
        url: Constants.updatePassword,
        formData: formData,
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.authorizationHeader: "Bearer $accessToken"
        });
  }
  Future<Response> sessionCheck({required String accessToken}) async {
    return await apiProvider.getData(Constants.session, headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $accessToken"
    });
  }
}
