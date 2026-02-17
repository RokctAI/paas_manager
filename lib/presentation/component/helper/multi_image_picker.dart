import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:venderfoodyman/infrastructure/models/models.dart';
import 'package:venderfoodyman/infrastructure/services/services.dart';
import 'package:venderfoodyman/presentation/styles/style.dart';
import '../buttons/animation_button_effect.dart';
import 'blur_wrap.dart';
import 'common_image.dart';

class MultiImagePicker extends StatelessWidget {
  final List<String?>? listOfImages;
  final List<Galleries?>? imageUrls;
  final Function(String) onDelete;
  final Function(String) onImageChange;

  const MultiImagePicker({
    super.key,
    this.listOfImages,
    required this.onDelete,
    this.imageUrls,
    required this.onImageChange,
  });

  @override
  Widget build(BuildContext context) {
    return _editProductImage(context);
  }

  Column _editProductImage(BuildContext context) {
    int itemCount = (listOfImages?.length ?? 0) + (imageUrls?.length ?? 0);
    return Column(
      children: [
        (itemCount > 0) == false
            ? ButtonEffectAnimation(
                onTap: () async {
                  Delayed(milliseconds: 300).run(() async {
                    XFile? file;
                    try {
                      file = await ImagePicker().pickImage(
                        source: ImageSource.gallery,
                      );
                    } catch (ex) {
                      debugPrint('===> trying to select image $ex');
                    }
                    if (file != null) {
                      onImageChange.call(file.path);
                    }
                  });
                },
                child: Container(
                  width: double.infinity,
                  height: 180.r,
                  decoration: BoxDecoration(
                    color: AppStyle.white,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  padding: REdgeInsets.symmetric(vertical: 24),
                  child: Column(
                    children: [
                      Icon(
                        FlutterRemix.upload_cloud_2_line,
                        color: AppStyle.primary,
                        size: 36.r,
                      ),
                      16.verticalSpace,
                      Text(
                        AppHelpers.getTranslation(TrKeys.productPicture),
                        style: AppStyle.interSemi(
                          size: 14,
                          color: AppStyle.black,
                          letterSpacing: -0.3,
                        ),
                      ),
                      Text(
                        AppHelpers.getTranslation(TrKeys.recommendedSize),
                        style: AppStyle.interRegular(
                          size: 14,
                          color: AppStyle.black,
                          letterSpacing: -0.3,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : Stack(
                children: [
                  CommonImage(
                    fileImage:
                        ((imageUrls?.isEmpty ?? true) &&
                            (listOfImages?.isNotEmpty ?? false))
                        ? File(listOfImages?.first ?? "")
                        : null,
                    url: (imageUrls?.isNotEmpty ?? false)
                        ? imageUrls?.first?.path
                        : null,
                    height: MediaQuery.sizeOf(context).height / 5.5,
                    width: double.infinity,
                    radius: 16,
                    preview: imageUrls?.isNotEmpty ?? false
                        ? imageUrls?.first?.preview
                        : null,
                    fit: BoxFit.fitHeight,
                  ),
                  Positioned(
                    right: 16.r,
                    top: 16.r,
                    child: ButtonEffectAnimation(
                      onTap: () => onDelete(
                        (imageUrls?.isNotEmpty ?? false)
                            ? imageUrls?.first?.path ?? ""
                            : listOfImages?.first ?? "",
                      ),
                      child: BlurWrap(
                        blur: 6,
                        radius: BorderRadius.circular(20.r),
                        child: Container(
                          height: 40.r,
                          width: 40.r,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppStyle.white.withOpacity(0.2),
                          ),
                          child: Icon(
                            FlutterRemix.delete_bin_fill,
                            color: AppStyle.white,
                            size: 18.r,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
        if (itemCount > 0)
          GridView.builder(
            padding: REdgeInsets.only(top: 12),
            itemCount: itemCount,
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              crossAxisSpacing: 8.r,
              mainAxisSpacing: 8.r,
              maxCrossAxisExtent: 100.r,
              childAspectRatio: 0.9,
            ),
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return itemCount == index + 1
                  ? _mediaPicker(context)
                  : Stack(
                      children: [
                        Positioned(
                          top: 0,
                          left: 0,
                          right: 0,
                          bottom: 0,
                          child: CommonImage(
                            fileImage: (imageUrls?.length ?? 0) > index + 1
                                ? null
                                : File(
                                    listOfImages?[index -
                                            (imageUrls?.length ?? 0) +
                                            1] ??
                                        "",
                                  ),
                            url: (imageUrls?.length ?? 0) > index + 1
                                ? imageUrls![index + 1]?.path
                                : null,
                            preview: (imageUrls?.length ?? 0) > index + 1
                                ? imageUrls![index + 1]?.preview
                                : null,
                            height: 80,
                            width: 70,
                            radius: 12,
                            fit: BoxFit.cover,
                          ),
                        ),
                        if ((imageUrls?.length ?? 0) > index + 1
                            ? imageUrls![index + 1]?.preview == null
                            : true)
                          Positioned.fill(
                            child: Center(
                              child: ButtonEffectAnimation(
                                onTap: () {
                                  String path;
                                  try {
                                    path = imageUrls?[index + 1]?.path ?? "";
                                  } catch (e) {
                                    path =
                                        listOfImages?[(index -
                                                (imageUrls?.length ?? 0)) +
                                            1] ??
                                        "";
                                  }
                                  onDelete(path);
                                },
                                child: Container(
                                  padding: EdgeInsets.all(8.r),
                                  decoration: BoxDecoration(
                                    color: AppStyle.white.withOpacity(0.8),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    FlutterRemix.delete_bin_line,
                                    color: AppStyle.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                      ],
                    );
            },
          ),
      ],
    );
  }

  ButtonEffectAnimation _mediaPicker(BuildContext context) {
    return ButtonEffectAnimation(
      onTap: () async {
        Delayed(milliseconds: 300).run(() async {
          XFile? file;
          try {
            file = await ImagePicker().pickImage(source: ImageSource.gallery);
          } catch (ex) {
            debugPrint('===> trying to select image $ex');
          }
          if (file != null) {
            onImageChange.call(file.path);
          }
        });
      },
      child: DottedBorder(
        options: RoundedRectDottedBorderOptions(
          dashPattern: const [8],
          color: AppStyle.primary,
          strokeWidth: 2.6,
          radius: const Radius.circular(10),
        ),
        child: Center(
          child: Icon(
            FlutterRemix.upload_cloud_2_line,
            color: AppStyle.primary,
            size: 28.r,
          ),
        ),
      ),
    );
  }
}
