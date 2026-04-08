//自定义弹窗
import 'package:flutter/material.dart';

class ToastUtils {
  static void showToast( BuildContext context,String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(10),
        ),
        content: Text(msg??"加载成功", textAlign: TextAlign.center),
        width: 120,
        behavior: SnackBarBehavior.floating,
        duration: Duration(seconds: 2),
      ),
    );
  }
}
