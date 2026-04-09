import 'package:flutter/material.dart';

/**
 * 全局的常量
 * static 关键字  static 在 Dart 里表示“ 静态成员 ”可以直接访问 GlobalConstants.BASE_URL  不需要创建对象
 * 静态字段： static String token = ''
 * 静态常量： static const int TIME_OUT = 10
 * 静态方法： static String buildUrl(String path) =>
 * const  关键字 表示这是“编译期常量”（值在编译时就确定且不可变）
 */
class GlobalConstants {
  static const String BASE_URL = 'https://meikou-api.itheima.net'; //基础信息
  static const int TIME_OUT = 10; //超时时间
  static const String SUCCESS_CODE = '1'; //成功状态
}

//存放请求地址接口的常量
class HttpConstants {
  static const String BANNER_LIST = '/home/banner'; //轮播图数据
  static const String CATEGORY_LIST = '/home/category/head'; //分类数据
  static const String PRODUCT_LIST = '/hot/preference'; //特惠推荐
  static const String IN_VOGUE_LIST = "/hot/inVogue"; // 热榜推荐地址
  static const String ONE_STOP_LIST = "/hot/oneStop"; // 一站式推荐地址
  static const String RECOMMEND_LIST = "/home/recommend"; // 推荐列表
  static const String GUESS_LIST = "/home/goods/guessLike"; // 猜你喜欢
  static const String LOGIN = "/login"; // 登录请求地址
}
//1.请求地址有
//2.请求类型是GoodsItems类型=> items=>List<GoodsItem>
//3.HmMoreList要的是List<GoodDetailItem>类型
