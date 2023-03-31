import 'package:flutter/foundation.dart';



class CustomerProvider with ChangeNotifier {
  String? _customerName;
  String? _customerId;
  String? get customerName => _customerName;

  void setcustomerName(value) {
    _customerName = value;
    notifyListeners();
  }

  String? get customerId => _customerId;

  void setcustomerId(value) {
    _customerId = value;
    notifyListeners();
  }

  List<DataModel> _myList = [];
  List<DataModel> get myList => _myList;

  void setmyList(List<DataModel> value) {
    _myList = value;
    notifyListeners();
  }

  //Decleared varibales
}

class DataModel {
  final String adminName;
  final String customerId;

  const DataModel({
    required this.adminName,
    required this.customerId,
  });
}
