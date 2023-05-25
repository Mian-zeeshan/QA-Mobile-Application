import 'package:flutter/foundation.dart';

class LoginProvider with ChangeNotifier {
  //Todo:this function use for gettingand setting crunnt login user name
  String? _loginUserName;
  String? get loginUserName => _loginUserName;

  void setLoginUserName(value) {
    _loginUserName = value;
    notifyListeners();
  }
//Todo:this function use for getting and setting crunnt login user name
  String? _loginUserRole;
  String? get loginUserRole => _loginUserRole;

  void setLoginUserRole(value) {
    _loginUserRole = value;
    notifyListeners();
  }
  
 //Todo:this function use for getting crunnt  login user id
  String? _currentUserId;

  String? get crunntUserId => _currentUserId;

  setCurrentUserId(String val) {
    _currentUserId = val;
    notifyListeners();
  }


  String? _assignmentId;
  String? get assignmentId => _assignmentId;

  void setassignmentId(value) {
    _assignmentId = value;
    notifyListeners();
  }

    bool _isLogin=false;
 bool get isLogin => _isLogin;

 void setIsLogin( value) {_isLogin = value;
 notifyListeners();
 }


}
