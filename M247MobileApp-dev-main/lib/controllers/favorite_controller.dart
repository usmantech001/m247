import 'package:get/get.dart';
import 'package:masjid/data/models/favorite_model.dart';
import 'package:masjid/data/models/masjid_model.dart';
import 'package:masjid/data/models/timetable_model.dart';
import 'package:masjid/presentation/widgets/snackbar.dart';
import 'package:masjid/repo/favorite_repo.dart';

class FavoriteController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  //  favouriteRepo.remove();
  }
  FavouriteRepo favouriteRepo;
  FavoriteController({required this.favouriteRepo});
  bool isFavorite = false;

  Map<int, FavoriteModel> _favoriteMasjidList = {};
  Map<int, FavoriteModel> get favoriteItems => _favoriteMasjidList = {};
  List<FavoriteModel> storedFavItems = [];
  int itemLenght = 0;

  addToFavourite(MasjidModel masjid, TimetableModel timetable) {
    if (existInFavourite(
          masjid,
        ) ==
        false) {
      _favoriteMasjidList.putIfAbsent(masjid.id!, () {
        return FavoriteModel(
            id: masjid.id, masjid: masjid, timetable: timetable, dateTime: DateTime.now().toString());
      });
      showSnackBar(title: 'Added', text: '${masjid.name} Added to favourite');
      getItemsLenght();

      isFavorite = true;
      update();
      favouriteRepo.saveFavouriteMasjid(favMasjidList);

      update();
    } else if (_favoriteMasjidList.containsKey(masjid.id)) {
      removeFromFavourite(masjid, timetable);

      update();
    }
    update();
  }

  removeFromFavourite(MasjidModel masjid, TimetableModel timetableModel) {
    _favoriteMasjidList.remove(masjid.id);
    _favoriteMasjidList.remove(timetableModel.id);

    showSnackBar(
        title: 'Removed', text: '${masjid.name} Removed From favourite');
    isFavorite = !isFavorite;
    getItemsLenght();
    favouriteRepo.saveFavouriteMasjid(favMasjidList);
    favMasjidList;
    update();
  }

  bool existInFavourite(
    MasjidModel masjid,
  ) {
    if (_favoriteMasjidList.containsKey(masjid.id)) {
      return true;
    } else {
      return false;
    }
  }

  getItemsLenght() {
    itemLenght = _favoriteMasjidList.length;
    update();
  }

  List<FavoriteModel> get favMasjidList {
    List<FavoriteModel> favList = [];
    _favoriteMasjidList.forEach((key, value) {
      favList.add(value);
    });
    return favList;
  }

  List<FavoriteModel> getSavedFavList() {
    setFavouritemList = favouriteRepo.getSavedFavList();
    return storedFavItems;
  }

  set setFavouritemList(List<FavoriteModel> favList) {
    storedFavItems = favList;
    for (int i = 0; i < storedFavItems.length; i++) {
      _favoriteMasjidList.putIfAbsent(
          storedFavItems[i].id!, () => storedFavItems[i]);
      getItemsLenght();
      update();
    }
  }
}
