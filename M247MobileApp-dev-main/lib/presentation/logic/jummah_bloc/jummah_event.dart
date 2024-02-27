import 'package:flutter/material.dart';

@immutable
abstract class JummahEvent {
  const JummahEvent();
}

class JummahInitialEvent extends JummahEvent {
  final String? keyword;
  const JummahInitialEvent(this.keyword);
}

class JummahDateEvent extends JummahEvent {
  final DateTime? date;
  final String? keyword;

  const JummahDateEvent({
    required this.date,
    required this.keyword,
  });
}
