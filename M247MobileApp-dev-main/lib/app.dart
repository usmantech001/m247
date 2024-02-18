import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:masjid/core/exports.dart';
import 'package:flutter/services.dart';
import 'package:masjid/core/theme/app_theme.dart';
import 'package:masjid/controllers/favorite_controller.dart';
import 'package:masjid/presentation/logic/favorite_bloc/favorite_bloc.dart';
import 'package:masjid/presentation/logic/jummah_bloc/jummah_bloc.dart';
import 'package:masjid/presentation/logic/masjid_bloc/masjid_bloc.dart';
import 'package:masjid/presentation/logic/timepicker_bloc.dart';
import 'package:masjid/presentation/logic/timetable_bloc/timetable_bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Get.find<FavoriteController>().getSavedFavList();

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarBrightness: Brightness.light,
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
    return ScreenUtilInit(
      designSize: const Size(393, 853),
      builder: (BuildContext context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider<HomeBloc>(create: (context) => HomeBloc()),
            BlocProvider<MasjidBloc>(create: (context) => MasjidBloc()),
            BlocProvider<JummahBloc>(create: (context) => JummahBloc()),
            BlocProvider<SpeechCubit>(create: (context) => SpeechCubit()),
            BlocProvider<FavoriteCubit>(create: (context) => FavoriteCubit()),
            BlocProvider<TimetableBloc>(create: (context) => TimetableBloc()),
            BlocProvider<TimePickerBloc>(create: (context) => TimePickerBloc()),
          ],
          child: GetMaterialApp(
            title: "Masjid247",
            theme: AppTheme.themeData,
            debugShowCheckedModeBanner: false,
            initialRoute: RouteGenerator.home,
            navigatorKey: RouteGenerator.navigatorKey,
            onGenerateRoute: RouteGenerator.generateRoute,
          ),
        );
      },
    );
  }
}
