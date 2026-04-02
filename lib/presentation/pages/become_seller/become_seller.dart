import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:venderfoodyman/application/profile/profile_notifier.dart';
import 'package:venderfoodyman/application/profile/profile_provider.dart';
import 'package:venderfoodyman/application/profile/profile_state.dart';
import 'package:venderfoodyman/infrastructure/services/services.dart';
import 'package:venderfoodyman/presentation/component/components.dart';
import 'package:venderfoodyman/presentation/pages/become_seller/widgets/address_selector.dart';
import 'package:venderfoodyman/presentation/pages/become_seller/widgets/background_image_picker.dart';
import 'package:venderfoodyman/presentation/pages/become_seller/widgets/document_upload_section.dart';
import 'package:venderfoodyman/presentation/pages/become_seller/widgets/logo_and_name_section.dart';
import 'package:venderfoodyman/presentation/pages/become_seller/widgets/processing_view.dart';
import 'package:venderfoodyman/presentation/pages/become_seller/widgets/shop_form_fields.dart';
import 'package:venderfoodyman/presentation/pages/restaurant/widgets/logout_modal.dart';
import 'package:venderfoodyman/presentation/styles/style.dart';

@RoutePage()
class CreateShopPage extends ConsumerStatefulWidget {
  const CreateShopPage({super.key});

  @override
  ConsumerState<CreateShopPage> createState() => _CreateShopPageState();
}

class _CreateShopPageState extends ConsumerState<CreateShopPage> {
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
  dynamic addressData;

  final List<String> deliveryTypes = ["minute", "day", "month"];
  String selectedDeliveryType = "minute";

  @override
  void initState() {
    super.initState();
    _initControllers();
    _loadUserData();
  }

  void _initControllers() {
    shopName = TextEditingController();
    descName = TextEditingController();
    phoneName = TextEditingController();
    deliveryTimeFrom = TextEditingController();
    deliveryTimeTo = TextEditingController();
    startPrice = TextEditingController();
    pricePerKm = TextEditingController();
    tax = TextEditingController();
  }

  void _loadUserData() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(profileProvider.notifier).resetShopData();
      ref
          .read(profileProvider.notifier)
          .fetchUser(
            context,
            onSuccess: (phone) {
              if (!AppConstants.isSpecificNumberEnabled) {
                phoneName.text = phone ?? '';
              } else {
                final smt = PhoneNumber.fromCompleteNumber(
                  completeNumber: "+${phone?.replaceAll("+", "")}",
                );
                phoneName.text = smt.number;
              }
            },
          );
    });
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
                style: AppStyle.interSemi(size: 18, color: AppStyle.black),
              ),
            ),
            Expanded(
              child: state.isLoading ? const Loading() : _buildContent(state),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent(ProfileState state) {
    if (state.userData?.shop == null) {
      return _buildShopForm(state, categoryId: 0);
    } else if (state.userData?.shop?.status == "new") {
      return const ProcessingView();
    } else {
      return _buildShopForm(state, categoryId: 1, isRetry: true);
    }
  }

  Widget _buildShopForm(
    ProfileState state, {
    required int categoryId,
    bool isRetry = false,
  }) {
    return Form(
      key: form,
      child: ListView(
        physics: const BouncingScrollPhysics(),
        padding: REdgeInsets.only(top: 12, left: 16, right: 16),
        shrinkWrap: true,
        children: [
          if (isRetry) ...[
            Container(
              padding: EdgeInsets.all(16.r),
              decoration: BoxDecoration(
                color: AppStyle.red.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(
                  color: AppStyle.red.withOpacity(0.3),
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    FlutterRemix.error_warning_line,
                    color: AppStyle.red,
                    size: 24.r,
                  ),
                  12.horizontalSpace,
                  Expanded(
                    child: Text(
                      AppHelpers.getTranslation(TrKeys.pleaseTryAgain),
                      style: AppStyle.interSemi(size: 14, color: AppStyle.red),
                    ),
                  ),
                ],
              ),
            ),
            24.verticalSpace,
          ],
          BackgroundImagePicker(bgImage: state.bgImage, event: event),
          24.verticalSpace,
          LogoAndNameSection(
            logoImage: state.logoImage,
            shopNameController: shopName,
            event: event,
            validation: AppValidators.emptyCheck,
          ),
          24.verticalSpace,
          ShopFormFields(
            descController: descName,
            phoneController: phoneName,
            taxController: tax,
            deliveryTimeFromController: deliveryTimeFrom,
            deliveryTimeToController: deliveryTimeTo,
            startPriceController: startPrice,
            pricePerKmController: pricePerKm,
            selectedDeliveryType: selectedDeliveryType,
            deliveryTypeList: deliveryTypes,
            isSpecificNumberEnabled: AppConstants.isSpecificNumberEnabled,
            onDeliveryTypeChanged: (value) {
              if (value != null) {
                setState(() {
                  selectedDeliveryType = value.toString();
                });
              }
            },
          ),
          24.verticalSpace,
          DocumentUploadSection(filePaths: state.filepath, event: event),
          24.verticalSpace,
          AddressSelector(
            addressModel: state.addressModel,
            onAddressSelected: (data) {
              addressData = data;
              event.setAddress(data);
            },
          ),
          32.verticalSpace,
          CustomButton(
            isLoading: state.isSaveLoading,
            title: AppHelpers.getTranslation(TrKeys.save),
            onPressed: () => _handleSave(state, categoryId),
          ),
          16.verticalSpace,
          OutlinedButton(
            onPressed: () => AppHelpers.showCustomModalBottomSheet(
              context: context,
              modal: const LogoutModal(),
              isDarkMode: false,
            ),
            style: OutlinedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 16.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
              side: BorderSide(
                color: AppStyle.red.withOpacity(0.5),
                width: 1.5,
              ),
            ),
            child: Text(
              AppHelpers.getTranslation(TrKeys.logout),
              style: AppStyle.interSemi(size: 15, color: AppStyle.red),
            ),
          ),
          36.verticalSpace,
        ],
      ),
    );
  }

  void _handleSave(ProfileState state, int categoryId) {
    if (!(form.currentState?.validate() ?? false)) {
      return;
    }

    if (categoryId == 0) {
      if (state.logoImage.isEmpty) {
        AppHelpers.showCheckTopSnackBar(
          context,
          text: AppHelpers.getTranslation(TrKeys.logoCanNotBeEmpty),
        );
        return;
      }
      if (state.bgImage.isEmpty) {
        AppHelpers.showCheckTopSnackBar(
          context,
          text: AppHelpers.getTranslation(TrKeys.bgCanNotBeEmpty),
        );
        return;
      }
      if (state.addressModel?.address?.isEmpty ?? true) {
        AppHelpers.showCheckTopSnackBar(
          context,
          text: AppHelpers.getTranslation(TrKeys.locationCanNotBeEmpty),
        );
        return;
      }
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
      address: addressData,
      deliveryType: selectedDeliveryType,
      categoryId: categoryId,
    );
  }
}
