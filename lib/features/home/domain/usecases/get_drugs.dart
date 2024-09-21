import '../domain.dart';

class GetDrugs {
  final DrugRepository repository;

  GetDrugs(this.repository);

  Future<List<Drug>> call(int page, int size,
      {String? search, bool? inStock, String? sortBy}) async {
    return await repository.getDrugs(page, size,
        search: search, inStock: inStock, sortBy: sortBy);
  }
}
