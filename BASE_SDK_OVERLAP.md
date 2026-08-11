# paas_manager vs base_sdk - same-filename overlap, measured by CONTENT

Every `.dart` in `paas_manager/lib` compared against a same-named file in
`core/base/dart/lib/src` (generated `.freezed.dart`/`.g.dart` excluded).
Ratio is `difflib.SequenceMatcher` over file bodies.

**This supersedes the base_sdk row of `FORK_MAPPING.md` section 1**, which was
built from filename matches and asserted the app's copies were redundant.
Measured against content, most are not.

- same-named files compared: **113**
- identical (>=99%): **10** - safe to delete
- near-identical (85-99%): **26** - review, likely prefer base_sdk
- diverged (40-85%): **42** - must be read individually
- unrelated (<40%): **35** - same name, different feature. Do NOT delete

## Unrelated (<40%) - same name, different code  (35)

| % | paas_manager | base_sdk |
|---|---|---|
| 2.3 | `infrastructure/models/data/shop_data.dart` | `models/data/shop_data.dart` |
| 2.3 | `infrastructure/services/tr_keys.dart` | `services/tr_keys.dart` |
| 4.8 | `application/order/order_notifier.dart` | `application/order/order_notifier.dart` |
| 5.0 | `domain/di/injection.dart` | `di/injection.dart` |
| 5.3 | `infrastructure/models/models.dart` | `models/models.dart` |
| 5.7 | `infrastructure/services/extension.dart` | `services/extension.dart` |
| 5.9 | `infrastructure/services/app_helpers.dart` | `services/app_helpers.dart` |
| 6.2 | `water/infrastructure/services/local_storage.dart` | `services/local_storage.dart` |
| 7.9 | `infrastructure/services/local_storage.dart` | `services/local_storage.dart` |
| 8.4 | `presentation/app_assets.dart` | `presentation/app_assets.dart` |
| 8.6 | `infrastructure/services/enums.dart` | `services/enums.dart` |
| 10.0 | `infrastructure/models/data/unit_data.dart` | `models/data/unit_data.dart` |
| 14.2 | `infrastructure/models/data/product_data.dart` | `models/data/product_data.dart` |
| 14.8 | `infrastructure/services/app_assets.dart` | `services/app_assets.dart` |
| 17.8 | `presentation/pages/initial/no_connection_page.dart` | `presentation/pages/initial/no_connection/no_connection_page.dart` |
| 17.9 | `domain/interface/settings.dart` | `domain/interface/settings.dart` |
| 18.2 | `domain/interface/orders.dart` | `domain/interface/orders.dart` |
| 19.9 | `infrastructure/models/data/order_data.dart` | `models/data/order_data.dart` |
| 20.9 | `presentation/pages/initial/splash_page.dart` | `presentation/pages/initial/splash/splash_page.dart` |
| 21.2 | `domain/interface/products.dart` | `domain/interface/products.dart` |
| 22.1 | `application/order/order_state.dart` | `application/order/order_state.dart` |
| 23.2 | `presentation/component/buttons/pop_button.dart` | `presentation/components/buttons/pop_button.dart` |
| 25.6 | `application/splash/splash_notifier.dart` | `application/splash/splash_notifier.dart` |
| 27.4 | `presentation/component/custom_toggle.dart` | `presentation/components/custom_toggle.dart` |
| 27.9 | `infrastructure/models/response/categories_paginate_response.dart` | `models/response/categories_paginate_response.dart` |
| 28.5 | `infrastructure/services/storage_keys.dart` | `services/storage_keys.dart` |
| 29.6 | `app_constants.dart` | `constants/app_constants.dart` |
| 31.4 | `application/map/view_map_notifier.dart` | `application/map/view_map_notifier.dart` |
| 31.7 | `presentation/component/app_bar_bottom_sheet.dart` | `presentation/components/app_bars/app_bar_bottom_sheet.dart` |
| 32.0 | `infrastructure/services/app_validators.dart` | `services/app_validators.dart` |
| 34.5 | `presentation/component/buttons/social_button.dart` | `presentation/components/buttons/social_button.dart` |
| 34.7 | `presentation/component/title_icon.dart` | `presentation/components/title_icon.dart` |
| 37.8 | `domain/interface/notification.dart` | `domain/interface/notification.dart` |
| 38.5 | `application/profile/profile_notifier.dart` | `application/profile/profile_notifier.dart` |
| 39.8 | `domain/interface/shops.dart` | `domain/interface/shops.dart` |

