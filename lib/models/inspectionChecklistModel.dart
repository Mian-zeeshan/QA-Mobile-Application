import 'package:collection/collection.dart';

class InspectionChecklist {
  static List<int> saveNumericChecklistIndex = [];

  static int returnIndex(int val) {
    int index = saveNumericChecklistIndex.indexOf(val);
    return index;
  }

  static final List<CheckListModel> checkListAnswers = [];

//static
  static addDataIntoCheckListModelList(
      String questionId, bool isAnomaly, String answer, String assignmentId, String id, String recordDateTime) {
    var element = checkListAnswers.firstWhereOrNull((element) => element.checkPointId == questionId);
    element != null ? checkListAnswers.removeWhere((element) => element.checkPointId == questionId) : null;
    checkListAnswers.add(CheckListModel(
        checkPointId: questionId,
        isAnomaly: isAnomaly,
        value: answer,
        assignmentId: assignmentId,
        id: id,
        recordAt: recordDateTime));
  }
}

class CheckListModel {
  String? id;
  String? assignmentId;
  String? checkPointId;
  String? value;
  bool? isAnomaly;
  String? recordAt;
  CheckListModel(
      {required this.checkPointId,
      required this.value,
      required this.isAnomaly,
      required this.recordAt,
      required this.assignmentId,
      required this.id});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'assignmentId': assignmentId,
      'checkPointId': checkPointId,
      'value': value,
      'isAnomaly': isAnomaly,
      'recordAt': recordAt,
    };
  }

  factory CheckListModel.fromJson(Map<String, dynamic> json) {
    return CheckListModel(
      id: json['id'],
      assignmentId: json['assignmentId'],
      checkPointId: json['checkPointId'],
      value: json['value'],
      isAnomaly: json['isAnomaly'],
      recordAt: json['recordAt'],
    );
  }
}


class TaskCompleted{
String? assignmentId;
String? assignTo;

String? taskCompletedDate;
bool? taskCompleted;

TaskCompleted({
  required this.assignmentId,
  required this.assignTo,
  
  required this.taskCompletedDate,
  required this.taskCompleted,

});

  Map<String, dynamic> toMap() {
    return {
      'assignmentId': assignmentId,
      'assignTo': assignTo,
      
      'taskCompletedDate': taskCompletedDate,
      'taskCompleted': taskCompleted,
      
    };
  }


}