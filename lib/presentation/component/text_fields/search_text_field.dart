import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:venderfoodyman/presentation/styles/style.dart';
import 'package:venderfoodyman/infrastructure/services/services.dart';

class SearchTextField extends StatelessWidget {
  final String? hintText;
  final Widget? suffixIcon;
  final TextEditingController? textEditingController;
  final VoidCallback? onTap;
  final ValueChanged<String>? onChanged;
  final Color bgColor;
  final bool isBorder;
  final bool isRead;
  final bool isSearchIcon;

  const SearchTextField({
    super.key,
    this.hintText,
    this.suffixIcon,
    this.textEditingController,
    this.onChanged,
    this.bgColor = AppStyle.transparent,
    this.isBorder = false,
    this.isRead = false,
    this.isSearchIcon = true,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: isRead,
      autofocus: false,
      autocorrect: true,
      style: AppStyle.interRegular(size: 16, color: AppStyle.blackColor),
      onTap: onTap,
      onChanged: onChanged,
      controller: textEditingController,
      cursorColor: AppStyle.blackColor,
      cursorWidth: 1,
      decoration: InputDecoration(
        hintStyle: AppStyle.interRegular(size: 16, color: AppStyle.textColor),
        hintText: hintText ?? AppHelpers.getTranslation(TrKeys.search),
        contentPadding: REdgeInsets.symmetric(horizontal: 15, vertical: 17),
        prefixIcon: isSearchIcon
            ? Icon(
                FlutterRemix.search_2_line,
                size: 20.r,
                color: AppStyle.blackColor,
              )
            : null,
        suffixIcon: suffixIcon,
        fillColor: bgColor,
        filled: true,
        focusedBorder: isBorder ? const OutlineInputBorder() : InputBorder.none,
        border: isBorder ? const OutlineInputBorder() : InputBorder.none,
        enabledBorder: isBorder ? const OutlineInputBorder() : InputBorder.none,
      ),
    );
  }
}
