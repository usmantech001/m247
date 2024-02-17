import 'package:flutter/material.dart';

@immutable
abstract class JummahEvent {
  const JummahEvent();
}

class JummahInitialEvent extends JummahEvent {
  const JummahInitialEvent();
}

class JummahDateEvent extends JummahEvent {
  final DateTime? date;
  final String? keyword;

  const JummahDateEvent({
    required this.date,
    required this.keyword,
  });
}
