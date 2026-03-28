// 基于Dio进行二次封装
import 'package:dio/dio.dart';
import 'package:hm_shop/constants/index.dart';

//全局配置类

//定义一个类，业务逻辑(统一拦截/成功判定/返回格式)
class DioRequest {
  final _dio = Dio(); //dio请求对象
  DioRequest() {
    _dio.options
      ..baseUrl = GlobalConstants
          .BASE_URL // 所有请求的基础地址（Base URL）
      ..connectTimeout =
          Duration(seconds: GlobalConstants.TIME_OUT) // 连接超时：建立连接的最长等待时间
      ..receiveTimeout =
          Duration(seconds: GlobalConstants.TIME_OUT) // 接收超时：等待响应数据的最长时间
      ..sendTimeout = Duration(
        seconds: GlobalConstants.TIME_OUT,
      ); // 发送超时：发送请求数据的最长时间
    // 拦截器
    _addInterceptors();
  }
  /**
   * 添加拦截器
   * void 表示这个函数 不返回任何值 。
   * 方法名前面的 _ 表示 库私有
   */
  void _addInterceptors() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          // 在请求发送前做一些事情
          handler.next(options);
        },
        onResponse: (response, handler) {
          // 在响应返回前做一些事情 HTTP状态码200 300
          if (response.statusCode! >= 200 && response.statusCode! < 300) {
            handler.next(response);
            return;
          }
          handler.reject(DioException(requestOptions: response.requestOptions));
        },
        onError: (error, handler) {
          // 在请求或响应错误时做一些事情
          handler.reject(error);
        },
      ),
    );
  }

  /**
  * 封装一个 GET 请求方法
  * @param url 请求的URL
  * @param queryParameters 请求的查询参数
  * @return 响应数据
   */

  Future<dynamic> get(String url, {Map<String, dynamic>? queryParameters}) {
    // 把这个 Future 交给 _handleResponse(...) 统一处理
    return _handleResponse(_dio.get(url, queryParameters: queryParameters));
  }

  //进一步处理返回结果的函数
  Future<dynamic> _handleResponse(Future<Response<dynamic>> task) async {
    try {
      // 等到请求完成，拿到 Response
      Response<dynamic> res = await task;
      final data = res.data as Map<String, dynamic>; //data才是我们真实的接口返回数据
      if (data['code'] == GlobalConstants.SUCCESS_CODE) {
        // 才认定http状态和业务均正常，可以正常的放行通过
        return data['result']; //只要result数据
      }
      throw Exception(data['msg'] ?? '请求失败'); // 抛出异常，让调用者处理
    } catch (e) {
      throw Exception(e); // 抛出异常，让调用者处理
    }
  }
}

//单列对象(小写)
final dioRequest = DioRequest();

//dio请求工具发出请求 返回的数据Response<dynamic>.data
//把多有的接口的data解放出来，拿到真正的数据，要判断业务状态码是不是等于1
// Future<Response> 表示返回的是一个异步操作，等待请求完成，返回一个 Response 对象
// await task 把 Future<Response> 变成真正的 Response 。
//res.data as Map<String, dynamic> 假设所有接口返回体都是对象结构 { code, msg, result } 。如果某个接口直接返回数组/字符串，这里会类型转换失败并抛异常。
//throw Exception(e) ：会把原始异常包一层，堆栈信息可能没那么直观；但“向上抛，让调用者处理”的思路是对的。