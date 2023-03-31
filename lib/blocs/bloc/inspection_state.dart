part of 'inspection_bloc.dart';

@immutable
abstract class InspectionState {}

class InspectionInitial extends InspectionState {}

class InspectionFetechedSuccessfull extends InspectionState {
  final dynamic data;
  InspectionFetechedSuccessfull({required this.data});
}

class InspectionInProgress extends InspectionState {}

class InspectionFailed extends InspectionState {
  final String message;
  InspectionFailed({required this.message});
}
