import 'package:flutter/material.dart';
import 'package:masjid/core/exports.dart';
import 'package:masjid/core/extension/datetime_extension.dart';
import 'package:masjid/data/models/masjid_model.dart';
import 'package:masjid/presentation/screens/masjid/masjid.dart';
import 'package:masjid/presentation/widgets/timechecker/timechecker.dart';

class DateTimeWidget extends StatefulWidget {
   DateTime dateTime;
  final PageController controller;
  final bool isFromHome;
  final MasjidModel? masjid;
  final void Function(DateTime date) onSelected;
   DateTimeWidget({
    super.key,
    required this.dateTime,
    required this.onSelected,
    required this.controller,
     this.masjid,
    this.isFromHome = true,
  });

  @override
  State<DateTimeWidget> createState() => _DateTimeWidgetState();
}

class _DateTimeWidgetState extends State<DateTimeWidget> {
  late List<DateTime> ranges;

  @override
  void initState() {
    super.initState();
    ranges = generate();
  }
  
  
  

  List<DateTime> generate() {
    final list = List.generate(50, (index) => widget.dateTime.add(Duration(days: index)));
    return list;
  }

  _selectDate(context, dateTime) async {
    DateTime? date = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(4030),
      initialDate: dateTime,
    );
    if (date != null) {
      setState(() {
        dateTime = date;
        widget.onSelected(date);
        int page = date.difference(DateTime.now()).inDays;
        widget.controller.jumpToPage(page + 1);
      });
    }
  }

  int initialPage = 0;
  @override
  Widget build(BuildContext context) {
   // DateTime now = widget.dateTime;
    return Container(
      height: 60.h,
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        color: AppColor.lightGreyColor,
        border: Border(
          top: BorderSide(color: AppColor.lightGreyColor),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 10.w),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MediaQuery.removePadding(
              context: context,
              removeBottom: true,
              removeLeft: true,
              removeTop: true,
              removeRight: true,
              child: GestureDetector(
                onTap: () {
                  // go to previous datetime
                  setState(() {});
                  widget.controller
                      .previousPage(duration: kDuration, curve: Curves.easeIn);
                  //  widget.controller.jumpToPage(initialPage--);
                },
                child: Icon(
                  Icons.arrow_back_ios,
                  size: 15.sp,
                ),
              ),
            ),
            SizedBox(width: 16.w),
            SizedBox(
              height: 100.h,
              width: 240.w,
              child: PageView.builder(
                controller: widget.controller,
                itemCount: ranges.length,
                physics: const NeverScrollableScrollPhysics(),
                onPageChanged: (index) {
                  widget.onSelected(ranges[index]);
                  widget.dateTime = ranges[index];
             
                  setState(() {});
                },
                itemBuilder: (context, index) {
                  return Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          _selectDate(context, widget.dateTime);
                        },
                        child: Text(
                          widget.dateTime.formatted(),
                          style: TextStyle(
                            fontFamily: 'SFPro',
                            fontSize: 14.sp,
                            color: AppColor.brownColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      widget.isFromHome
                          ? Container()
                          : Text(
                              widget.dateTime.toIslamic(),
                              style: TextStyle(
                                fontFamily: 'SFPro',
                                fontSize: 14.sp,
                                color: AppColor.greyTextColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                    ],
                  );
                },
              ),
            ),
            SizedBox(width: 16.w),
            MediaQuery.removePadding(
              context: context,
              removeBottom: true,
              removeLeft: true,
              removeTop: true,
              removeRight: true,
              child: GestureDetector(
                onTap: () {
                  // go to next datetime
                  widget.controller
                      .nextPage(duration: kDuration, curve: Curves.easeIn);
                //       int index = widget.controller.page!=null?widget.controller.page!.toInt():0;
                //       now = ranges[index];
                //   setState(() {});
                //  print('The date now is $now');
                },
                child: Icon(
                  Icons.arrow_forward_ios,
                  size: 15.sp,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
