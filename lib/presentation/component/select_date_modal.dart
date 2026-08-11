// This file is part of paas_manager.
// Copyright (C) 2024 RokctAI
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <https://www.gnu.org/licenses/>.

import 'package:flutter/cupertino.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'title_icon.dart';
import 'package:manager/presentation/styles/style.dart';
import 'helper/modal_wrap.dart';
import 'helper/modal_drag.dart';
import 'buttons/custom_button.dart';
import 'package:manager/infrastructure/services/services.dart';

class SelectDateModal extends StatefulWidget {
  final String? initialDate;
  final Function(DateTime? date) onDateSaved;

  const SelectDateModal({super.key, this.initialDate, required this.onDateSaved})
      ;

  @override
  State<SelectDateModal> createState() => _SelectDateModalState();
}

class _SelectDateModalState extends State<SelectDateModal> {
  DateTime? _date;

  @override
  void initState() {
    if (widget.initialDate != null || widget.initialDate!.isEmpty) {
      _date = DateTime.tryParse(widget.initialDate!)?.toLocal();
    } else {
      _date = DateTime.now();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ModalWrap(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const ModalDrag(),
          Padding(
            padding: REdgeInsets.symmetric(horizontal: 16),
            child: TitleAndIcon(
              title: AppHelpers.getTranslation(TrKeys.deliveryTime),
            ),
          ),
          Padding(
            padding: REdgeInsets.symmetric(horizontal: 16),
            child: Text(
              AppHelpers.getTranslation(TrKeys.selectDeliveryDate),
              style: Style.interNormal(
                size: 14.sp,
                color: Style.blackColor,
                letterSpacing: -0.3,
              ),
            ),
          ),
          SizedBox(
            height: 300.r,
            child: CupertinoTheme(
              data: const CupertinoThemeData(
                brightness: Brightness.light,
              ),
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.date,
                initialDateTime: _date,
                minimumDate: _date,
                onDateTimeChanged: (DateTime value) {
                  _date = value;
                },
              ),
            ),
          ),
          16.verticalSpace,
          Padding(
            padding: REdgeInsets.symmetric(horizontal: 16),
            child: CustomButton(
              title: AppHelpers.getTranslation(TrKeys.save),
              onPressed: () {
                widget.onDateSaved(_date);
                context.maybePop();
              },
            ),
          ),
          12.verticalSpace,
        ],
      ),
    );
  }
}
