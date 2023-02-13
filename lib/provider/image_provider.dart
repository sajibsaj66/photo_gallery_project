
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gallary_photo/model/model.dart';

import '../repository/repository.dart';

final galleryProvider = ChangeNotifierProvider((ref) => GalleyProvider());
class GalleyProvider extends ChangeNotifier{

  ImageModel?imageModel;
  Person? person;
  List<Product> favoriteList = [];
  List<int> favoriteId = [];
  Future<bool> galleryRepository()async{
    imageModel = await GalleryRepository.articleRepository();
    notifyListeners();
    return imageModel == null ? false: true;
  }
  setFavorite({required int id}){
    int index = imageModel!.products!.indexWhere((element) => element.id == id);
    if(index >= 0){
        if(favoriteId.contains(imageModel!.products![index].id)){
          favoriteId.remove(imageModel!.products![index].id);
          favoriteList.remove(imageModel!.products![index]);
          print("remove");
        }else{
          favoriteId.add(imageModel!.products![index].id!);
          favoriteList.add(imageModel!.products![index]);

          print("added");
        }
    }

    notifyListeners();
  }

  setPersonInfo({required Map<String,dynamic> json}){
    person = Person.fromJson(json);
    notifyListeners();
  }
}