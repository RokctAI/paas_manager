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

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:venderfoodyman/application/generate_image/generate_image_provider.dart';
import 'package:venderfoodyman/infrastructure/services/tr_keys.dart';
import 'package:venderfoodyman/presentation/component/components.dart';

import 'package:venderfoodyman/infrastructure/services/app_helpers.dart';
import 'package:venderfoodyman/presentation/styles/style.dart';

@RoutePage()
class GenerateImagePage extends StatefulWidget {
  const GenerateImagePage({super.key}) ;

  @override
  State<GenerateImagePage> createState() => _GenerateImagePageState();
}

class _GenerateImagePageState extends State<GenerateImagePage> {
  late TextEditingController controller;

  @override
  void initState() {
    controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Style.greyColor,
      body: Column(
        children: [
          CustomAppBar(
            bottomPadding: 24.r,
            child: Text(
              AppHelpers.getTranslation(TrKeys.generateImageWithChatGPT),
              style: GoogleFonts.inter(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Style.blackColor,
              ),
            ),
          ),
          Container(
              margin: EdgeInsets.all(16.r),
              padding: EdgeInsets.symmetric(vertical: 4.r),
              decoration: BoxDecoration(
                  color: Style.white, borderRadius: BorderRadius.circular(8.r)),
              child: Row(
                children: [
                  Expanded(
                      child: SearchTextField(
                    isSearchIcon: false,
                    textEditingController: controller,
                    hintText: AppHelpers.getTranslation(TrKeys.typeSomething),
                  )),
                  Container(
                    decoration: BoxDecoration(
                        color: Style.primary,
                        borderRadius: BorderRadius.circular(8.r)),
                    child: Consumer(builder: (context, ref, child) {
                      return IconButton(
                          onPressed: () {
                            ref
                                .read(generateImageProvider.notifier)
                                .generateImage(context, controller.text);
                          },
                          icon: const Icon(FlutterRemix.search_2_line));
                    }),
                  ),
                  4.horizontalSpace
                ],
              )),
          Expanded(
            child: Consumer(builder: (context, ref, child) {
              final state = ref.watch(generateImageProvider);
              return state.isLoading
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Loading(),
                        8.verticalSpace,
                        Text(AppHelpers.getTranslation(TrKeys.imageGenerateTake))
                      ],
                    )
                  : GridView.builder(
                      padding:
                          EdgeInsets.only(right: 8.r, left: 8.r, bottom: 24.r),
                      shrinkWrap: true,
                      itemCount: state.data?.data?.length ?? 0,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () async {
                            context
                                .maybePop(state.data?.data?[index].url ?? "");
                          },
                          child: Container(
                            margin: EdgeInsets.all(8.r),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16.r),
                                border: Border.all(color: Style.borderColor)),
                            child: CommonImage(
                                url: state.data?.data?[index].url ?? "",
                                height: 100,
                                width: 100,
                                radius: 16),
                          ),
                        );
                      },
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              childAspectRatio: 1, crossAxisCount: 2),
                    );
            }),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: const PopButton(
          heroTag: '',
        ),
      ),
    );
  }
}