## Diverged (40-85%) - read individually  (42)

| % | paas_manager | base_sdk |
|---|---|---|
| 42.3 | `infrastructure/services/app_connectivity.dart` | `services/app_connectivity.dart` |
| 44.6 | `infrastructure/models/response/payments_response.dart` | `models/response/payments_response.dart` |
| 44.7 | `presentation/component/loading/loading.dart` | `presentation/components/loading.dart` |
| 45.9 | `infrastructure/models/response/gallery_upload_response.dart` | `models/response/gallery_upload_response.dart` |
| 50.4 | `infrastructure/models/response/mobile_translations_response.dart` | `models/response/mobile_translations_response.dart` |
| 51.3 | `infrastructure/models/data/profile_data.dart` | `models/data/profile_data.dart` |
| 51.3 | `application/notification/notification_provider.dart` | `application/notification/notification_provider.dart` |
| 52.1 | `infrastructure/models/request/edit_profile.dart` | `models/request/edit_profile.dart` |
| 53.4 | `infrastructure/services/time_service.dart` | `services/time_service.dart` |
| 54.7 | `domain/handlers/token_interceptor.dart` | `handlers/token_interceptor.dart` |
| 57.2 | `infrastructure/models/response/profile_response.dart` | `models/response/profile_response.dart` |
| 57.5 | `application/profile/profile_provider.dart` | `application/profile/profile_provider.dart` |
| 58.0 | `domain/handlers/http_service.dart` | `handlers/http_service.dart` |
| 58.1 | `application/main/main_notifier.dart` | `application/main/main_notifier.dart` |
| 58.5 | `infrastructure/models/response/single_shop_response.dart` | `models/response/single_shop_response.dart` |
| 58.7 | `application/splash/splash_provider.dart` | `application/splash/splash_provider.dart` |
| 58.9 | `infrastructure/models/response/single_order_response.dart` | `models/response/single_order_response.dart` |
| 59.9 | `infrastructure/models/response/single_product_response.dart` | `models/response/single_product_response.dart` |
| 62.3 | `infrastructure/models/data/payment_data.dart` | `models/data/payment_data.dart` |
| 62.5 | `domain/handlers/handlers.dart` | `handlers/handlers.dart` |
| 62.7 | `presentation/pages/main/widgets/bottom_navigator_item.dart` | `presentation/components/floating_nav/bottom_navigator_item.dart` |
| 63.7 | `presentation/component/select_item.dart` | `presentation/components/select_item.dart` |
| 63.8 | `infrastructure/models/response/currencies_response.dart` | `models/response/currencies_response.dart` |
| 66.6 | `application/order/order_provider.dart` | `application/order/order_provider.dart` |
| 69.3 | `infrastructure/models/data/review_data.dart` | `models/data/review_data.dart` |
| 69.6 | `application/map/view_map_provider.dart` | `application/map/view_map_provider.dart` |
| 70.3 | `presentation/component/text_fields/search_text_field.dart` | `presentation/components/text_fields/search_text_field.dart` |
| 71.2 | `infrastructure/models/data/remote_message_data.dart` | `models/data/remote_message_data.dart` |
| 71.5 | `presentation/component/custom_checkbox.dart` | `presentation/components/custom_checkbox.dart` |
| 71.7 | `presentation/pages/add_address.dart` | `presentation/components/add_address.dart` |
| 72.3 | `application/main/main_provider.dart` | `application/main/main_provider.dart` |
| 73.6 | `application/profile/profile_state.dart` | `application/profile/profile_state.dart` |
| 73.6 | `infrastructure/models/response/products_paginate_response.dart` | `models/response/products_paginate_response.dart` |
| 74.0 | `infrastructure/models/response/verify_phone_response.dart` | `models/response/verify_phone_response.dart` |
| 74.0 | `infrastructure/models/response/create_order_response.dart` | `models/response/create_order_response.dart` |
| 74.4 | `infrastructure/models/response/login_response.dart` | `models/response/login_response.dart` |
| 75.0 | `presentation/component/buttons/animation_button_effect.dart` | `presentation/components/buttons/animation_button_effect.dart` |
| 75.7 | `infrastructure/models/response/register_response.dart` | `models/response/register_response.dart` |
| 79.9 | `presentation/component/text_fields/outline_bordered_text_field.dart` | `presentation/components/text_fields/outline_bordered_text_field.dart` |
| 81.2 | `presentation/component/buttons/custom_button.dart` | `presentation/components/buttons/custom_button.dart` |
| 83.4 | `infrastructure/models/data/translation.dart` | `models/data/translation.dart` |
| 84.8 | `presentation/component/extras/text_extras.dart` | `presentation/components/extras/text_extras.dart` |

