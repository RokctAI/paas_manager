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

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/services.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:lottie/lottie.dart';
import 'package:venderfoodyman/infrastructure/services/img_service.dart';
import 'package:venderfoodyman/presentation/pages/restaurant/widgets/logout_modal.dart';
import 'package:venderfoodyman/application/profile/profile_notifier.dart';
import 'package:venderfoodyman/application/profile/profile_provider.dart';
import 'package:venderfoodyman/application/profile/profile_state.dart';
import 'package:venderfoodyman/infrastructure/services/services.dart';
import '../../component/components.dart';
import '../../component/text_fields/outline_bordered_text_field.dart';
import 'package:venderfoodyman/presentation/routes/app_router.dart';
import 'package:venderfoodyman/presentation/styles/style.dart';

@RoutePage()
class CreateShopPage extends ConsumerStatefulWidget {
  const CreateShopPage({super.key});

  @override
  ConsumerState<CreateShopPage> createState() => _EditRestaurantState();
}

class _EditRestaurantState extends ConsumerState<CreateShopPage> {
  late ProfileNotifier event;
  late TextEditingController shopName;
  late TextEditingController descName;
  late TextEditingController phoneName;
  late TextEditingController tax;
  late TextEditingController deliveryTimeFrom;
  late TextEditingController deliveryTimeTo;
  late TextEditingController startPrice;
  late TextEditingController pricePerKm;
  final GlobalKey<FormState> form = GlobalKey<FormState>();
  dynamic data;

  List list = ["minute", "day", "month"];

  String value = "minute";

