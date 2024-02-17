import 'dart:async';
import 'package:masjid/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:masjid/dependencies/dep.dart';
import 'package:masjid/di/get_it.dart' as get_it;

void main() async {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await init();
    unawaited(get_it.initialize());
    runApp(const MyApp());
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }, (error, stack) => debugPrint("runapp err $error"));
}
