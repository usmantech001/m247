import 'package:masjid/di/get_it.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masjid/data/models/favorite_model.dart';
import 'package:masjid/domain/local_storage/key_value_storage.dart';

class FavoriteCubit extends Cubit<List<FavoriteModel>> {
  FavoriteCubit() : super(<FavoriteModel>[]);

  final fav = sl<KVStorage>();
}
