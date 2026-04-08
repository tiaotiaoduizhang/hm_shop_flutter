//自定义弹窗
import 'package:flutter/material.dart';

class ToastUtils {
  // 阀门控制
  static bool _isLoading = false;
  static void showToast(BuildContext context, String msg) {
    if (ToastUtils._isLoading) {
      return;
    }
    ToastUtils._isLoading = true;
    // Future.delayed(Duration(seconds: 2), callback) Dart 的异步定时器
    Future.delayed(Duration(seconds: 2), () {
      ToastUtils._isLoading = false;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(10),
        ),
        content: Text(msg, textAlign: TextAlign.center),
        width: 180,
        behavior: SnackBarBehavior.floating,
        duration: Duration(seconds: 2),
      ),
    );
  }
}
