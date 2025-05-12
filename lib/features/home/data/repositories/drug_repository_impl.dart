import '../../../../core/core.dart';
import '../../domain/entities/drug.dart';
import '../../domain/repositories/drug_repository.dart';
import '../data.dart';

class DrugRepositoryImpl implements DrugRepository {
  final ApiServicesDrug apiServicesDrug;

  DrugRepositoryImpl(this.apiServicesDrug);

  @override
  Future<List<Drug>> getDrugs(int page, int size,
      {String? search, bool? inStock, String? sortBy}) async {
    try {
      return await apiServicesDrug.getDrugs(page, size,
          search: search, inStock: inStock, sortBy: sortBy);
    } on ServerException catch (e) {
      throw Exception(e.message);
    }
  }
}
