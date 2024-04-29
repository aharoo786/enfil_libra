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
}
