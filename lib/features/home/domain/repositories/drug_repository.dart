import '../entities/drug.dart';

abstract class DrugRepository {
  Future<List<Drug>> getDrugs(int page, int size,
      {String? search, bool? inStock, String? sortBy});
}
