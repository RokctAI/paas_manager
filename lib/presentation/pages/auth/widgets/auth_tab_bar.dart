import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../infrastructure/services/services.dart';
import '../../../styles/style.dart';

class AuthTabBar extends StatefulWidget {
  final bool isScrollable;
  final TabController controller;

  const AuthTabBar({
    super.key,
    required this.controller,
    this.isScrollable = false,
  });

  @override
  State<AuthTabBar> createState() => _AuthTabBarState();
}

class _AuthTabBarState extends State<AuthTabBar> {
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(() {
      if (mounted) setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final tabs = [
      AuthTab(text: TrKeys.phoneNumber, icon: FlutterRemix.phone_fill),
      AuthTab(text: TrKeys.email, icon: FlutterRemix.mail_fill),
    ];
    return Container(
      margin: EdgeInsets.only(bottom: 24.r),
      padding: EdgeInsets.all(6.r),
      height: 50.h,
      decoration: BoxDecoration(
        color: AppStyle.greyColor,
        borderRadius: BorderRadius.circular(10.r),
        boxShadow: [
          BoxShadow(
            color: AppStyle.black.withValues(alpha: 0.05),
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: TabBar(
        isScrollable: widget.isScrollable,
        controller: widget.controller,
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          color: AppStyle.white,
        ),
        labelColor: AppStyle.black,
        unselectedLabelColor: AppStyle.black.withValues(alpha: 0.5),
        unselectedLabelStyle: AppStyle.interNormal(size: 12.sp),
        labelStyle: AppStyle.interSemi(size: 12.sp),
        tabs: tabs
            .map(
              (tab) => Tab(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      tab.icon,
                      size: 18.r,
                      color: widget.controller.index == tabs.indexOf(tab)
                          ? AppStyle.black
                          : AppStyle.black.withValues(alpha: 0.5),
                    ),
                    8.horizontalSpace,
                    Text(AppHelpers.getTranslation(tab.text)),
                  ],
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

class AuthTab {
  final String text;
  final IconData icon;

  const AuthTab({required this.text, required this.icon});
}
