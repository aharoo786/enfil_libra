import 'dart:io';

import 'package:get/get_connect/http/src/response/response.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';

import '../../../UI/values/constants.dart';
import '../../api_provider/api_provider.dart';

class ChallengeRepo extends GetxService {
  ApiProvider apiProvider;

  ChallengeRepo({
    required this.apiProvider,
  });

  Future<Response> getChallengesRepo({required String accessToken}) async {
    return await apiProvider.getData(Constants.getChallenges, headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $accessToken"
    });
  }
  Future<Response> getUserChallengesRepo({required String accessToken}) async {
    return await apiProvider.getData(Constants.getUserChallenges, headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $accessToken"
    });
  }
  Future<Response> addUserChallengeRepo({required Map<String, dynamic> formData,required String accessToken}) async {
    // int contentLength = utf8.encode(formData).length;
    return await apiProvider
        .setFormData(url: Constants.addChallenge, formData: formData, headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $accessToken"
    });
  }

}
