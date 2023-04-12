import 'package:flutter/foundation.dart';

import '../models/branch_model.dart';
import '../screens/qa_walk.dart';

class BranchProvider with ChangeNotifier {
  //Decleared varibales

  String? _branchName;
  String? _branchId;

//Getter of the variables

  String? get branchName => _branchName;
  String? get branchId => _branchId;

//setter of the varibales

  setBranchName(String val) {
    _branchName = val;
    notifyListeners();
  }

  resetBranchNameId() {
    _branchName = null;
    _branchId = null;
    notifyListeners();
  }

  setBranchId(String val) {
    _branchId = val;
    notifyListeners();
  }

  List<ChartData> _chartData = [];
  List<ChartData> get chartData => _chartData;

  void setChartData(value) {
    _chartData.add(value);
    notifyListeners();
  }

  int _walkPagesIndex = 0;
  int get walkPagesIndex => _walkPagesIndex;

  void setWalkPagesIndex(int value) {
    _walkPagesIndex = value;

    notifyListeners();
  }

  final List<BranchModel> _branchDetail = [];
  List<BranchModel> get branchDetail => _branchDetail;

  void setBranchDetail(value) {
    _branchDetail.add(value);
    notifyListeners();
  }

  void clearBranchDetail(){
    _branchDetail.clear();
    notifyListeners();
  }
}
