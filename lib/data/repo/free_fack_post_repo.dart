import 'package:dio/dio.dart';

import '../model/free_fack_model.dart';




class FreeFakePostRepoDio {
  final Dio client;

  FreeFakePostRepoDio({required this.client});

  Future<List<FreeFakePostModel>> fetchPosts() async {
    try {
      final response = await client.get(
        "https://freefakeapi.io/api/posts",
        queryParameters: {"limit": 6},
        onReceiveProgress: (count, total) {
          print("count:$count");
        },
        options: Options(
          receiveTimeout: Duration(seconds: 5),
          headers: {'content-type': 'application/json'},
        ),
      );
      final List responseData = response.data;
      final result = responseData.map((e) {
        return FreeFakePostModel.fromJson(e);
      }).toList();
      return result;
    } on DioException catch (e) {
      print(e.message);
      print(e.stackTrace);
      return [];
    } catch (e, s) {
      print(e);
      print(s);
      return [];
    }
  }
}
