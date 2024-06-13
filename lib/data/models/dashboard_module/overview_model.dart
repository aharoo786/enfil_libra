OverviewModel overviewModelFromJson(Map<String, dynamic> json) =>
    OverviewModel.fromJson(json);

Map<String, dynamic> overviewModelToJson(OverviewModel data) => data.toJson();

class OverviewModel {
  final String status;
  final String message;
  final Map<String, dynamic> data;

  OverviewModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory OverviewModel.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic> data = {};
    if (json['data'] != null) {
      data = Map<String, dynamic>.from(json['data']);
    }
    return OverviewModel(
      status: json['status'],
      message: json['message'],
      data: data,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'data': data,
    };
  }
}
