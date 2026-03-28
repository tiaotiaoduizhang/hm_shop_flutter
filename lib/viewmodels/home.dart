/**
 * Dart 数据模型写法
 * 1. 定义一个类
 * 2. 类中定义属性
 * 3. 类中定义构造函数
 * 4. 类中定义方法
 * 
 */

class BannerItem{
  String? id;
  String? imgUrl;
  BannerItem({required this.id,required this.imgUrl});
  // 扩展一个工厂函数 一般用factory来声明 一般用来创建实例
  factory BannerItem.fromJson(Map<String, dynamic> json) {
    // 必须返回一个BannerItem对象
    // 命名参数 + required 的写法
    // { ... } ：表示这是“命名参数”（named parameters），创建对象时必须写参数名，不按位置传参
    // required ：表示这个命名参数在调用时“必须传”，否则编译/运行前就会报错
    return BannerItem(id: json['id']??'', imgUrl: json['imgUrl']??'');
  }
}
//flutter必须强制转换 没有隐私转换，因为dart是强语言泛类型”数据（例如接口返回的 Map ）Map<String, dynamic>需要自己解析
