
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
  static const String BANNER_LIST = '/home/banner';
}
//