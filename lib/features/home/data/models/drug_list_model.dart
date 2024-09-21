import '../../domain/entities/drug.dart';

class DrugModel extends Drug {
  DrugModel({
    required int id,
    required String image,
    required String name,
    required String description,
    required String dose,
    required String drugClass,
    required String drugFactory,
    required String drugType,
    required int price,
    required int stock,
    required String packaging,
  }) : super(
          id: id,
          image: image,
          name: name,
          description: description,
          dose: dose,
          drugClass: drugClass,
          drugFactory: drugFactory,
          drugType: drugType,
          price: price,
          stock: stock,
          packaging: packaging,
        );

  factory DrugModel.fromJson(Map<String, dynamic> json) {
    return DrugModel(
      id: json['id'],
      image: json['image'],
      name: json['name'],
      description: json['description'],
      dose: json['dose'],
      drugClass: json['drugClass'],
      drugFactory: json['drugFactory'],
      drugType: json['drugType'],
      price: json['price'],
      stock: json['stock'],
      packaging: json['packaging'],
    );
  }
}
