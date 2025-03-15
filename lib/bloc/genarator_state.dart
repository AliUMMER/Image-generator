part of 'genarator_bloc.dart';

@immutable
sealed class GenaratorState {}

class GenaratorInitial extends GenaratorState {}

class GenaratorBlocLoading extends GenaratorState {}

class GenaratorBlocLoaded extends GenaratorState {}

class GenaratorBlocError extends GenaratorState {}
