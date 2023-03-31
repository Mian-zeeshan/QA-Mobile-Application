import 'package:flutter/foundation.dart';

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
}
