import 'package:flutter/foundation.dart';

@immutable
abstract class HomeEvent {
  const HomeEvent();
}

class HomeEventGetMasjid extends HomeEvent {
  final String? keyword;

  const HomeEventGetMasjid(this.keyword);
}

class HomeDateEvent extends HomeEvent {
  final String? keyword;
  final DateTime? datetime;

  const HomeDateEvent({
    this.keyword,
    this.datetime,
  });
}
