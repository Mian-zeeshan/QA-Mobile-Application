import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:kfccheck/common/common.dart';
import 'package:kfccheck/common/firebase_handler.dart';
import 'package:kfccheck/services/services.dart';
import 'package:meta/meta.dart';

part 'inspection_event.dart';
part 'inspection_state.dart';

class InspectionBloc extends Bloc<InspectionEvent, InspectionState> {
  InspectionBloc() : super(InspectionInitial()) {
    on<InspectionEvent>(_handleInspectionEvents);
  }

  Future<void> _handleInspectionEvents(InspectionEvent event, Emitter<InspectionState> emit) async {
    if (event is InspectionPointsLoaded) {
      try {
        emit(InspectionInProgress());
        var response = await locator.get<FirebaseHandler>().getInspectionPoints(event.branchId);
        print(response);
        emit(InspectionFetechedSuccessfull(data: response));
      } catch (e) {
        printDebug(e.toString());
        emit(InspectionFailed(message: e.toString()));
      }
    }
  }
}
