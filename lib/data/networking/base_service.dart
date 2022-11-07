import 'package:get/get.dart';
import 'package:get_jadwal/data/values/strings.dart';

class BaseService extends GetConnect {
  Future<Response<dynamic>> getRequest({required String url}) async {
    final data = await get(url);

    return data;
  }

  Future<Response<dynamic>> postRequest({required String url, required dynamic body}) async {
    final data = await post(url, body);

    return data;
  }

  Future<Response<dynamic>> patchRequest({required String url, required dynamic body}) async {
    final data = await patch(url, body);

    return data;
  }

  @override
  void onInit() {
    httpClient.baseUrl = Strings.baseUrl;

    super.onInit();
  }
}