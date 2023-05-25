import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import '../config/config.dart';
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

  List<AdminChartData> _adminChartData = [];
  List<AdminChartData> get adminChartData => _adminChartData;

  void setadminChartData(value) {
    _adminChartData.add(value);
    notifyListeners();
  }

  void clearadminChartData() {
    _adminChartData.clear();
    notifyListeners();
  }

//this getter and setter use for navigat walk pages
  int _walkPagesIndex = 0;
  int get walkPagesIndex => _walkPagesIndex;

  void setWalkPagesIndex(int value) {
    _walkPagesIndex = value;

    notifyListeners();
  }

  //getter and setter use getting the branch detail

  final List<BranchModel> _branchDetail = [];
  List<BranchModel> get branchDetail => _branchDetail;

  void setBranchDetail(value) {
    _branchDetail.add(value);
    notifyListeners();
  }

  void clearBranchDetail() {
    _branchDetail.clear();
    notifyListeners();
  }

  int? _branchTotalWalk;
  int? get branchTotalWalk => _branchTotalWalk;

  void setBranchTotalWalk(int? value) {
    _branchTotalWalk = value;

    notifyListeners();
  }

  int? _branchCompletedWalk;
  int? get branchCompletedWalk => _branchCompletedWalk;

  void setBranchCompletedWalk(int? value) {
    _branchCompletedWalk = value;

    notifyListeners();
  }
}

class AdminChartData {
  AdminChartData(this.x, this.y);
  final String x;
  final int y;
}
