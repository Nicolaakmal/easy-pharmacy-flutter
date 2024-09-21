part of 'drug_bloc.dart';

abstract class DrugEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadDrugsEvent extends DrugEvent {
  final int page;
  final int size;
  final String? search;

  LoadDrugsEvent(this.page, this.size, {this.search});

  @override
  List<Object> get props => [page, size, search ?? ''];
}

class SearchDrugsEvent extends DrugEvent {
  final String keyword;
  final int size;

  SearchDrugsEvent(this.keyword, this.size);

  @override
  List<Object> get props => [keyword, size];
}

class FilterDrugsEvent extends DrugEvent {
  final bool inStock;

  FilterDrugsEvent(this.inStock);

  @override
  List<Object> get props => [inStock];
}

class SortDrugsEvent extends DrugEvent {
  final String sortBy;

  SortDrugsEvent(this.sortBy);

  @override
  List<Object> get props => [sortBy];
}
