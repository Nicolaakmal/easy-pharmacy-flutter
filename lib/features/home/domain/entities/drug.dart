import 'package:equatable/equatable.dart';

class Drug extends Equatable {
  final int id;
  final String image;
  final String name;
  final String description;
  final String dose;
  final String drugClass;
  final String drugFactory;
  final String drugType;
  final int price;
  final int stock;
  final String packaging;

  Drug({
    required this.id,
    required this.image,
    required this.name,
    required this.description,
    required this.dose,
    required this.drugClass,
    required this.drugFactory,
    required this.drugType,
    required this.price,
    required this.stock,
    required this.packaging,
  });

  @override
  List<Object?> get props => [
        id,
        image,
        name,
        description,
        dose,
        drugClass,
        drugFactory,
        drugType,
        price,
        stock,
        packaging,
      ];
}
