import 'package:flutter/material.dart';
import 'package:masjid/core/exports.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class RoundedSvgButton extends StatelessWidget {
  final String? icon;
  final VoidCallback? onPressed;

  const RoundedSvgButton({super.key, this.icon, this.onPressed});
  Future<void> _launchInBrowser(Uri url) async {
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {}

    // if (await launchUrl(
    //   url,
    //   mode: LaunchMode.externalApplication,
    // )) {
    //    print('Could not launch $url');
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 30.h, right: 10.w),
      child: Align(
        alignment: Alignment.topRight,
        child: PopupMenuButton<String>(
          icon: Column(
            children: [
              Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColor.backgroundColor,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: SvgPicture.asset(
                    icon!,
                    fit: BoxFit.scaleDown,
                  ),
                ),
              ),
            ],
          ),
          offset: const Offset(0, 40),
          // Offset to display menu slightly below
          itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
            PopupMenuItem(
              onTap: () => _launchInBrowser(Uri.parse(ABOUT_APP)),
              height: 0,
              // setting this to 0 worked
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "About App",
                      style: TextStyle(
                          fontSize: 17.sp,
                          letterSpacing: -0.4,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'SFPro',
                          height: 17.0.toFigmaHeight(22)),
                    ),
                    SizedBox(width: 100.w),
                    SvgPicture.asset(
                      AssetConstants.mossques,
                      fit: BoxFit.scaleDown,
                    ),
                  ],
                ),
              ),
            ),
            const PopupMenuDivider(),
            PopupMenuItem(
              onTap: (() =>
                  _launchInBrowser(Uri(scheme: 'mailto', path: SEND_FEEDBACK))),
              height: 0,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Send Feedback",
                      style: TextStyle(
                        fontSize: 17.sp,
                        letterSpacing: -0.4,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'SFPro',
                        height: 17.0.toFigmaHeight(22),
                      ),
                    ),
                    SvgPicture.asset(
                      AssetConstants.envelope,
                      fit: BoxFit.scaleDown,
                    ),
                  ],
                ),
              ),
            ),
            const PopupMenuDivider(),
            PopupMenuItem(
              onTap: () => _launchInBrowser(Uri.parse(RATE_APP)),
              height: 0,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Rate App",
                      style: TextStyle(
                          fontSize: 17.sp,
                          letterSpacing: -0.4,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'SFPro',
                          height: 17.0.toFigmaHeight(22)),
                    ),
                    SvgPicture.asset(
                      AssetConstants.star,
                      fit: BoxFit.scaleDown,
                    ),
                  ],
                ),
              ),
            ),
            const PopupMenuDivider(),
            PopupMenuItem(
              onTap: () => Share.share('Check out M247 app'),
              height: 0,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Share App",
                      style: TextStyle(
                          fontSize: 17.sp,
                          letterSpacing: -0.4,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'SFPro',
                          height: 17.0.toFigmaHeight(22)),
                    ),
                    SvgPicture.asset(
                      AssetConstants.share,
                      fit: BoxFit.scaleDown,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomPopupMenuItem extends PopupMenuItem {
  const CustomPopupMenuItem({
    super.key,
    required super.child,
  });

  Widget build(BuildContext context) {
    return Container(
      height: 20,
      width: 250,
      decoration: const BoxDecoration(
        color: AppColor.backgroundColor,
      ),
      child: child,
    );
  }
}
