import 'package:flutter/material.dart';

class HmMoreList extends StatefulWidget {
  HmMoreList({Key? key}) : super(key: key);

  @override
  _HmMoreListState createState() => _HmMoreListState();
}

class _HmMoreListState extends State<HmMoreList> {
  @override
  Widget build(BuildContext context) {
    // 必须是sliver家族的组件
    return SliverGrid.builder(
    // 网格是两列
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 0.8,
      ),
      itemBuilder: (context, index) => Container(
        color: Colors.blue,
        alignment: Alignment.center,
        child: Text('更多商品$index', style: TextStyle(fontSize: 20, color: Colors.white)),
      ),
    );
  }
}
