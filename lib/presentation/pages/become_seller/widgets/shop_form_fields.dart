import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:venderfoodyman/infrastructure/services/services.dart';
import 'package:venderfoodyman/presentation/component/components.dart';
import 'package:venderfoodyman/presentation/styles/style.dart';

class ShopFormFields extends StatelessWidget {
  final TextEditingController descController;
  final TextEditingController phoneController;
  final TextEditingController taxController;
  final TextEditingController deliveryTimeFromController;
  final TextEditingController deliveryTimeToController;
  final TextEditingController startPriceController;
  final TextEditingController pricePerKmController;
  final String selectedDeliveryType;
  final List deliveryTypeList;
  final Function(String?) onDeliveryTypeChanged;
  final bool isSpecificNumberEnabled;

  const ShopFormFields({
    super.key,
    required this.descController,
    required this.phoneController,
    required this.taxController,
    required this.deliveryTimeFromController,
    required this.deliveryTimeToController,
    required this.startPriceController,
    required this.pricePerKmController,
    required this.selectedDeliveryType,
    required this.deliveryTypeList,
    required this.onDeliveryTypeChanged,
    this.isSpecificNumberEnabled = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Basic Information'),
        12.verticalSpace,
        OutlinedBorderTextField(
          textController: descController,
          validation: AppValidators.emptyCheck,
          label: AppHelpers.getTranslation(TrKeys.description),
        ),
        24.verticalSpace,
        if (isSpecificNumberEnabled)
          _buildPhoneField()
        else
          OutlinedBorderTextField(
            textController: phoneController,
            inputType: TextInputType.phone,
            validation: AppValidators.emptyCheck,
            label: AppHelpers.getTranslation(TrKeys.phoneNumber),
          ),
        24.verticalSpace,
        OutlinedBorderTextField(
          textController: taxController,
          validation: AppValidators.emptyCheck,
          inputType: TextInputType.number,
          label: AppHelpers.getTranslation(TrKeys.tax),
        ),
        24.verticalSpace,
        _buildDeliveryTypeDropdown(),
        24.verticalSpace,
        _buildSectionTitle('Delivery Settings'),
        12.verticalSpace,
        Row(
          children: [
            Expanded(
              child: OutlinedBorderTextField(
                textController: deliveryTimeFromController,
                inputType: TextInputType.number,
                label: AppHelpers.getTranslation(TrKeys.deliveryTimeFrom),
              ),
            ),
            16.horizontalSpace,
            Expanded(
              child: OutlinedBorderTextField(
                inputType: TextInputType.number,
                textController: deliveryTimeToController,
                label: AppHelpers.getTranslation(TrKeys.deliveryTimeTo),
              ),
            ),
          ],
        ),
        24.verticalSpace,
        _buildSectionTitle('Pricing'),
        12.verticalSpace,
        Row(
          children: [
            Expanded(
              child: OutlinedBorderTextField(
                textController: startPriceController,
                inputType: TextInputType.number,
                label: AppHelpers.getTranslation(TrKeys.startPrice),
              ),
            ),
            16.horizontalSpace,
            Expanded(
              child: OutlinedBorderTextField(
                inputType: TextInputType.number,
                textController: pricePerKmController,
                label: AppHelpers.getTranslation(TrKeys.pricePerKm),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.only(left: 4.w),
      child: Text(
        title,
        style: AppStyle.interSemi(size: 14, color: AppStyle.black),
      ),
    );
  }

  Widget _buildPhoneField() {
    return IntlPhoneField(
      disableLengthCheck: !AppConstants.isNumberLengthAlwaysSame,
      controller: phoneController,
      validator: (s) {
        if (AppConstants.isNumberLengthAlwaysSame &&
            (s?.isValidNumber() ?? true)) {
          return AppHelpers.getTranslation(TrKeys.phoneNumberIsNotValid);
        }
        return null;
      },
      keyboardType: TextInputType.phone,
      initialCountryCode: AppConstants.countryCodeISO,
      invalidNumberMessage: AppHelpers.getTranslation(
        TrKeys.phoneNumberIsNotValid,
      ),
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      showCountryFlag: AppConstants.showFlag,
      showDropdownIcon: AppConstants.showArrowIcon,
      autovalidateMode: AppConstants.isNumberLengthAlwaysSame
          ? AutovalidateMode.onUserInteraction
          : AutovalidateMode.disabled,
      textAlignVertical: TextAlignVertical.center,
      decoration: InputDecoration(
        counterText: '',
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide.merge(
            const BorderSide(color: AppStyle.differBorderColor),
            const BorderSide(color: AppStyle.differBorderColor),
          ),
        ),
        errorBorder: UnderlineInputBorder(
          borderSide: BorderSide.merge(
            const BorderSide(color: AppStyle.differBorderColor),
            const BorderSide(color: AppStyle.differBorderColor),
          ),
        ),
        border: const UnderlineInputBorder(),
        focusedErrorBorder: const UnderlineInputBorder(),
        disabledBorder: UnderlineInputBorder(
          borderSide: BorderSide.merge(
            const BorderSide(color: AppStyle.differBorderColor),
            const BorderSide(color: AppStyle.differBorderColor),
          ),
        ),
        focusedBorder: const UnderlineInputBorder(),
      ),
    );
  }

  Widget _buildDeliveryTypeDropdown() {
    return DropdownButtonFormField<String>(
      value: selectedDeliveryType,
      items: deliveryTypeList
          .map((e) => DropdownMenuItem<String>(value: e, child: Text(e)))
          .toList(),
      onChanged: onDeliveryTypeChanged,
      decoration: InputDecoration(
        labelText: AppHelpers.getTranslation(TrKeys.deliveryType),
        labelStyle: AppStyle.interNormal(size: 12, color: AppStyle.black),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide.merge(
            const BorderSide(color: AppStyle.differBorderColor),
            const BorderSide(color: AppStyle.differBorderColor),
          ),
        ),
        errorBorder: InputBorder.none,
        border: const UnderlineInputBorder(),
        focusedErrorBorder: const UnderlineInputBorder(),
        disabledBorder: UnderlineInputBorder(
          borderSide: BorderSide.merge(
            const BorderSide(color: AppStyle.differBorderColor),
            const BorderSide(color: AppStyle.differBorderColor),
          ),
        ),
        focusedBorder: const UnderlineInputBorder(),
      ),
    );
  }
}
