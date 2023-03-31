import 'package:flutter/material.dart';

class GlobelProvider with ChangeNotifier {
  final List _isSelectedoption = [];
  List get isSelectedoption => _isSelectedoption;
  void addisSelectedoption(int value) {
    _isSelectedoption.add(value);
    notifyListeners();
  }

  void removeisSelectedoption(int value) {
    _isSelectedoption.remove(value);
    notifyListeners();
  }

  void clearisSelectedoption() {
    _isSelectedoption.clear();
    notifyListeners();
  }

  bool _isSelected = false;
  bool get isSelected => _isSelected;

  setisSelected(value) {
    _isSelected = value;

    notifyListeners();
  }

  //Todo:this function use changing the index for pages
  int _pageIndex = 0;

  int get pageIndex => _pageIndex;
  void setPageIndex(int value) {
    _pageIndex = value;
    notifyListeners();
  }

//useless code
  int? _modelDataIndex;
  int? get modelDataIndex => _modelDataIndex;
  void setmodelDataIndex(value) {
    _modelDataIndex = value;
    notifyListeners();
  }

  final List _rangeCheckBoxValue = [];

  List get rangeCheckBoxValue => _rangeCheckBoxValue;

  void addRangeCheckBoxValue(int value) {
    _rangeCheckBoxValue.add(value);
    notifyListeners();
  }

  void removeRangeCheckBoxValue(int value) {
    _rangeCheckBoxValue.remove(value);
    notifyListeners();
  }

  void clearRangeCheckBoxValue() {
    _rangeCheckBoxValue.clear();
    notifyListeners();
  }

  bool _expectedToggleValue = false;
  bool get expectedToggleValue => _expectedToggleValue;

  void setExpectedToggleValue(bool value) {
    _expectedToggleValue = value;

    notifyListeners();
  }

  final List<int> _saveNumericChecklistIndex = [];
  
  List<int> get saveNumericChecklistIndex => _saveNumericChecklistIndex;

  setsaveNumericChecklistIndex(value) {
    _saveNumericChecklistIndex.add(value);
   // notifyListeners();
  }

  final List<int> _saveBooleanChecklistIndex=[];
  List<int> get saveBooleanChecklistIndex => _saveBooleanChecklistIndex;

  setsaveBooleanChecklistIndex(value) {
    _saveBooleanChecklistIndex.add(value);
   // notifyListeners();
  }


final List<List<int>> _listOfOptionCheckList = [];
  List<List<int>> get listOfOptionCheckList => _listOfOptionCheckList;

  setValueInlistOfOptionCheckList() {
    _listOfOptionCheckList.add([0]);
   // notifyListeners();
  }

  removeValueFromlistOfOptionCheckList(int idex) {
    _listOfOptionCheckList[idex].removeAt(0);
    notifyListeners();
  }

  addIndexInSpecificIndexOfListOfOptionCheckList(int idex, int val) {
    _listOfOptionCheckList[idex].add(val);
    notifyListeners();
  }


final List<List<int>> _listOfBooleanChecklist = [];
  List<List<int>> get listOfBooleanChecklist => _listOfBooleanChecklist;

  setValueInlistOfBooleanChecklist() {
    _listOfBooleanChecklist.add([0]);
   // notifyListeners();
  }

  removeValueFromlistOfBooleanChecklist(int idex) {
    _listOfBooleanChecklist[idex].removeAt(0);
    notifyListeners();
  }

  addIndexInSpecificIndexOfListOfBooleanChecklist(int idex, int val) {
    _listOfBooleanChecklist[idex].add(val);
    notifyListeners();
  }

}
