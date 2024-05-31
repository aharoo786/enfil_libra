import 'dart:io';

import 'package:get/get_connect/http/src/response/response.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';

import '../../../UI/values/constants.dart';
import '../../api_provider/api_provider.dart';

class HomeRepo extends GetxService {
  ApiProvider apiProvider;

  HomeRepo({
    required this.apiProvider,
  });

  Future<Response> getUpcomingRewardsRepo({required String accessToken}) async {
    return await apiProvider.getData(Constants.getUpcomingRewards, headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $accessToken"
    });
  }

  Future<Response> getUserStreakRepo({required String accessToken}) async {
    return await apiProvider.getData(Constants.getUserStreak, headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $accessToken"
    });
  }

  Future<Response> getOverviewRepo({required String accessToken}) async {
    return await apiProvider.getData(Constants.getOverview, headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $accessToken"
    });
  }

  Future<Response> getUsersRewardsRepo({required String accessToken}) async {
    return await apiProvider.getData(Constants.getUsersRewards, headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $accessToken"
    });
  }

  Future<Response> getRecentTasksRepo({required String accessToken}) async {
    return await apiProvider.getData(Constants.getRecentTasks, headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $accessToken"
    });
  }
}
