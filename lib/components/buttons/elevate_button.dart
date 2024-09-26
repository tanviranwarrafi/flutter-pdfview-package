import 'package:flutter/material.dart';
import 'package:tutorial/themes/colors.dart';
import 'package:tutorial/themes/text_styles.dart';

class ElevateButton extends StatelessWidget {
  final String label;
  final double? width;
  final double height;
  final double radius;
  final Color color;
  final Color background;
  final double padding;
  final double textSize;
  final Function()? onTap;

  const ElevateButton({
    this.label = '',
    this.width,
    this.onTap,
    this.radius = 08,
    this.height = 48,
    this.padding = 12,
    this.color = white,
    this.textSize = 16.5,
    this.background = primary,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: padding),
        decoration: BoxDecoration(color: background, borderRadius: BorderRadius.circular(radius)),
        child: Text(
          label,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyles.text15_500.copyWith(color: color, fontSize: textSize),
        ),
      ),
    );
  }
}
