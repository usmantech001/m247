import 'package:freezed_annotation/freezed_annotation.dart';

@immutable
abstract class MasjidEvent {
  const MasjidEvent();
}

class GetMasjidEvent extends MasjidEvent {
  final int id;

  const GetMasjidEvent(this.id);
}
