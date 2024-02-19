import 'package:flutter/material.dart';
import 'package:masjid/core/exports.dart';
import 'package:masjid/core/constants/app_constant.dart' as cons;
import 'package:masjid/presentation/logic/jummah_bloc/jummah_bloc.dart';
import 'package:masjid/presentation/logic/jummah_bloc/jummah_event.dart';
import 'package:masjid/presentation/widgets/common_widgets/date_time_widget.dart';
import 'package:masjid/presentation/widgets/jummah_widgets/jummah_data_widget.dart';
import 'package:masjid/presentation/widgets/jummah_widgets/jummah_loading_widget.dart';

class Jummah extends StatelessWidget {
  final PageController pageController;
  const Jummah({
    super.key,
    required this.pageController,
  });

  static final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final jummahBloc = BlocProvider.of<JummahBloc>(context);
    jummahBloc.add(const JummahInitialEvent());
    return AnnotatedScaffold(
      body: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.topCenter,
            child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.4,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(AssetConstants.background),
                      fit: BoxFit.fill),
                ),
                child: RoundedSvgButton(
                  icon: AssetConstants.question,
                  onPressed: () {
                    //
                  },
                )),
          ),
          DraggableScrollableSheet(
            initialChildSize: cons.initialChildSize,
            minChildSize: cons.minChildSize,
            maxChildSize: cons.maxChildSize,
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
                          Text(
                            "Jummah Timings",
                            style: TextStyle(
                              fontFamily: 'QueenFont',
                              fontSize: 38.sp,
                              color: AppColor.brownColor,
                              height: 38.0.toFigmaHeight(40),
                              fontVariations: const [
                                FontVariation('wght', 675),
                              ],
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
                                height: 0,
                                child: InkWell(
                                  onTap: () {
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                    Navigator.pushNamed(
                                        context, RouteGenerator.home);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'My Masjids',
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.black,
                                              letterSpacing: -0.4,
                                              fontWeight: FontWeight.w400,
                                              fontFamily: 'SFPro',
                                              height: 17.0.toFigmaHeight(22)),
                                        ),
                                        SvgPicture.asset(
                                          AssetConstants.masjid,
                                          fit: BoxFit.scaleDown,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              const PopupMenuDivider(),
                              PopupMenuItem(
                                height: 0,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          SvgPicture.asset(
                                            AssetConstants.check,
                                            fit: BoxFit.scaleDown,
                                            width: 10,
                                            height: 10,
                                          ),
                                          SizedBox(width: 10.w),
                                          Text(
                                            'Jumma Timings',
                                            style: TextStyle(
                                                fontSize: 16,
                                                letterSpacing: -0.4,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w400,
                                                fontFamily: 'SFPro',
                                                height: 17.0.toFigmaHeight(22)),
                                          ),
                                        ],
                                      ),
                                      SizedBox(width: 50.w),
                                      SvgPicture.asset(
                                        AssetConstants.clock,
                                        fit: BoxFit.scaleDown,
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 14.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.w),
                      child: TextFormField(
                        controller: _controller,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Find Town",
                          prefixIcon: SvgPicture.asset(
                            AssetConstants.search,
                            fit: BoxFit.scaleDown,
                          ),
                          suffixIcon: GestureDetector(
                            onTap: () async {
                              //
                              final speechCubit =
                                  BlocProvider.of<SpeechCubit>(context)
                                    ..listen();
                              speechCubit.state.maybeMap(
                                orElse: () {},
                                data: (data) => _controller.text = data.data,
                              );
                            },
                            child: SvgPicture.asset(
                              AssetConstants.mic,
                              fit: BoxFit.scaleDown,
                            ),
                          ),
                          hintStyle: const TextStyle(
                            fontFamily: 'SFPro',
                            fontVariations: [
                              FontVariation('wght', 400),
                              // Adjust the weight variation
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Expanded(
                        child: SingleChildScrollView(
                      controller: scrollController,
                      child: Column(
                        children: [
                          DateTimeWidget(
                              controller: pageController,
                              dateTime: DateTime.now(),
                              onSelected: (value) {
                                jummahBloc.add(
                                  JummahDateEvent(
                                      date: value, keyword: _controller.text),
                                );
                              }),
                          SizedBox(height: 10.h),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 19.w, vertical: 15.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    "Masjid Name",
                                    style: TextStyle(
                                      fontFamily: 'SFPro',
                                      fontSize: 14.sp,
                                      color: AppColor.brownColor,
                                      height: 14.0.toFigmaHeight(20),
                                      fontVariations: const [
                                        FontVariation('wght', 700),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Center(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: AppColor.lightGreyColor,
                                        borderRadius:
                                            BorderRadius.circular(32.sp),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 12.w, vertical: 10.h),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Jummah",
                                              style: TextStyle(
                                                fontFamily: 'SFPro',
                                                fontSize: 14.sp,
                                                color: AppColor.brownColor,
                                                height: 14.0.toFigmaHeight(20),
                                                fontVariations: const [
                                                  FontVariation('wght', 700),
                                                ],
                                              ),
                                            ),
                                            SizedBox(width: 12.w),
                                            SvgPicture.asset(
                                              AssetConstants.down_arrow,
                                              fit: BoxFit.scaleDown,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Padding(
                                      padding: EdgeInsets.only(right: 5.w),
                                      child: Text(
                                        "Jummah 2/3/4",
                                        style: TextStyle(
                                          fontFamily: 'SFPro',
                                          fontSize: 14.sp,
                                          color: AppColor.brownColor,
                                          height: 14.0.toFigmaHeight(20),
                                          fontVariations: const [
                                            FontVariation('wght', 700),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          AnimatedSwitcher(
                            duration: kDuration,
                            child: BlocBuilder<JummahBloc, FutureState>(
                              builder: (BuildContext context, state) {
                                return state.when(
                                  idle: () => const JummahLoadingWidget(),
                                  loading: () => const JummahLoadingWidget(),
                                  data: (data) => JummahDataWidget(data: data),
                                  failed: (err) => const CustomErrorWidget(
                                      error:
                                          'No internet connection, please connect to the internet'),
                                );
                              },
                            ),
                          )
                        ],
                      ),
                    ))
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

extension FigmaDimention on double {
  double toFigmaHeight(double fontSize) {
    return this / fontSize;
  }
}
