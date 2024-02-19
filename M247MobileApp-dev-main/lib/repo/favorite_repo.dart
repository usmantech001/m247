import 'dart:convert';
import 'package:get/get.dart';
import 'package:masjid/core/constants/app_constant.dart';
import 'package:masjid/data/models/favorite_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavouriteRepo extends GetxService {
  SharedPreferences sharedPreferences;
  FavouriteRepo({required this.sharedPreferences});
  List<String> favMasjidLists = [];

  saveFavouriteMasjid(List<FavoriteModel> favList) {
    favMasjidLists = [];
    for (var e in favList) {
      favMasjidLists.add(jsonEncode(e.toJson()));
    }
    sharedPreferences.setStringList(SAVE_FAV_MASJID_LIST, favMasjidLists);
  }

  List<FavoriteModel> getSavedFavList() {
    List<FavoriteModel> favouriteList = [];
    List<String> favList = [];
    if (sharedPreferences.containsKey(SAVE_FAV_MASJID_LIST)) {
      favList = sharedPreferences.getStringList(SAVE_FAV_MASJID_LIST)!;
    }
    for (var e in favList) {
      favouriteList.add(FavoriteModel.fromJson(jsonDecode(e)));
    }
    return favouriteList;
  }
  remove(){
    sharedPreferences.remove(SAVE_FAV_MASJID_LIST);
  }
}
