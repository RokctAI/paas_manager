import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart' show toBeginningOfSentenceCase;

import 'package:venderfoodyman/presentation/styles/style.dart';
import 'package:venderfoodyman/infrastructure/models/models.dart';

class SmallWeekdayItem extends StatelessWidget {
  final bool isSelected;
  final ShopWorkingDays day;
  final int size;
  final int fontSize;
  final int borderRadius;

  const SmallWeekdayItem({
    super.key,
    required this.isSelected,
    required this.day,
    this.size = 40,
    this.fontSize = 14,
    this.borderRadius = 10,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.r,
      width: size.r,
      decoration: BoxDecoration(
        color: isSelected ? Style.primary : Style.white,
        borderRadius: BorderRadius.circular(borderRadius.r),
      ),
      alignment: Alignment.center,
      child: Text(
        '${toBeginningOfSentenceCase(day.day?.substring(0, 2))}',
        style: Style.interNormal(
          size: fontSize.sp,
          color: Style.blackColor,
        ),
      ),
    );
  }
}
