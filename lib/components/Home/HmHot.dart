import 'package:flutter/material.dart';

class HmHot extends StatefulWidget {
  HmHot({Key? key}) : super(key: key);

  @override
  _HmHotState createState() => _HmHotState();
}

class _HmHotState extends State<HmHot> {
  @override
  Widget build(BuildContext context) {
    return Container(
       child: Column(
         children: [
           Container(
             height: 100,
             color: Colors.blue,
             alignment: Alignment.center,
             child: Text('热门商品', style: TextStyle(fontSize: 20, color: Colors.white)),
           ),
         ],
       ),
    );
  }
}