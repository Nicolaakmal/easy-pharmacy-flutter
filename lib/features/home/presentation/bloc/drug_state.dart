part of 'drug_bloc.dart';

abstract class DrugState extends Equatable {
  @override
  List<Object> get props => [];
}

class DrugInitial extends DrugState {}

class DrugLoading extends DrugState {
  final List<Drug> drugs;
  final bool hasReachedMax;

  DrugLoading(this.drugs, this.hasReachedMax);

  @override
  List<Object> get props => [drugs, hasReachedMax];
}

class DrugLoaded extends DrugState {
  final List<Drug> drugs;
  final bool hasReachedMax;

  DrugLoaded(this.drugs, this.hasReachedMax);

  DrugLoaded copyWith({List<Drug>? drugs, bool? hasReachedMax}) {
    return DrugLoaded(
      drugs ?? this.drugs,
      hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [drugs, hasReachedMax];
}

class DrugError extends DrugState {
  final String message;

  DrugError(this.message);

  @override
  List<Object> get props => [message];
}
