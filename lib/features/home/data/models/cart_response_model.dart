class CartResponseModel {
  final String message;

  CartResponseModel({required this.message});

  factory CartResponseModel.fromJson(Map<String, dynamic> json) {
    return CartResponseModel(
      message: json['message'],
    );
  }
}
