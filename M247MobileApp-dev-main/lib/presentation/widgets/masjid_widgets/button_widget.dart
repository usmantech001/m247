import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NavigatorButton extends StatelessWidget {
  final String? icon;
  final VoidCallback? onPressed;
  const NavigatorButton({
    super.key,
    this.icon,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
   
      decoration: const BoxDecoration(shape: BoxShape.circle),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: onPressed,
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: SvgPicture.asset(
              icon!,
              height: 25,
              width: 25,
              fit: BoxFit.scaleDown,
            ),
          ),
        ),
      ),
    );
  }
}
