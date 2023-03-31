part of 'inspection_bloc.dart';

@immutable
abstract class InspectionEvent {}

class InspectionPointsLoaded extends InspectionEvent {
  final String branchId;
  InspectionPointsLoaded({required this.branchId});
}