## Near-identical (85-99%) - review  (26)

| % | paas_manager | base_sdk |
|---|---|---|
| 85.1 | `infrastructure/models/data/generate_image_model.dart` | `models/data/generate_image_model.dart` |
| 85.4 | `presentation/component/buttons/forgot_text_button.dart` | `presentation/components/buttons/forgot_text_button.dart` |
| 86.0 | `presentation/component/helper/no_data_info.dart` | `presentation/components/helper/no_data_info.dart` |
| 86.8 | `application/map/view_map_state.dart` | `application/map/view_map_state.dart` |
| 87.1 | `application/notification/notification_state.dart` | `application/notification/notification_state.dart` |
| 87.5 | `presentation/component/tab_bars/custom_tab_bar.dart` | `presentation/components/custom_tab_bar.dart` |
| 87.9 | `infrastructure/models/data/shop_delivery.dart` | `models/data/shop_delivery.dart` |
| 88.1 | `domain/interface/auth.dart` | `domain/interface/auth.dart` |
| 88.2 | `infrastructure/services/marker_image_cropper.dart` | `services/marker_image_cropper.dart` |
| 88.8 | `infrastructure/models/data/notification_data.dart` | `models/data/notification_data.dart` |
| 89.0 | `presentation/component/extras/image_extras.dart` | `presentation/components/extras/image_extras.dart` |
| 89.3 | `infrastructure/models/data/count_of_notifications_data.dart` | `models/data/count_of_notifications_data.dart` |
| 89.9 | `infrastructure/models/data/login.dart` | `models/data/login.dart` |
| 90.5 | `presentation/component/list_items/size_item.dart` | `presentation/components/size_item.dart` |
| 90.6 | `application/notification/notification_notifier.dart` | `application/notification/notification_notifier.dart` |
| 91.3 | `presentation/component/common_app_bar.dart` | `presentation/components/app_bars/common_app_bar.dart` |
| 92.4 | `infrastructure/models/data/user.dart` | `models/data/user.dart` |
| 93.0 | `presentation/component/extras/color_extras.dart` | `presentation/components/extras/color_extras.dart` |
| 94.0 | `infrastructure/models/response/wallet_histories_response.dart` | `models/response/wallet_histories_response.dart` |
| 94.7 | `infrastructure/models/data/typed_extra.dart` | `models/data/typed_extra.dart` |
| 96.0 | `domain/handlers/network_exceptions.dart` | `handlers/network_exceptions.dart` |
| 96.2 | `infrastructure/models/data/referral_data.dart` | `models/data/referral_data.dart` |
| 96.6 | `infrastructure/models/response/notification_response.dart` | `models/response/notification_response.dart` |
| 96.7 | `domain/handlers/api_result.dart` | `handlers/api_result.dart` |
| 97.1 | `infrastructure/models/response/transactions_response.dart` | `models/response/transactions_response.dart` |
| 97.9 | `infrastructure/models/request/sign_up_request.dart` | `models/request/sign_up_request.dart` |

## Identical (>=99%) - safe to delete  (10)

| % | paas_manager | base_sdk |
|---|---|---|
| 99.3 | `infrastructure/models/response/multi_gallery_upload_response.dart` | `models/response/multi_gallery_upload_response.dart` |
| 99.3 | `infrastructure/models/data/blog_data.dart` | `models/data/blog_data.dart` |
| 99.4 | `utils/excluded_product_ids.dart` | `utils/excluded_product_ids.dart` |
| 99.7 | `presentation/component/helper/blur_wrap.dart` | `presentation/components/blur_wrap.dart` |
| 99.7 | `application/main/main_state.dart` | `application/main/main_state.dart` |
| 100.0 | `infrastructure/models/data/currency_data.dart` | `models/data/currency_data.dart` |
| 100.0 | `application/splash/splash_state.dart` | `application/splash/splash_state.dart` |
| 100.0 | `infrastructure/models/data/meta.dart` | `models/data/meta.dart` |
| 100.0 | `infrastructure/services/img_service.dart` | `services/img_service.dart` |
| 100.0 | `infrastructure/services/tpying_delay.dart` | `services/tpying_delay.dart` |
