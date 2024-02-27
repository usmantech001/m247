import 'package:flutter/material.dart';
import 'package:masjid/core/exports.dart';
import 'package:masjid/presentation/logic/timepicker_bloc.dart';
import 'package:masjid/presentation/widgets/common_widgets/date_time_widget.dart';
import 'package:masjid/presentation/widgets/home_widgets/home_initial_widget.dart';
import 'package:masjid/presentation/widgets/home_widgets/home_loading_widget.dart';
import 'package:masjid/presentation/widgets/home_widgets/home_data_widget.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late TextEditingController _controller;
  late PageController _pagecontroller;

  @override
  void initState() {
    super.initState();
    _pagecontroller = PageController();
    _controller = TextEditingController();
  }

  DateTime dateTime = DateTime.now();
  @override
  Widget build(BuildContext context) {
    final homeBloc = BlocProvider.of<HomeBloc>(context);
    final timeBloc = BlocProvider.of<TimePickerBloc>(context);
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
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          RoundedSvgButton(
            icon: AssetConstants.question,
            onPressed: () {
              //
            },
          ),
          DraggableScrollableSheet(
            initialChildSize: initialChildSize,
            minChildSize: minChildSize,
            maxChildSize: maxChildSize,
            builder: (BuildContext context, ScrollController scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: AppColor.backgroundColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.sp),
                    topRight: Radius.circular(20.sp),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10.h),
                    Padding(
                      padding: EdgeInsets.only(left: 17.w),
                      child: Row(
                        children: [
                          Text(
                            "My Masjids",
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
                            itemBuilder: (BuildContext context) =>
                                <PopupMenuEntry<String>>[
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
                                            'My Masjids',
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
                                      SvgPicture.asset(
                                        AssetConstants.masjid,
                                        fit: BoxFit.scaleDown,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              const PopupMenuDivider(),
                              PopupMenuItem(
                                height: 0,
                                child: InkWell(
                                  onTap: () {
                                    Navigator.pop(context);
                                    Navigator.pop(context);

                                    // go to jummah timming
                                    Navigator.pushNamed(
                                        context, RouteGenerator.jummah,
                                        arguments: _pagecontroller);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Jumma Timings',
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.black,
                                              letterSpacing: -0.4,
                                              fontWeight: FontWeight.w400,
                                              fontFamily: 'SFPro',
                                              height: 17.0.toFigmaHeight(22)),
                                        ),
                                        SizedBox(width: 50.w),
                                        SvgPicture.asset(
                                          AssetConstants.clock,
                                          fit: BoxFit.scaleDown,
                                        )
                                      ],
                                    ),
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
                        textInputAction: TextInputAction.search,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Search & Add Masjid",
                          prefixIcon: SvgPicture.asset(
                            AssetConstants.search,
                            fit: BoxFit.scaleDown,
                          ),
                          suffixIcon: GestureDetector(
                            onTap: () async {
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
                        onChanged: (value) {
                          if (value.length >= 3) {
                            homeBloc.add(HomeEventGetMasjid(value));
                          }
                          if (value.isEmpty) {
                            FocusScope.of(context).unfocus();
                          }
                        },
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Expanded(
                      child: SingleChildScrollView(
                        controller: scrollController,
                        scrollDirection: Axis.vertical,
                        child: Column(
                          children: [
                            SizedBox(height: 10.h),
                            DateTimeWidget(
                              controller: _pagecontroller,
                              dateTime: DateTime.now(),
                              onSelected: (value) {
                                dateTime = value;
                                setState(() {});
                                // change datetime and timetable search
                                timeBloc.add(SelectedTimeEvent(value));
                              },
                            ),
                            SizedBox(height: 20.h),
                            AnimatedSwitcher(
                              duration: kDuration,
                              child: BlocBuilder<HomeBloc, FutureState>(
                                builder: (context, state) {
                                  return state.when(
                                    idle: () => HomeInitialWidget(
                                      dateTime: dateTime,
                                      pageController: _pagecontroller,
                                    ),
                                    failed: (err) =>
                                        CustomErrorWidget(error: err),
                                    loading: () => const HomeLoadingWidget(),
                                    data: (data) {
                                      return _controller.text.isEmpty
                                          ? HomeInitialWidget(
                                              pageController: _pagecontroller,
                                              dateTime: dateTime,
                                            )
                                          : HomeDataWidget(
                                              dateTime: dateTime,
                                              data: data,
                                              controller: _pagecontroller,
                                            );
                                    },
                                  );
                                },
                              ),
                            ),
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
