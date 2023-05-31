part of 'global_cubit.dart';

abstract class GlobalState extends Equatable {
  const GlobalState();

  @override
  List<Object> get props => [DateTime.now().toIso8601String()];
}

class GlobalInitialState extends GlobalState {}

class GlobalFirstLunchState extends GlobalState {}

class GlobalLoadingState extends GlobalState {}

class GlobalSuccessState extends GlobalState {}

