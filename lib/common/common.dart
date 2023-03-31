import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

routeTo(Widget route, {required BuildContext context, bool clearStack = false, bool clearPreviousRoute = false}) {
  if (clearStack && !clearPreviousRoute || clearPreviousRoute && clearStack) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => route),);
  } else if (clearPreviousRoute && !clearStack) {
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => route));
  } else {
    Navigator.push(context, MaterialPageRoute(builder: (context) => route));
  }
}

printDebug(data) {
  if (kDebugMode) {
    print(
        '******************************\n*******************$data*******************\n*******************************');
  }
}
