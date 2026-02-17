import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:venderfoodyman/application/profile/profile_notifier.dart';
import 'package:venderfoodyman/infrastructure/services/services.dart';
import 'package:venderfoodyman/presentation/component/components.dart';
import 'package:venderfoodyman/presentation/styles/style.dart';

class BackgroundImagePicker extends StatelessWidget {
  final String bgImage;
  final ProfileNotifier event;

  const BackgroundImagePicker({
    super.key,
    required this.bgImage,
    required this.event,
  });

  Future<void> _pickImage() async {
    XFile? file;
    try {
      file = await ImagePicker().pickImage(source: ImageSource.gallery);
    } catch (ex) {
      debugPrint('===> trying to select image $ex');
    }
    if (file != null) {
      event.setBgImage(file.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: 180.h,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppStyle.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: AppStyle.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: bgImage.isNotEmpty
          ? _buildImagePreview()
          : _buildImagePlaceholder(),
    );
  }

  Widget _buildImagePreview() {
    return Stack(
      children: [
        SizedBox(
          height: 180.h,
          width: double.infinity,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16.r),
            child: Image.file(File(bgImage), fit: BoxFit.cover),
          ),
        ),
        Positioned(
          top: 12.h,
          right: 16.w,
          child: Row(
            children: [
              _buildActionButton(
                icon: FlutterRemix.image_add_fill,
                onTap: _pickImage,
              ),
              10.horizontalSpace,
              _buildActionButton(
                icon: FlutterRemix.delete_bin_fill,
                onTap: () => event.setBgImage(""),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: BlurWrap(
        radius: BorderRadius.circular(20.r),
        child: Container(
          height: 40.r,
          width: 40.r,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppStyle.white.withOpacity(0.15),
          ),
          child: Icon(icon, color: AppStyle.white),
        ),
      ),
    );
  }

  Widget _buildImagePlaceholder() {
    return Material(
      color: AppStyle.transparent,
      borderRadius: BorderRadius.circular(16.r),
      child: InkWell(
        onTap: _pickImage,
        borderRadius: BorderRadius.circular(16.r),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: AppStyle.borderColor.withOpacity(0.3),
              width: 2,
              style: BorderStyle.solid,
            ),
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(16.r),
                decoration: BoxDecoration(
                  color: AppStyle.green.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  FlutterRemix.upload_cloud_2_line,
                  size: 42.r,
                  color: AppStyle.green,
                ),
              ),
              16.verticalSpace,
              Text(
                AppHelpers.getTranslation(TrKeys.balance),
                style: AppStyle.interSemi(
                  size: 15,
                  color: AppStyle.black,
                  letterSpacing: -0.3,
                ),
              ),
              8.verticalSpace,
              Text(
                AppHelpers.getTranslation(TrKeys.recommendedSize),
                style: AppStyle.interRegular(
                  size: 13,
                  color: AppStyle.textGrey,
                  letterSpacing: -0.3,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
