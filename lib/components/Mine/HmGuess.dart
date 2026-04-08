import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/**
 * SliverPersistentHeaderDelegate 说明它不是普通 Widget，而是“头部渲染规则”的委托（delegate）。
 *  shrinkOffset 当前已经滚动导致头部“收缩了多少”的距离
 * overlapsContent 头部是否与下面内容发生重叠
 * shouldRebuild 表示 delegate 不需要重建
 */
class HmGuess extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    // TODO: implement build
    return Container(
      alignment: Alignment.center,
      color: Colors.white,
      child: Text('猜你喜欢', style: TextStyle(fontSize: 20)),
    );
  }

  @override
  // TODO: implement maxExtent  头部展开最大60
  double get maxExtent => 60;

  @override
  // TODO: implement minExtent 头部收缩最小40
  double get minExtent => 40;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    // TODO: implement shouldRebuild
    return false;
  }
}
