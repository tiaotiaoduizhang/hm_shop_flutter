import 'package:flutter/material.dart';

class HmCategory extends StatefulWidget {
  HmCategory({Key? key}) : super(key: key);

  @override
  _HmCategoryState createState() => _HmCategoryState();
}

class _HmCategoryState extends State<HmCategory> {
  @override
  Widget build(BuildContext context) {
    // return ListView() 不能这样用，需要给高度
    return SizedBox(
      height: 100,
      // ListView.builder是 ListView 的“按需构建（lazy build）”用法：列表滚动到哪个位置，就只创建那一屏附近需要显示的子项，比一次性把所有 children 都创建出来更省内存、也更适合长列表
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 10,
        itemBuilder: (context, index) {
          return Container(
            alignment: Alignment.center,
            width: 80,
            height: 100,
            color: Colors.blue,
            child: Text('分类$index',style: TextStyle(color: Colors.white)),
            margin: EdgeInsets.symmetric(horizontal: 10),
          );
        },
     
      ),
    );
  }
}