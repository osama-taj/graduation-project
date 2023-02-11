import 'dart:math';

import 'package:get/get.dart';

validInput(String val, int min, int max, String type) {
  if (val.isEmpty) {
    return "لايمكن ان يكون الحقل فارغ";
  }

  if (type == "username") {
    if (!GetUtils.isUsername(val)) {
      return "الاسم غير متاح";
    }
  }
  if (type == "email") {
    if (!GetUtils.isEmail(val)) {
      return "الايميل غير متاح";
    }
  }

  if (type == "phone") {
    if (!GetUtils.isPhoneNumber(val)) {
      return "الرقم غير متاح";
    }
  }
  if (type == "number") {
    if (!GetUtils.isNum(val)) {
      return "يجب ادخال ارقام فقط";
    }
  }
  if (type == "text") {
    if (!GetUtils.isTxt(val)) {
      return " غير متاح";
    }
  }
  if (val.length < min) {
    return "لايمكن ان يكون اصغر من $min";
  }

  if (val.length > max) {
    return "لايمكن ان يكون اكبر من $max";
  }
}

//confirm pasword---------------------------
confirmpasswordv(String? value, password) {
  if (value != password)
    return " يجب أن تكون كلمة السر مطابقة لكلمة السر السابقة";
}

String round(double value, int places) {
  num mod = pow(10.0, places);
  double d = (value * mod).round().toDouble() / mod;
  String no = d.toString();
  return no;
}
