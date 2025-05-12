import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../home.dart';

part 'drug_event.dart';
part 'drug_state.dart';

class DrugBloc extends Bloc<DrugEvent, DrugState> {
  final GetDrugs getDrugs;

  bool _inStockOnly = false;
  String _sortBy = '';
  List<Drug> _initialDrugs = [];

  DrugBloc(this.getDrugs) : super(DrugInitial()) {
    on<LoadDrugsEvent>(_onLoadDrugsEvent);
    on<SearchDrugsEvent>(_onSearchDrugsEvent);
    on<FilterDrugsEvent>(_onFilterDrugsEvent);
    on<SortDrugsEvent>(_onSortDrugsEvent);
  }

  // Event untuk memuat data obat.
  Future<void> _onLoadDrugsEvent(
      LoadDrugsEvent event, Emitter<DrugState> emit) async {
    final currentState = state;
    var oldDrugs = <Drug>[];
    if (currentState is DrugLoaded && event.page > 1) {
      oldDrugs = currentState.drugs;
    }

    emit(DrugLoading(oldDrugs, false));

    try {
      final newDrugs =
          await getDrugs(event.page, event.size, search: event.search);
      final drugs = oldDrugs + newDrugs;
      final hasReachedMax = newDrugs.isEmpty;

      _initialDrugs = List.from(drugs);

      emit(DrugLoaded(drugs, hasReachedMax));

      if (_inStockOnly) {
        add(FilterDrugsEvent(true));
      }

      if (_sortBy.isNotEmpty) {
        add(SortDrugsEvent(_sortBy));
      }
    } catch (e) {
      emit(DrugError('Failed to load drugs'));
    }
  }

  // Event untuk pencarian obat.
  Future<void> _onSearchDrugsEvent(
      SearchDrugsEvent event, Emitter<DrugState> emit) async {
    emit(DrugInitial());
    add(LoadDrugsEvent(1, event.size, search: event.keyword));
  }

  Future<void> _onFilterDrugsEvent(
      FilterDrugsEvent event, Emitter<DrugState> emit) async {
    _inStockOnly = event.inStock;

    final currentState = state;
    if (currentState is DrugLoaded) {
      final filteredDrugs = _inStockOnly
          ? currentState.drugs.where((drug) => drug.stock > 0).toList()
          : _initialDrugs;
      emit(DrugLoaded(filteredDrugs, currentState.hasReachedMax));
    }
  }

  Future<void> _onSortDrugsEvent(
      SortDrugsEvent event, Emitter<DrugState> emit) async {
    _sortBy = event.sortBy;

    final currentState = state;
    if (currentState is DrugLoaded) {
      List<Drug> sortedDrugs;
      if (_sortBy == 'name') {
        sortedDrugs = List.from(currentState.drugs)
          ..sort((a, b) => a.name.compareTo(b.name));
      } else if (_sortBy == 'name_desc') {
        // Sorting Z-A
        sortedDrugs = List.from(currentState.drugs)
          ..sort((a, b) => b.name.compareTo(a.name));
      } else if (_sortBy == 'stock') {
        sortedDrugs = List.from(currentState.drugs)
          ..sort((a, b) => b.stock.compareTo(a.stock));
      } else if (_sortBy == 'stock_asc') {
        // Sorting stock dari paling sedikit
        sortedDrugs = List.from(currentState.drugs)
          ..sort((a, b) => a.stock.compareTo(b.stock));
      } else {
        sortedDrugs = List.from(_initialDrugs);
      }
      emit(DrugLoaded(sortedDrugs, currentState.hasReachedMax));
    }
  }
}
