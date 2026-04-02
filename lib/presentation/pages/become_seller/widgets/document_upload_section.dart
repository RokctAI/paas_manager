import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:venderfoodyman/application/profile/profile_notifier.dart';
import 'package:venderfoodyman/infrastructure/services/services.dart';
import 'package:venderfoodyman/presentation/styles/style.dart';

class DocumentUploadSection extends StatelessWidget {
  final List<String> filePaths;
  final ProfileNotifier event;

  const DocumentUploadSection({
    super.key,
    required this.filePaths,
    required this.event,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 4.w, bottom: 12.h),
          child: Text(
            'Documents',
            style: AppStyle.interSemi(size: 14, color: AppStyle.black),
          ),
        ),
        Material(
          color: AppStyle.white,
          borderRadius: BorderRadius.circular(12.r),
          child: InkWell(
            onTap: () async => await ImgService.getFilePdf(event.setFile),
            borderRadius: BorderRadius.circular(12.r),
            child: Container(
              height: 80.h,
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(
                  color: AppStyle.borderColor.withOpacity(0.3),
                  width: 1.5,
                ),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(10.r),
                    decoration: BoxDecoration(
                      color: AppStyle.primary.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      FlutterRemix.file_pdf_line,
                      size: 28.r,
                      color: AppStyle.primary,
                    ),
                  ),
                  16.horizontalSpace,
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppHelpers.getTranslation(TrKeys.uploadDocuments),
                        style: AppStyle.interSemi(
                          size: 14,
                          color: AppStyle.black,
                        ),
                      ),
                      4.verticalSpace,
                      Text(
                        'PDF files only',
                        style: AppStyle.interRegular(
                          size: 12,
                          color: AppStyle.textGrey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        8.verticalSpace,
        ...filePaths.map(
          (path) => Container(
            decoration: BoxDecoration(
              color: AppStyle.white,
              borderRadius: BorderRadius.circular(10.r),
              border: Border.all(
                color: AppStyle.borderColor.withOpacity(0.2),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppStyle.black.withOpacity(0.03),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            padding: REdgeInsets.symmetric(horizontal: 12, vertical: 10),
            margin: REdgeInsets.only(bottom: 8),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(8.r),
                  decoration: BoxDecoration(
                    color: AppStyle.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Icon(
                    FlutterRemix.file_pdf_fill,
                    size: 18.r,
                    color: AppStyle.primary,
                  ),
                ),
                12.horizontalSpace,
                Expanded(
                  child: Text(
                    path.split('/').last,
                    style: AppStyle.interNormal(size: 13),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                IconButton(
                  onPressed: () => event.deleteFile(path),
                  icon: Icon(
                    FlutterRemix.close_circle_fill,
                    size: 20.r,
                    color: AppStyle.red,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
