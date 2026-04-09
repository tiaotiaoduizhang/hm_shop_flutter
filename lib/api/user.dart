//登录接口api

import 'package:hm_shop/constants/index.dart';
import 'package:hm_shop/utils/DioRequest.dart';
import 'package:hm_shop/viewmodels/user.dart';

Future<UserInfo> lginApi(Map<String, dynamic> data) async {
  return UserInfo.fromJSON(
    await DioRequest().post(HttpConstants.LOGIN, data: data),
  );
}