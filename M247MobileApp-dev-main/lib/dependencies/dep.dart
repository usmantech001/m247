import 'package:get/get.dart';
import 'package:masjid/controllers/favorite_controller.dart';
import 'package:masjid/repo/favorite_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> init() async{
  final sharedPreferences = await SharedPreferences.getInstance();
  Get.lazyPut(() => FavouriteRepo(sharedPreferences: sharedPreferences));
  Get.lazyPut(() => FavoriteController(favouriteRepo: Get.find()));
}