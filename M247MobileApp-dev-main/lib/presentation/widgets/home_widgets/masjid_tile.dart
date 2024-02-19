import 'package:flutter/material.dart';
import 'package:masjid/core/exports.dart';
import 'package:get/get.dart';
import 'package:masjid/controllers/favorite_controller.dart';
import 'package:masjid/data/models/masjid_model.dart';
import 'package:masjid/data/models/timetable_model.dart';
import 'package:masjid/core/extension/string_extension.dart';
import 'package:masjid/presentation/logic/timepicker_bloc.dart';
import 'package:masjid/presentation/logic/timetable_bloc/timetable_bloc.dart';
import 'package:masjid/presentation/logic/timetable_bloc/timetable_event.dart';
import 'package:masjid/presentation/widgets/timetable_widget.dart/timetable_data_widget.dart';
import 'package:masjid/presentation/widgets/timetable_widget.dart/timetable_initial_widget.dart';

class MasjidTile extends StatelessWidget {
  final MasjidModel? masjid;
  final PageController controller;
  final DateTime dateTime;
  const MasjidTile({
    super.key,
    this.masjid,
    required this.controller,
    required this.dateTime
  });

  @override
  Widget build(BuildContext context) {
    final timetableBloc = BlocProvider.of<TimetableBloc>(context);
    return BlocListener<TimePickerBloc, DateTime?>(
      listener: (context, state) {
        if (state != null) {
          timetableBloc.add(GetTimetableDateEvent(id: masjid!.id, date: state));
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
                Navigator.pushNamed(context, RouteGenerator.masjid, arguments: {
                  'masjidmodel': masjid,
                  'pagecontroller': controller
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
                          imageUrl: masjid!.id.toString().toDevLogo(),
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Text(
                                  masjid!.name!,
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
                          return BlocBuilder<TimetableBloc, FutureState>(
                            builder: (context, state) {
                              if (state is DATA) {
                                return IconButton(
                                  onPressed: () {
                                    // add new favorite
                               
                                    final TimetableModel timetable = state.data;
                                    favouriteController.addToFavourite(
                                        masjid!, timetable, dateTime);
                                  },
                                  icon: favouriteController.existInFavourite(
                                            masjid!,
                                          ) ==
                                          true
                                      ? const Icon(
                                          Icons.star,
                                          color: AppColor.brownColor,
                                        )
                                      : const Icon(Icons.star_border_rounded),
                                );
                              }
                              return AnimatedShimmer.round(size: 30.w);
                            },
                          );
                        }),
                      ],
                    ),
                  ),
                  SizedBox(height: 12.h),
                  BlocBuilder<TimetableBloc, FutureState>(
                    builder: (context, state) {
                      return state.when(
                        idle: () => const TimetableInitialWidget(),
                        loading: () => const TimetableInitialWidget(),
                        data: (data) => TimetableDataWidget(snapshot: data, pagecontroller: controller,),
                        failed: (err) => CustomErrorWidget(error: err),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
