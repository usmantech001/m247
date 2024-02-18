import 'package:flutter/material.dart';
import 'package:masjid/core/exports.dart';
import 'package:masjid/core/extension/string_extension.dart';
import 'package:masjid/data/models/masjid_model.dart';
import 'package:masjid/presentation/logic/masjid_bloc/masjid_bloc.dart';
import 'package:masjid/presentation/logic/masjid_bloc/masjid_event.dart';
import 'package:masjid/presentation/logic/timetable_bloc/timetable_bloc.dart';
import 'package:masjid/presentation/logic/timetable_bloc/timetable_event.dart';
import 'package:masjid/presentation/widgets/common_widgets/date_time_widget.dart';
import 'package:masjid/presentation/widgets/masjid_widgets/masjid_intial_widget.dart';
import 'package:masjid/presentation/widgets/mosque_widgets/button_widget.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../widgets/masjid_widgets/masjid_data_widget.dart';

class Masjid extends StatelessWidget {
  final MasjidModel? masjid;
  final PageController pageController;

  const Masjid({
    super.key,
    required this.masjid,
    required this.pageController,
  });

  static final _controller = PageController();

  Future<void> _launchUrl(Uri url) async {
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    final masjidBloc = BlocProvider.of<MasjidBloc>(context);
    final timetableBloc = BlocProvider.of<TimetableBloc>(context);
    masjidBloc.add(GetMasjidEvent(masjid!.id!));
    timetableBloc.add(GetTimetableEvent(masjid!.id));
    return AnnotatedScaffold(
      body: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.topCenter,
            child: CachedNetworkImage(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.4,
              imageUrl: masjid!.id.toString().toDevImage(),
              imageBuilder: (context, imageProvider) {
                return Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: imageProvider, fit: BoxFit.cover),
                  ),
                  child: RoundedSvgButton(
                    icon: AssetConstants.question,
                    onPressed: () {
                      //
                    },
                  ),
                );
              },
              errorWidget: (context, url, err) {
                return Container(
                  decoration: const BoxDecoration(shape: BoxShape.circle),
                  child: Center(
                    child: SvgPicture.asset(
                      AssetConstants.defaults,
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                );
              },
            ),
          ),
          // SizedBox(height: 100,),
          DraggableScrollableSheet(
            initialChildSize: initialChildSize,
            minChildSize: minChildSize,
            maxChildSize: maxChildSize,
            builder: (BuildContext context, ScrollController scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.sp),
                    topRight: Radius.circular(20.sp),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 17.h),
                    Padding(
                      padding: EdgeInsets.only(left: 17.w),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 200.w,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Text(
                                masjid!.name!,
                                style: TextStyle(
                                  fontFamily: 'QueenFont',
                                  fontSize: 25.sp,
                                  color: AppColor.brownColor,
                                  fontVariations: const [
                                    FontVariation('wght', 675),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 12.w),
                          PopupMenuButton<String>(
                              icon: Container(
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColor.lightGreyColor2,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: SvgPicture.asset(
                                    AssetConstants.arrow,
                                    fit: BoxFit.scaleDown,
                                  ),
                                ),
                              ),
                              offset: const Offset(0, 40),
                              // Offset to display menu slightly below
                              itemBuilder: (BuildContext context) =>
                                  <PopupMenuEntry<String>>[
                                    PopupMenuItem(
                                      onTap: () {
                                        if (masjid!.tel1!.isNotEmpty &&
                                            masjid!.tel1 != null) {
                                          _launchUrl(Uri(
                                              scheme: 'tel',
                                              path: masjid!.tel1));
                                        }
                                      },
                                      height: 0,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Call",
                                              style: TextStyle(
                                                  fontSize: 17.sp,
                                                  letterSpacing: -0.4,
                                                  fontWeight: FontWeight.w400,
                                                  fontFamily: 'SFPro',
                                                  height:
                                                      17.0.toFigmaHeight(22)),
                                            ),
                                            SvgPicture.asset(
                                              AssetConstants.phone,
                                              fit: BoxFit.scaleDown,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const PopupMenuDivider(),
                                    PopupMenuItem(
                                      onTap: () {
                                        String? latitude = masjid!.latitude;
                                        String? longitude = masjid!.longitude;
                                        if ((latitude!.isNotEmpty &&
                                                latitude != null) &&
                                            (longitude!.isNotEmpty &&
                                                longitude != null)) {
                                          _launchUrl(Uri.parse(
                                              'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude'));
                                        }
                                      },
                                      height: 0,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Get Directions",
                                              style: TextStyle(
                                                  fontSize: 17.sp,
                                                  letterSpacing: -0.4,
                                                  fontWeight: FontWeight.w400,
                                                  fontFamily: 'SFPro',
                                                  height:
                                                      17.0.toFigmaHeight(22)),
                                            ),
                                            SizedBox(width: 60.w),
                                            SvgPicture.asset(
                                              AssetConstants.map,
                                              fit: BoxFit.scaleDown,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    PopupMenuDivider(
                                      height:
                                          masjid!.whatsAppLink != null ? 16 : 0,
                                    ),
                                    PopupMenuItem(
                                      onTap: () {
                                        if (masjid!.whatsAppLink!.isNotEmpty &&
                                            masjid!.whatsAppLink != null) {
                                          final url = masjid!.whatsAppLink;
                                          _launchUrl(Uri.parse(url!));
                                        }
                                      },
                                      height: 0,
                                      child: masjid!.whatsAppLink != null
                                          ? Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    'WhatsApp',
                                                    style: TextStyle(
                                                        fontSize: 17.sp,
                                                        letterSpacing: -0.4,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontFamily: 'SFPro',
                                                        height: 17.0
                                                            .toFigmaHeight(22)),
                                                  ),
                                                  SvgPicture.asset(
                                                    AssetConstants.whatsapp,
                                                    fit: BoxFit.scaleDown,
                                                  ),
                                                ],
                                              ),
                                            )
                                          : Container(),
                                    ),
                                  ]),
                          const Spacer(),
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: SvgPicture.asset(
                                AssetConstants.close,
                                fit: BoxFit.scaleDown,
                                height: 24.h,
                                width: 24.h,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          masjid!.audioStream != null
                              ? SvgButton(
                                  icon: AssetConstants.audio,
                                  onPressed: () async {
                                    // open audio link
                                    final url = masjid!.audioStream;
                                    if (url != null && url.isNotEmpty) {
                                      _launchUrl(Uri.parse(url));
                                    }
                                  },
                                )
                              : Container(
                                  width: 0,
                                ),
                          SizedBox(
                              width: masjid!.audioStream != null ? 15.w : 0.w),
                          masjid!.youtube != null && masjid!.youtube!.isNotEmpty
                              ? SvgButton(
                                  icon: AssetConstants.video,
                                  onPressed: () async {
                                    // open video link
                                    final url = masjid!.youtube;
                                    if (url != null && url.isNotEmpty) {
                                      _launchUrl(Uri.parse(url));
                                    }
                                  },
                                )
                              : Container(),
                          SizedBox(
                            width: masjid!.youtube != null ? 15.w : 0.w,
                          ),
                          masjid!.transmitter != null &&
                                  masjid!.transmitter!.isNotEmpty
                              ? SvgTextButton(
                                  text: "${masjid!.transmitter}",
                                  icon: AssetConstants.satelite,
                                  onPressed: () {
                                    // ask for details
                                  },
                                )
                              : Container()
                        ],
                      ),
                    ),
                    SizedBox(height: 17.h),
                    Expanded(
                      child: SingleChildScrollView(
                        controller: scrollController,
                        scrollDirection: Axis.vertical,
                        child: Column(
                          children: [
                            DateTimeWidget(
                              isFromHome: false,
                              controller: _controller,
                              dateTime: DateTime.now(),
                              onSelected: (value) {
                                timetableBloc.add(GetTimetableDateEvent(
                                    id: masjid!.id, date: value));
                              },
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 15.w, vertical: 12.h),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: 140.w,
                                    child: Text(
                                      "SALAAH",
                                      style: TextStyle(
                                        fontFamily: 'SFPro',
                                        fontSize: 11.sp,
                                        color: AppColor.brownColor,
                                        height: 11.0.toFigmaHeight(20),
                                        fontVariations: const [
                                          FontVariation('wght', 700),
                                          // Adjust the weight variation
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 135.w,
                                    child: Text(
                                      "BEGINNING",
                                      style: TextStyle(
                                        fontFamily: 'SFPro',
                                        fontSize: 11.sp,
                                        color: AppColor.brownColor,
                                        height: 11.0.toFigmaHeight(20),
                                        fontVariations: const [
                                          FontVariation('wght', 700),
                                          // Adjust the weight variation
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.only(right: 20.w),
                                      child: Text(
                                        "JAMAT",
                                        style: TextStyle(
                                          fontFamily: 'SFPro',
                                          fontSize: 11.sp,
                                          color: AppColor.brownColor,
                                          height: 11.0.toFigmaHeight(20),
                                          fontVariations: const [
                                            FontVariation('wght', 700),
                                            // Adjust the weight variation
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            AnimatedSwitcher(
                              duration: kDuration,
                              child: BlocBuilder<TimetableBloc, FutureState>(
                                builder: (context, state) {
                                  return state.when(
                                    idle: () => const MasjidInitialWidget(),
                                    loading: () => const MasjidInitialWidget(),
                                    data: (data) => MasjidDataWidget(
                                        snapshot: data,
                                        pagecontroller: _controller),
                                    failed: (err) => const CustomErrorWidget(
                                      error:
                                          'No internet connection, please connect to the internet',
                                    ),
                                  );
                                },
                              ),
                            ),

                          /*  SizedBox(height: 19.h),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 40.w),
                              child: Center(
                                child: Text(
                                  "The masjid is at the heart of London and can accomodate large amount of people.",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontFamily: 'SF Pro',
                                    fontWeight: FontWeight.w400,
                                    color: AppColor.greyTextColor,
                                  ),
                                ),
                              ),
                            ), */
                             
                            //SizedBox(height: 100.h),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
