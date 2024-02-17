import 'dart:convert';
import 'package:masjid/data/models/favorite_model.dart';
import 'package:masjid/domain/local_storage/base_key_value_storage.dart';

class KVStorage {
  // base key value storage instance variable
  final BaseKVStorage _storage;

  KVStorage(this._storage);

  static const String favoriteKey = "favorites";

  Future<bool> setFavorite(FavoriteModel favorite) async {
    final favorites = await getFavorite();
    favorites.add(favorite);
    return await _storage.setCommon(favoriteKey, favorites);
  }

  Future<List<FavoriteModel>> getFavorite() async {
    List<FavoriteModel> favorites = [];
    final contains = await _storage.contain(favoriteKey);
    if (contains) {
      final result = _storage.getCommon<List<String>>(favoriteKey);
      for (var i in result ?? []) {
        final fav = FavoriteModel.fromJson(jsonDecode(i));
        favorites.add(fav);
      }
    }
    return favorites;
  }

  void reset() async {
    _storage.clearShared();
  }
}
