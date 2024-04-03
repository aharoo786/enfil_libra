// import 'dart:io';
//
// import 'package:get/get_connect/http/src/response/response.dart';
// import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';
//
// import '../../../values/constants.dart';
// import '../../api_provider/api_provider.dart';
//
// class HomeRepo extends GetxService {
//   ApiProvider apiProvider;
//
//   HomeRepo({
//     required this.apiProvider,
//   });
//
//   Future<Response> updateUser(
//       {required Map<String, dynamic> formData,
//       required String accessToken}) async {
//     // int contentLength = utf8.encode(formData).length;
//     return await apiProvider
//         .setFormData(url: Constants.getUser, formData: formData, headers: {
//       HttpHeaders.contentTypeHeader: "application/json",
//       HttpHeaders.authorizationHeader: "Bearer $accessToken"
//     });
//   }
//
//   Future<Response> searchCities({required String accessToken,required String city}) async {
//     // int contentLength = utf8.encode(formData).length;
//     return await apiProvider.getData(Constants.getProvinces, headers: {
//       HttpHeaders.contentTypeHeader: "application/json",
//       HttpHeaders.authorizationHeader: "Bearer $accessToken"
//     }, query: {
//       "search": city
//     });
//   }
//   Future<Response> addFavRepo({required String accessToken,required Map<String,dynamic> body}) async {
//     // int contentLength = utf8.encode(formData).length;
//     return await apiProvider.setFormData(url:Constants.addFav, headers: {
//       HttpHeaders.contentTypeHeader: "application/json",
//       HttpHeaders.authorizationHeader: "Bearer $accessToken"
//     }, formData: body);
//   }
//   Future<Response> removeFavRepo({required String accessToken,required Map<String,dynamic> body}) async {
//     // int contentLength = utf8.encode(formData).length;
//     return await apiProvider.setFormData(url:Constants.removeFav, headers: {
//       HttpHeaders.contentTypeHeader: "application/json",
//       HttpHeaders.authorizationHeader: "Bearer $accessToken"
//     }, formData: body);
//   }
//   Future<Response> getFavRepo({required String accessToken}) async {
//     // int contentLength = utf8.encode(formData).length;
//     return await apiProvider.getData(Constants.getFav, headers: {
//       HttpHeaders.contentTypeHeader: "application/json",
//       HttpHeaders.authorizationHeader: "Bearer $accessToken"
//     }
//     );
//   }
//
//   Future<Response> getUser({required String accessToken}) async {
//     // int contentLength = utf8.encode(formData).length;
//     return await apiProvider.getData(Constants.getUser, headers: {
//       HttpHeaders.contentTypeHeader: "application/json",
//       HttpHeaders.authorizationHeader: "Bearer $accessToken"
//     });
//   }
//
//   Future<Response> getCities({required String accessToken}) async {
//     // int contentLength = utf8.encode(formData).length;
//     return await apiProvider.getData(Constants.getCities, headers: {
//       HttpHeaders.contentTypeHeader: "application/json",
//       HttpHeaders.authorizationHeader: "Bearer $accessToken"
//     });
//   }
//
//   Future<Response> verifyEmail({required Map<String, dynamic> formData}) async {
//     // int contentLength = utf8.encode(formData).length;
//     return await apiProvider
//         .setFormData(url: Constants.otp, formData: formData, headers: {
//       HttpHeaders.contentTypeHeader: "application/json",
//     });
//   }
// }
