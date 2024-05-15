import 'dart:io';

import 'package:get/get_connect/http/src/response/response.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';

import '../../../UI/values/constants.dart';
import '../../api_provider/api_provider.dart';

class HabitRepo extends GetxService {
  ApiProvider apiProvider;

  HabitRepo({
    required this.apiProvider,
  });

  Future<Response> getCategoriesRepo({required String accessToken}) async {
    return await apiProvider.getData(Constants.getCategories, headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $accessToken"
    });
  }
  Future<Response> getHabitsRepo({required String accessToken}) async {
    return await apiProvider.getData(Constants.habit, headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $accessToken"
    });
  }

  Future<Response> getHabitDetailsRepo({required String accessToken,required String habitId}) async {
    return await apiProvider.getData("${Constants.habit}/$habitId", headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $accessToken"
    });
  }
  Future<Response> createHabitRepo({required Map<String, dynamic> formData,required String accessToken}) async {
    // int contentLength = utf8.encode(formData).length;
    return await apiProvider
        .setFormData(url: Constants.habit, formData: formData, headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $accessToken"

    });
  }
}
