import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:venderfoodyman/application/profile/profile_notifier.dart';
import 'package:venderfoodyman/infrastructure/services/services.dart';
import 'package:venderfoodyman/presentation/component/components.dart';
import 'package:venderfoodyman/presentation/styles/style.dart';

class LogoAndNameSection extends StatelessWidget {
  final String logoImage;
  final TextEditingController shopNameController;
  final ProfileNotifier event;
  final String? Function(String?)? validation;

  const LogoAndNameSection({
    super.key,
    required this.logoImage,
    required this.shopNameController,
    required this.event,
    this.validation,
  });

  Future<void> _pickLogoImage() async {
    XFile? file;
    try {
      file = await ImagePicker().pickImage(source: ImageSource.gallery);
    } catch (ex) {
      debugPrint('===> trying to select image $ex');
    }
    if (file != null) {
      event.setLogoImage(file.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Material(
          color: AppStyle.transparent,
          borderRadius: BorderRadius.circular(16.r),
          child: InkWell(
            onTap: _pickLogoImage,
            borderRadius: BorderRadius.circular(16.r),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 70.r,
              height: 70.r,
              padding: EdgeInsets.all(6.r),
              decoration: logoImage.isNotEmpty
                  ? BoxDecoration(
                      color: AppStyle.white,
                      borderRadius: BorderRadius.circular(16.r),
                      border: Border.all(
                        color: AppStyle.primary.withOpacity(0.3),
                        width: 2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppStyle.primary.withOpacity(0.1),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                      image: DecorationImage(
                        image: FileImage(File(logoImage)),
                        fit: BoxFit.cover,
                      ),
                    )
                  : BoxDecoration(
                      color: AppStyle.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(16.r),
                      border: Border.all(
                        color: AppStyle.primary.withOpacity(0.3),
                        width: 2,
                        style: BorderStyle.solid,
                      ),
                    ),
              child: logoImage.isEmpty
                  ? Center(
                      child: Icon(
                        FlutterRemix.camera_fill,
                        color: AppStyle.primary,
                        size: 24.r,
                      ),
                    )
                  : null,
            ),
          ),
        ),
        16.horizontalSpace,
        Expanded(
          child: OutlinedBorderTextField(
            validation: validation,
            textController: shopNameController,
            label: AppHelpers.getTranslation(TrKeys.restaurantName),
          ),
        ),
      ],
    );
  }
}
