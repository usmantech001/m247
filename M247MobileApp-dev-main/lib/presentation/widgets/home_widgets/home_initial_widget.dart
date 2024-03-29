import 'package:flutter/material.dart';
import 'package:masjid/core/exports.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:masjid/controllers/favorite_controller.dart';
import 'package:masjid/core/extension/string_extension.dart';
import 'package:masjid/core/theme/app_theme.dart';
import 'package:masjid/data/models/favorite_model.dart';
import 'package:masjid/data/models/masjid_model.dart';
import 'package:masjid/presentation/logic/timepicker_bloc.dart';
import 'package:masjid/presentation/logic/timetable_bloc/timetable_bloc.dart';
import 'package:masjid/presentation/logic/timetable_bloc/timetable_event.dart';
import 'package:masjid/presentation/widgets/timetable_widget.dart/timetable_data_widget.dart';
import 'package:masjid/presentation/widgets/timetable_widget.dart/timetable_initial_widget.dart';

class HomeInitialWidget extends StatelessWidget {
  final PageController pageController;
  final DateTime dateTime;
  const HomeInitialWidget({
    super.key,
    required this.pageController,
    required this.dateTime,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FavoriteController>(
      builder: (controller) {
        if (controller.favMasjidList.isNotEmpty) {
          final data = controller.favMasjidList;
          return _Favorites(
            data: data,
            pageController: pageController,
            dateTime: dateTime,
          );
        }
        return const _EmptyWidget();
      },
    );
  }
}

class _Favorites extends StatelessWidget {
  final List<FavoriteModel> data;
  final PageController pageController;
  final DateTime dateTime;
  const _Favorites({
    required this.data,
    required this.pageController,
    required this.dateTime,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: data.length,
      padding: EdgeInsets.only(left: 15.w, right: 15.w, bottom: 15.h),
      itemBuilder: (_, index) {
        return _MasjidTile(
          dateTime: dateTime,
          index: index,
          masjid: data[index].masjid,
          pageController: pageController,
        );
      },
    );
  }
}

class _EmptyWidget extends StatelessWidget {
  const _EmptyWidget();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 100.h),
        Text(
          "Add masjid of your choice",
          style: TextStyle(
            fontSize: 22.sp,
            color: AppColor.brownColor,
            fontWeight: FontWeight.w600,
            fontFamily: AppTheme.SFProFont,
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          "Use the search bar ",
          style: TextStyle(
            fontSize: 16.sp,
            color: AppColor.greyTextColor,
            fontWeight: FontWeight.w600,
            fontFamily: AppTheme.SFProFont,
          ),
        ),
        SizedBox(height: 4.h),
      ],
    );
  }
}

class _MasjidTile extends StatefulWidget {
  final PageController pageController;
  final int? index;
  final MasjidModel? masjid;
  final DateTime dateTime;
  const _MasjidTile(
      {this.index,
      this.masjid,
      required this.pageController,
      required this.dateTime});

  @override
  State<_MasjidTile> createState() => _MasjidTileState();
}

class _MasjidTileState extends State<_MasjidTile> {
  late TimetableBloc timetable;

  @override
  void initState() {
    super.initState();
    timetable = TimetableBloc()..add(GetTimetableEvent(widget.masjid!.id));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => timetable,
      child: BlocListener<TimePickerBloc, DateTime?>(
        listener: (context, state) {
          if (state != null) {
            timetable
                .add(GetTimetableDateEvent(id: widget.masjid!.id, date: state));
          }
        },
        child: Padding(
          padding: EdgeInsets.only(bottom: 10.h),
          child: Container(
            width: 374.w,
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                side: const BorderSide(width: 1, color: Color(0xFFEBEEF1)),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Material(
              type: MaterialType.transparency,
              child: InkWell(
                onTap: () {
                  //  go to masjid
                  Navigator.pushNamed(context, RouteGenerator.masjid,
                      arguments: {
                        'masjidmodel': widget.masjid,
                        'pagecontroller': widget.pageController
                      });
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 15.w, right: 15.w, top: 5),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CachedNetworkImage(
                            height: 42.h,
                            width: 42.w,
                            imageUrl: widget.masjid!.id.toString().toDevLogo(),
                            imageBuilder: (context, imageProvider) {
                              return Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    image: imageProvider,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              );
                            },
                            placeholder: (_, url) =>
                                AnimatedShimmer.round(size: 42.w),
                            errorWidget: (context, url, err) {
                              return Container(
                                decoration:
                                    const BoxDecoration(shape: BoxShape.circle),
                                child: Center(
                                  child: SvgPicture.asset(
                                    AssetConstants.defaults,
                                    fit: BoxFit.scaleDown,
                                  ),
                                ),
                              );
                            },
                          ),
                          SizedBox(width: 8.w),
                          SizedBox(
                            width: 220.w,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Text(
                                    widget.masjid!.name!,
                                    style: TextStyle(
                                      fontSize: 22.sp,
                                      fontFamily: 'QueenFont',
                                      color: AppColor.brownColor,
                                      height: 22.0.toFigmaHeight(24),
                                      fontVariations: const [
                                        FontVariation('wght', 700),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 8.w),
                          GetBuilder<FavoriteController>(
                              builder: (favouriteController) {
                            return IconButton(
                              onPressed: () {
                                // remove favorite
                                favouriteController
                                    .removeFromFavourite(widget.masjid!);
                              },
                              icon: const Icon(Icons.star_rounded),
                            );
                          })
                        ],
                      ),
                    ),
                    SizedBox(height: 12.h),
                    BlocBuilder<TimetableBloc, FutureState>(
                      builder: (context, state) {
                        return state.when(
                          idle: () => const TimetableInitialWidget(),
                          loading: () => const TimetableInitialWidget(),
                          failed: (err) => const TimetableInitialWidget(),
                          data: (data) => TimetableDataWidget(
                            snapshot: data,
                            dateTime: widget.dateTime,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
