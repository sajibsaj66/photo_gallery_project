
import 'package:dio/dio.dart';

import '../dio_initialization/dio.dart';
import '../model/model.dart';

class GalleryRepository{
  static Future<ImageModel?> articleRepository()async{
    Response response;
    try{
      Dio dio = GetDio.getDio();
      response = await dio.get(baseUrl);
      if(response.statusCode == 200){
        return ImageModel.fromJson(response.data);
      }
    }catch(e){
      if(e is DioError){
        return null;
      }
    }
    return null;
  }
}