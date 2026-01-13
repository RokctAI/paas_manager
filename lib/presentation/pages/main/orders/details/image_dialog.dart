import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:venderfoodyman/infrastructure/services/services.dart';
import 'package:venderfoodyman/presentation/component/components.dart';
import 'package:venderfoodyman/presentation/styles/style.dart';

class ImageDialog extends StatelessWidget {
  final String? img;

  const ImageDialog({super.key, this.img});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                AppHelpers.getTranslation(TrKeys.thisImageWasUploadDriver),
                style: Style.interNormal(),
              ),
            ),
            GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Padding(
                  padding: REdgeInsets.all(4),
                  child: const Icon(FlutterRemix.close_circle_line),
                )),
          ],
        ),
        12.verticalSpace,
        CommonImage(
          url: img,
        ),
      ],
    );
  }
}
