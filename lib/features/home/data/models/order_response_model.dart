class OrderResponseModel {
  final String message;

  OrderResponseModel({required this.message});

  factory OrderResponseModel.fromJson(Map<String, dynamic> json) {
    return OrderResponseModel(
      message: json['message'],
    );
  }
}