  @override
  void initState() {
    shopName = TextEditingController();
    descName = TextEditingController();
    phoneName = TextEditingController();
    deliveryTimeFrom = TextEditingController();
    deliveryTimeTo = TextEditingController();
    startPrice = TextEditingController();
    pricePerKm = TextEditingController();
    tax = TextEditingController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(profileProvider.notifier).resetShopData();
      ref.read(profileProvider.notifier).fetchUser(context, onSuccess: (phone) {
        if (!AppConstants.isSpecificNumberEnabled) {
          phoneName.text = phone ?? '';
        } else {
          final smt = PhoneNumber.fromCompleteNumber(
              completeNumber: "+${phone?.replaceAll("+", "")}");
          phoneName.text = smt.number;
        }
      });
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    event = ref.read(profileProvider.notifier);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    shopName.dispose();
    descName.dispose();
    phoneName.dispose();
    deliveryTimeFrom.dispose();
    deliveryTimeTo.dispose();
    startPrice.dispose();
    pricePerKm.dispose();
    tax.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(profileProvider);
    return KeyboardDisable(
      child: Scaffold(
        body: Column(
          children: [
            CustomAppBar(
              bottomPadding: 16,
              child: Text(
                AppHelpers.getTranslation(TrKeys.becomeSeller),
                style: Style.interSemi(
                  size: 18,
                  color: Style.black,
                ),
              ),
            ),
            Expanded(
              child: state.isLoading
                  ? const Loading()
                  : state.userData?.shop == null
                      ? Form(
                          key: form,
                          child: ListView(
                            physics: const BouncingScrollPhysics(),
                            padding:
                                REdgeInsets.only(top: 12, left: 16, right: 16),
                            shrinkWrap: true,
                            children: [
                              Column(
                                children: [
                                  _setBgImage(state),
                                  24.verticalSpace,
                                  Row(
                                    children: [
                                      InkWell(
                                        onTap: () async {
                                          XFile? file;
                                          try {
                                            file = await ImagePicker()
                                                .pickImage(
                                                    source:
                                                        ImageSource.gallery);
                                          } catch (ex) {
                                            debugPrint(
                                                '===> trying to select image $ex');
                                          }
                                          if (file != null) {
                                            event.setLogoImage(file.path);
                                          }
                                        },
                                        child: Container(
                                          width: 50.r,
                                          height: 50.r,
                                          padding: EdgeInsets.all(6.r),
                                          decoration: state.logoImage.isNotEmpty
                                              ? BoxDecoration(
                                                  color: Style.black
                                                      .withOpacity(0.27),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          16.r),
                                                  image: DecorationImage(
                                                      image: FileImage(File(
                                                          state.logoImage)),
                                                      fit: BoxFit.cover),
                                                )
                                              : BoxDecoration(
                                                  color: Style.black
                                                      .withOpacity(0.27),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          16.r),
                                                ),
                                          child: const Center(
                                            child: Icon(
                                              FlutterRemix.camera_fill,
                                              color: Style.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                      16.horizontalSpace,
                                      Expanded(
                                        child: OutlinedBorderTextField(
                                          validation: AppValidators.emptyCheck,
                                          textController: shopName,
                                          label: AppHelpers.getTranslation(
                                            TrKeys.restaurantName,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  24.verticalSpace,
                                  OutlinedBorderTextField(
                                    textController: descName,
                                    validation: AppValidators.emptyCheck,
                                    label: AppHelpers.getTranslation(
                                        TrKeys.description),
                                  ),
                                  24.verticalSpace,
                                  if (AppConstants.isSpecificNumberEnabled)
                                    IntlPhoneField(
                                      disableLengthCheck: !AppConstants
                                          .isNumberLengthAlwaysSame,
                                      controller: phoneName,
                                      validator: (s) {
                                        if (AppConstants
                                                .isNumberLengthAlwaysSame &&
                                            (s?.isValidNumber() ?? true)) {
                                          return AppHelpers.getTranslation(
                                              TrKeys.phoneNumberIsNotValid);
                                        }
                                        return null;
                                      },
                                      keyboardType: TextInputType.phone,
                                      initialCountryCode:
                                          AppConstants.countryCodeISO,
                                      invalidNumberMessage:
                                          AppHelpers.getTranslation(
                                              TrKeys.phoneNumberIsNotValid),
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                      showCountryFlag: AppConstants.showFlag,
                                      showDropdownIcon:
                                          AppConstants.showArrowIcon,
                                      autovalidateMode: AppConstants
                                              .isNumberLengthAlwaysSame
                                          ? AutovalidateMode.onUserInteraction
                                          : AutovalidateMode.disabled,
                                      textAlignVertical:
                                          TextAlignVertical.center,
                                      decoration: InputDecoration(
                                        counterText: '',
                                        enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide.merge(
                                                const BorderSide(
                                                    color: Style
                                                        .differBorderColor),
                                                const BorderSide(
                                                    color: Style
                                                        .differBorderColor))),
                                        errorBorder: UnderlineInputBorder(
                                            borderSide: BorderSide.merge(
                                                const BorderSide(
                                                    color: Style
                                                        .differBorderColor),
                                                const BorderSide(
                                                    color: Style
                                                        .differBorderColor))),
                                        border: const UnderlineInputBorder(),
                                        focusedErrorBorder:
                                            const UnderlineInputBorder(),
                                        disabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide.merge(
                                                const BorderSide(
                                                    color: Style
                                                        .differBorderColor),
                                                const BorderSide(
                                                    color: Style
                                                        .differBorderColor))),
                                        focusedBorder:
                                            const UnderlineInputBorder(),
                                      ),
                                    ),
                                  if (!AppConstants.isSpecificNumberEnabled)
                                    OutlinedBorderTextField(
                                      textController: phoneName,
                                      inputType: TextInputType.phone,
                                      validation: AppValidators.emptyCheck,
                                      label: AppHelpers.getTranslation(
                                          TrKeys.phoneNumber),
                                    ),
                                  24.verticalSpace,
                                  OutlinedBorderTextField(
                                    textController: tax,
                                    validation: AppValidators.emptyCheck,
                                    inputType: TextInputType.number,
                                    label:
                                        AppHelpers.getTranslation(TrKeys.tax),
                                  ),
                                  24.verticalSpace,
                                  DropdownButtonFormField(
                                    value: value,
                                    items: list
                                        .map((e) => DropdownMenuItem(
                                            value: e, child: Text(e)))
                                        .toList(),
                                    onChanged: (s) {
                                      if (s != null) {
                                        value = s.toString();
                                      }
                                    },
                                    decoration: InputDecoration(
                                      labelText: AppHelpers.getTranslation(
                                          TrKeys.deliveryType),
                                      labelStyle: Style.interNormal(
                                        size: 12,
                                        color: Style.black,
                                      ),
                                      enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide.merge(
                                              const BorderSide(
                                                  color:
                                                      Style.differBorderColor),
                                              const BorderSide(
                                                  color: Style
                                                      .differBorderColor))),
                                      errorBorder: InputBorder.none,
                                      border: const UnderlineInputBorder(),
                                      focusedErrorBorder:
                                          const UnderlineInputBorder(),
                                      disabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide.merge(
                                              const BorderSide(
                                                  color:
                                                      Style.differBorderColor),
                                              const BorderSide(
                                                  color: Style
                                                      .differBorderColor))),
                                      focusedBorder:
                                          const UnderlineInputBorder(),
                                    ),
                                  ),
                                  24.verticalSpace,
                                  OutlinedBorderTextField(
                                    textController: deliveryTimeFrom,
                                    inputType: TextInputType.number,
                                    label: AppHelpers.getTranslation(
                                        TrKeys.deliveryTimeFrom),
                                  ),
                                  24.verticalSpace,
                                  OutlinedBorderTextField(
                                    inputType: TextInputType.number,
                                    textController: deliveryTimeTo,
                                    label: AppHelpers.getTranslation(
                                        TrKeys.deliveryTimeTo),
                                  ),
                                  24.verticalSpace,
                                  OutlinedBorderTextField(
                                    textController: startPrice,
                                    inputType: TextInputType.number,
                                    label: AppHelpers.getTranslation(
                                        TrKeys.startPrice),
                                  ),
                                  24.verticalSpace,
                                  OutlinedBorderTextField(
                                    inputType: TextInputType.number,
                                    textController: pricePerKm,
                                    label: AppHelpers.getTranslation(
                                        TrKeys.pricePerKm),
                                  ),
                                ],
                              ),
                              24.verticalSpace,
                              _setDoc(state),
                              24.verticalSpace,
                              const Divider(),
                              GestureDetector(
                                onTap: () async {
                                  data = await context.pushRoute(ViewMapRoute(
                                      isShopLocation: true, onChanged: () {}));
                                  event.setAddress(data);
                                },
                                child: Container(
                                  color: Style.transparent,
                                  child: Padding(
                                    padding: EdgeInsets.all(16.r),
                                    child: Row(
                                      children: [
                                        Icon(
                                          FlutterRemix.navigation_fill,
                                          size: 20.r,
                                        ),
                                        8.horizontalSpace,
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              AppHelpers.getTranslation(
                                                  TrKeys.address),
                                              style: Style.interNormal(
                                                  size: 12.sp,
                                                  color: Style.black),
                                            ),
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  2,
                                              child: Text(
                                                "${state.addressModel?.title ?? ""}, ${state.addressModel?.address ?? ""}",
                                                style: Style.interNormal(
                                                    size: 12.sp,
                                                    color: Style.black),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const Spacer(),
                                        const Icon(
                                            FlutterRemix.arrow_right_s_line)
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              const Divider(),
                              24.verticalSpace,
                              Padding(
                                padding: EdgeInsets.only(bottom: 32.h),
                                child: CustomButton(
                                  isLoading: state.isSaveLoading,
                                  title: AppHelpers.getTranslation(TrKeys.save),
                                  onPressed: () {
                                    if (form.currentState?.validate() ??
                                        false) {
                                      if (state.logoImage.isEmpty) {
                                        AppHelpers.showCheckTopSnackBar(context,
                                            text: AppHelpers.getTranslation(
                                                TrKeys.logoCanNotBeEmpty));
                                        return;
                                      }
                                      if (state.bgImage.isEmpty) {
                                        AppHelpers.showCheckTopSnackBar(context,
                                            text: AppHelpers.getTranslation(
                                                TrKeys.bgCanNotBeEmpty));
                                        return;
                                      }
                                      if (state
                                              .addressModel?.address?.isEmpty ??
                                          true) {
                                        AppHelpers.showCheckTopSnackBar(context,
                                            text: AppHelpers.getTranslation(
                                                TrKeys.locationCanNotBeEmpty));
                                        return;
                                      }
                                      event.createShop(
                                          context: context,
                                          tax: tax.text,
                                          deliveryTo: deliveryTimeTo.text,
                                          deliveryFrom: deliveryTimeFrom.text,
                                          phone: phoneName.text,
                                          startPrice: startPrice.text,
                                          name: shopName.text,
                                          desc: descName.text,
                                          perKm: pricePerKm.text,
                                          address: data,
                                          deliveryType: value,
                                          categoryId: 0);
                                    }
                                  },
                                ),
                              ),
                              Padding(
                                padding: REdgeInsets.only(bottom: 36),
                                child: CustomButton(
                                  title:
                                      AppHelpers.getTranslation(TrKeys.logout),
                                  onPressed: () =>
                                      AppHelpers.showCustomModalBottomSheet(
                                    context: context,
                                    modal: const LogoutModal(),
                                    isDarkMode: false,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      : state.userData?.shop?.status == "new"
                          ? Column(
                              children: [
                                Lottie.asset('assets/lottie/processing.json'),
                                Text(
                                  AppHelpers.getTranslation(
                                    TrKeys.yourRequest,
                                  ),
                                  style: Style.interNormal(
                                    size: 18,
                                    color: Style.black,
                                  ),
                                ),
                                const Spacer(),
                                Padding(
                                  padding: REdgeInsets.all(24),
                                  child: CustomButton(
                                    title: AppHelpers.getTranslation(
                                        TrKeys.logout),
                                    onPressed: () =>
                                        AppHelpers.showCustomModalBottomSheet(
                                      context: context,
                                      modal: const LogoutModal(),
                                      isDarkMode: false,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : ListView(
                            physics: const BouncingScrollPhysics(),
                            padding: REdgeInsets.all(16),
                            shrinkWrap: true,
                            children: [
                              Column(
                                children: [
                                  12.verticalSpace,
                                  Text(TrKeys.pleaseTryAgain,
                                      style: Style.interSemi()),
                                  12.verticalSpace,
                                  _setBgImage(state),
                                  24.verticalSpace,
                                  Row(
                                    children: [
                                      InkWell(
                                        onTap: () async {
                                          XFile? file;
                                          try {
                                            file = await ImagePicker()
                                                .pickImage(
                                                    source: ImageSource
                                                        .gallery);
                                          } catch (ex) {
                                            debugPrint(
                                                '===> trying to select image $ex');
                                          }
                                          if (file != null) {
                                            event.setLogoImage(file.path);
                                          }
                                        },
                                        child: Container(
                                          width: 50.r,
                                          height: 50.r,
                                          padding: EdgeInsets.all(6.r),
                                          decoration: state
                                                  .logoImage.isNotEmpty
                                              ? BoxDecoration(
                                                  color: Style.black
                                                      .withOpacity(0.27),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          16.r),
                                                  image: DecorationImage(
                                                      image: FileImage(File(
                                                          state.logoImage)),
                                                      fit: BoxFit.cover),
                                                )
                                              : BoxDecoration(
                                                  color: Style.black
                                                      .withOpacity(0.27),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          16.r),
                                                ),
                                          child: const Center(
                                            child: Icon(
                                              FlutterRemix.camera_fill,
                                              color: Style.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                      16.horizontalSpace,
                                      Expanded(
                                        child: OutlinedBorderTextField(
                                          textController: shopName,
                                          label: AppHelpers.getTranslation(
                                            TrKeys.restaurantName,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  24.verticalSpace,
                                  OutlinedBorderTextField(
                                    textController: descName,
                                    label: AppHelpers.getTranslation(
                                        TrKeys.description),
                                  ),
                                  24.verticalSpace,
                                  OutlinedBorderTextField(
                                    textController: phoneName,
                                    inputType: TextInputType.phone,
                                    label: AppHelpers.getTranslation(
                                        TrKeys.phoneNumber),
                                  ),
                                  24.verticalSpace,
                                  OutlinedBorderTextField(
                                    textController: tax,
                                    inputType: TextInputType.number,
                                    label: AppHelpers.getTranslation(
                                        TrKeys.tax),
                                  ),
                                  24.verticalSpace,
                                  DropdownButtonFormField(
                                    value: value,
                                    items: list
                                        .map((e) => DropdownMenuItem(
                                            value: e, child: Text(e)))
                                        .toList(),
                                    onChanged: (s) {
                                      if (s != null) {
                                        value = s.toString();
                                      }
                                    },
                                    decoration: InputDecoration(
                                      labelText: AppHelpers.getTranslation(
                                          TrKeys.deliveryType),
                                      labelStyle: Style.interNormal(
                                        size: 12,
                                        color: Style.black,
                                      ),
                                      enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide.merge(
                                              const BorderSide(
                                                  color: Style
                                                      .differBorderColor),
                                              const BorderSide(
                                                  color: Style
                                                      .differBorderColor))),
                                      errorBorder: InputBorder.none,
                                      border: const UnderlineInputBorder(),
                                      focusedErrorBorder:
                                          const UnderlineInputBorder(),
                                      disabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide.merge(
                                              const BorderSide(
                                                  color: Style
                                                      .differBorderColor),
                                              const BorderSide(
                                                  color: Style
                                                      .differBorderColor))),
                                      focusedBorder:
                                          const UnderlineInputBorder(),
                                    ),
                                  ),
                                  24.verticalSpace,
                                  OutlinedBorderTextField(
                                    textController: deliveryTimeFrom,
                                    inputType: TextInputType.number,
                                    label: AppHelpers.getTranslation(
                                        TrKeys.deliveryTimeFrom),
                                  ),
                                  24.verticalSpace,
                                  OutlinedBorderTextField(
                                    inputType: TextInputType.number,
                                    textController: deliveryTimeTo,
                                    label: AppHelpers.getTranslation(
                                        TrKeys.deliveryTimeTo),
                                  ),
                                  24.verticalSpace,
                                  OutlinedBorderTextField(
                                    textController: startPrice,
                                    inputType: TextInputType.number,
                                    label: AppHelpers.getTranslation(
                                        TrKeys.startPrice),
                                  ),
                                  24.verticalSpace,
                                  OutlinedBorderTextField(
                                    inputType: TextInputType.number,
                                    textController: pricePerKm,
                                    label: AppHelpers.getTranslation(
                                        TrKeys.pricePerKm),
                                  ),
                                ],
                              ),
                              24.verticalSpace,
                              _setDoc(state),
                              24.verticalSpace,
                              const Divider(),
                              GestureDetector(
                                onTap: () async {
                                  data = await context.pushRoute(
                                      ViewMapRoute(
                                          isShopLocation: true,
                                          onChanged: () {}));
                                  event.setAddress(data);
                                },
                                child: Container(
                                  color: Style.transparent,
                                  child: Padding(
                                    padding: EdgeInsets.all(16.r),
                                    child: Row(
                                      children: [
                                        Icon(
                                          FlutterRemix.navigation_fill,
                                          size: 20.r,
                                        ),
                                        8.horizontalSpace,
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              AppHelpers.getTranslation(
                                                  TrKeys.address),
                                              style: Style.interNormal(
                                                  size: 12.sp,
                                                  color: Style.black),
                                            ),
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  2,
                                              child: Text(
                                                "${state.addressModel?.title ?? ""}, ${state.addressModel?.address ?? ""}",
                                                style: Style.interNormal(
                                                    size: 12.sp,
                                                    color: Style.black),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const Spacer(),
                                        const Icon(
                                            FlutterRemix.arrow_right_s_line)
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              const Divider(),
                              24.verticalSpace,
                              Padding(
                                padding: EdgeInsets.only(bottom: 32.h),
                                child: CustomButton(
                                  isLoading: state.isSaveLoading,
                                  title: AppHelpers.getTranslation(
                                      TrKeys.save),
                                  onPressed: () {
                                    event.createShop(
                                      context: context,
                                      tax: tax.text,
                                      deliveryTo: deliveryTimeTo.text,
                                      deliveryFrom: deliveryTimeFrom.text,
                                      phone: phoneName.text,
                                      startPrice: startPrice.text,
                                      name: shopName.text,
                                      desc: descName.text,
                                      perKm: pricePerKm.text,
                                      address: data,
                                      deliveryType: value,
                                      categoryId: 1,
                                    );
                                  },
                                ),
                              ),
                              Padding(
                                padding: REdgeInsets.only(bottom: 36),
                                child: CustomButton(
                                  title: AppHelpers.getTranslation(
                                      TrKeys.logout),
                                  onPressed: () =>
                                      AppHelpers.showCustomModalBottomSheet(
                                    context: context,
                                    modal: const LogoutModal(),
                                    isDarkMode: false,
                                  ),
                                ),
                              ),
                            ],
                          ),
            ),
          ],
        ),
      ),
    );
  }

  Container _setBgImage(ProfileState state) {
    return Container(
      height: 180.h,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Style.white,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: state.bgImage.isNotEmpty
          ? Stack(
              children: [
                SizedBox(
                  height: 180.h,
                  width: double.infinity,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16.r),
                    child: Image.file(
                      File(state.bgImage),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  top: 12.h,
                  right: 16.w,
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () async {
                          XFile? file;
                          try {
                            file = await ImagePicker()
                                .pickImage(source: ImageSource.gallery);
                          } catch (ex) {
                            debugPrint('===> trying to select image $ex');
                          }
                          if (file != null) {
                            event.setBgImage(file.path);
                          }
                        },
                        child: BlurWrap(
                          radius: BorderRadius.circular(20.r),
                          child: Container(
                            height: 40.r,
                            width: 40.r,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Style.white.withOpacity(0.15),
                            ),
                            child: const Icon(
                              FlutterRemix.image_add_fill,
                              color: Style.white,
                            ),
                          ),
                        ),
                      ),
                      10.horizontalSpace,
                      InkWell(
                        onTap: () {
                          event.setBgImage("");
                        },
                        child: BlurWrap(
                          radius: BorderRadius.circular(20.r),
                          child: Container(
                            height: 40.r,
                            width: 40.r,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Style.white.withOpacity(0.15),
                            ),
                            child: const Icon(
                              FlutterRemix.delete_bin_fill,
                              color: Style.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
          : InkWell(
              onTap: () async {
                XFile? file;
                try {
                  file = await ImagePicker()
                      .pickImage(source: ImageSource.gallery);
                } catch (ex) {
                  debugPrint('===> trying to select image $ex');
                }
                if (file != null) {
                  event.setBgImage(file.path);
                }
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    FlutterRemix.upload_cloud_2_line,
                    size: 42.r,
                    color: Style.green,
                  ),
                  16.verticalSpace,
                  Text(
                    AppHelpers.getTranslation(TrKeys.balance),
                    style: Style.interSemi(
                      size: 14,
                      color: Style.black,
                      letterSpacing: -0.3,
                    ),
                  ),
                  Text(
                    AppHelpers.getTranslation(TrKeys.recommendedSize),
                    style: Style.interRegular(
                      size: 14,
                      color: Style.black,
                      letterSpacing: -0.3,
                    ),
                  )
                ],
              ),
            ),
    );
  }

  _setDoc(ProfileState state) {
    return Column(
      children: [
        Container(
          height: 80.h,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Style.white,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: InkWell(
            onTap: () async => await ImgService.getFilePdf(event.setFile),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  FlutterRemix.file_pdf_line,
                  size: 42.r,
                  color: Style.primary,
                ),
                16.verticalSpace,
                Text(
                  AppHelpers.getTranslation(TrKeys.uploadDocuments),
                  style: Style.interNormal(
                    size: 14,
                    color: Style.black,
                    letterSpacing: -0.3,
                  ),
                ),
              ],
            ),
          ),
        ),
        4.verticalSpace,
        ...state.filepath.map(
          (e) => Container(
            decoration: BoxDecoration(
              color: Style.white,
              borderRadius: BorderRadius.circular(6.r),
            ),
            padding: REdgeInsets.symmetric(horizontal: 6, vertical: 6),
            margin: REdgeInsets.only(bottom: 4),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    e,
                    style: Style.interRegular(size: 12.sp),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    event.deleteFile(e);
                  },
                  icon: Icon(
                    FlutterRemix.close_circle_line,
                    size: 21.r,
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
