import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LoadingDialog{
  // 打开 CircularProgressIndicator是 Flutter Material 里自带的 加载动画组件 （转圈圈），用来表示“正在进行中/等待中”。
   static void show(BuildContext context,{String? message="加载中..."}){
      showDialog(context: context, builder: (context)=>Dialog(
         backgroundColor: Colors.transparent,
         child:Center(
           child: Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 10,),
                Text(message!),
              ],
            ),
           ),
         )

      ));
   }
   // 关闭
   static void hide(BuildContext context){
      Navigator.pop(context);
   }
}