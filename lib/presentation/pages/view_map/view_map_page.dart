import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:venderfoodyman/application/map/view_map_notifier.dart';
import 'package:venderfoodyman/application/map/view_map_provider.dart';
import 'package:venderfoodyman/application/map/view_map_state.dart';
import 'package:venderfoodyman/domain/di/dependency_manager.dart';
import 'package:venderfoodyman/infrastructure/models/models.dart';
import 'package:venderfoodyman/infrastructure/services/services.dart';
import 'package:venderfoodyman/presentation/app_assets.dart';
import 'package:venderfoodyman/presentation/component/components.dart';
import 'package:venderfoodyman/presentation/routes/app_router.dart';
import 'package:venderfoodyman/presentation/styles/style.dart';

@RoutePage()
class ViewMapPage extends ConsumerStatefulWidget {
  final bool isShopLocation;
  final int? shopId;
  final VoidCallback onChanged;

  const ViewMapPage(
    this.onChanged, {
    super.key,
    this.isShopLocation = false,
    this.shopId,
  });

  @override
  ConsumerState<ViewMapPage> createState() => _ViewMapPageState();
}

class _ViewMapPageState extends ConsumerState<ViewMapPage> {
  late ViewMapNotifier event;
  late TextEditingController controller;
  late TextEditingController office;
  late TextEditingController house;
  late TextEditingController floor;
  final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;
  GoogleMapController? googleMapController;
  CameraPosition? cameraPosition;
  dynamic check;
  late LatLng latLng;

  @override
  void didChangeDependencies() {
    event = ref.read(viewMapProvider.notifier);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    controller.dispose();
    office.dispose();
    house.dispose();
    floor.dispose();
    super.dispose();
  }

  Future<void> checkPermission() async {
    check = await _geolocatorPlatform.checkPermission();
  }

  Future<void> getMyLocation() async {
    if (check == LocationPermission.denied ||
        check == LocationPermission.deniedForever) {
      check = await Geolocator.requestPermission();
      if (check != LocationPermission.denied &&
          check != LocationPermission.deniedForever) {
        var loc = await Geolocator.getCurrentPosition();
        latLng = LatLng(loc.latitude, loc.longitude);
        googleMapController!.animateCamera(
          CameraUpdate.newLatLngZoom(latLng, 15),
        );
      }
    } else {
      if (check != LocationPermission.deniedForever) {
        var loc = await Geolocator.getCurrentPosition();
        latLng = LatLng(loc.latitude, loc.longitude);
        googleMapController!.animateCamera(
          CameraUpdate.newLatLngZoom(latLng, 15),
        );
      }
    }
  }

  @override
  void initState() {
    controller = TextEditingController();
    office = TextEditingController();
    house = TextEditingController();
    floor = TextEditingController();
    latLng = LatLng(
      LocalStorage.getShop()?.location?.latitude ??
          (AppHelpers.getInitialLatitude() ?? AppConstants.demoLatitude),
      LocalStorage.getShop()?.location?.longitude ??
          (AppHelpers.getInitialLongitude() ?? AppConstants.demoLongitude),
    );
    checkPermission();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(viewMapProvider);
    final bool isLtr = LocalStorage.getLangLtr();
    return KeyboardDisable(
      child: Directionality(
        textDirection: isLtr ? TextDirection.ltr : TextDirection.rtl,
        child: Scaffold(
          backgroundColor: AppStyle.black,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: SlidingUpPanel(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15.r),
                    topRight: Radius.circular(15.r),
                  ),
                  minHeight: 240.h,
                  maxHeight: 240.h,
                  color: AppStyle.white,
                  body: Padding(
                    padding: REdgeInsets.only(bottom: 0),
                    child: Stack(
                      children: [
                        GoogleMap(
                          padding: REdgeInsets.only(bottom: 240.h),
                          myLocationButtonEnabled: false,
                          initialCameraPosition: CameraPosition(
                            bearing: 0,
                            target: latLng,
                            tilt: 0,
                            zoom: 17,
                          ),
                          mapToolbarEnabled: false,
                          zoomControlsEnabled: true,
                          onTap: (position) {
                            event.updateActive();
                            Delayed(milliseconds: 700).run(() async {
                              try {
                                final List<Placemark> placemarks =
                                    await placemarkFromCoordinates(
                                      cameraPosition?.target.latitude ??
                                          latLng.latitude,
                                      cameraPosition?.target.longitude ??
                                          latLng.longitude,
                                    );

                                if (placemarks.isNotEmpty) {
                                  final Placemark pos = placemarks[0];
                                  final List<String> addressData = [];
                                  addressData.add(pos.locality!);
                                  if (pos.subLocality != null &&
                                      pos.subLocality!.isNotEmpty) {
                                    addressData.add(pos.subLocality!);
                                  }
                                  if (pos.thoroughfare != null &&
                                      pos.thoroughfare!.isNotEmpty) {
                                    addressData.add(pos.thoroughfare!);
                                  }
                                  addressData.add(pos.name!);
                                  final String placeName = addressData.join(
                                    ', ',
                                  );
                                  controller.text = placeName;
                                }
                              } catch (e) {
                                controller.text = '';
                              }

                              event
                              // ..checkDriverZone(
                              //     context: context,
                              //     location: LatLng(
                              //       cameraPosition?.target.latitude ??
                              //           latLng.latitude,
                              //       cameraPosition?.target.longitude ??
                              //           latLng.longitude,
                              //     ),
                              //     shopId: widget.shopId)
                              .changePlace(
                                AddressData(
                                  title: controller.text,
                                  address: controller.text,
                                  location: LocationData(
                                    latitude:
                                        cameraPosition?.target.latitude ??
                                        latLng.latitude,
                                    longitude:
                                        cameraPosition?.target.longitude ??
                                        latLng.longitude,
                                  ),
                                ),
                              );
                            });
                            googleMapController!.animateCamera(
                              CameraUpdate.newLatLngZoom(position, 15),
                            );
                          },
                          onCameraIdle: () {
                            event.updateActive();
                            Delayed(milliseconds: 700).run(() async {
                              try {
                                final List<Placemark> placemarks =
                                    await placemarkFromCoordinates(
                                      cameraPosition?.target.latitude ??
                                          latLng.latitude,
                                      cameraPosition?.target.longitude ??
                                          latLng.longitude,
                                    );

                                if (placemarks.isNotEmpty) {
                                  final Placemark pos = placemarks[0];
                                  final List<String> addressData = [];
                                  addressData.add(pos.locality!);
                                  if (pos.subLocality != null &&
                                      pos.subLocality!.isNotEmpty) {
                                    addressData.add(pos.subLocality!);
                                  }
                                  if (pos.thoroughfare != null &&
                                      pos.thoroughfare!.isNotEmpty) {
                                    addressData.add(pos.thoroughfare!);
                                  }
                                  addressData.add(pos.name!);
                                  final String placeName = addressData.join(
                                    ', ',
                                  );
                                  controller.text = placeName;
                                }
                              } catch (e) {
                                controller.text = '';
                              }

                              event.changePlace(
                                AddressData(
                                  title: controller.text,
                                  address: controller.text,
                                  location: LocationData(
                                    latitude:
                                        cameraPosition?.target.latitude ??
                                        latLng.latitude,
                                    longitude:
                                        cameraPosition?.target.longitude ??
                                        latLng.longitude,
                                  ),
                                ),
                              );
                            });
                          },
                          onCameraMove: (position) {
                            cameraPosition = position;
                          },
                          onMapCreated: (controller) {
                            googleMapController = controller;
                          },
                        ),
                        Positioned(
                          bottom:
                              MediaQuery.paddingOf(context).bottom +
                              85.h +
                              MediaQuery.sizeOf(context).height / 2,
                          left: MediaQuery.sizeOf(context).width / 2 - 23.w,
                          child: Image.asset(
                            Assets.imageMarker,
                            width: 46.w,
                            height: 46.h,
                          ),
                        ),
                        Positioned(
                          bottom: 260.h,
                          right: 16.w,
                          child: InkWell(
                            onTap: () async {
                              await getMyLocation();
                            },
                            child: Container(
                              width: 50.r,
                              height: 50.r,
                              decoration: BoxDecoration(
                                color: AppStyle.white,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10.r),
                                ),
                                boxShadow: const [
                                  BoxShadow(
                                    color: AppStyle.shimmerBase,
                                    blurRadius: 2,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: const Center(
                                child: Icon(FlutterRemix.navigation_line),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  padding: REdgeInsets.symmetric(horizontal: 15),
                  panel: _bottomSheet(context, state),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _bottomSheet(BuildContext context, ViewMapState state) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        8.verticalSpace,
        Container(
          width: 49.w,
          height: 3.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40.r),
            color: AppStyle.dragElement,
          ),
        ),
        16.verticalSpace,
        TitleAndIcon(
          title: AppHelpers.getTranslation(TrKeys.enterADeliveryAddress),
        ),
        24.verticalSpace,
        SearchTextField(
          isRead: true,
          isBorder: true,
          textEditingController: controller,
          onTap: () async {
            final placeId = await context.pushRoute(const MapSearchRoute());
            if (placeId != null) {
              final res = await googlePlace.details.get(placeId.toString());
              try {
                final List<Placemark> placemarks =
                    await placemarkFromCoordinates(
                      res?.result?.geometry?.location?.lat ?? latLng.latitude,
                      res?.result?.geometry?.location?.lng ?? latLng.longitude,
                    );

                if (placemarks.isNotEmpty) {
                  final Placemark pos = placemarks[0];
                  final List<String> addressData = [];
                  addressData.add(pos.locality!);
                  if (pos.subLocality != null && pos.subLocality!.isNotEmpty) {
                    addressData.add(pos.subLocality!);
                  }
                  if (pos.thoroughfare != null &&
                      pos.thoroughfare!.isNotEmpty) {
                    addressData.add(pos.thoroughfare!);
                  }
                  addressData.add(pos.name!);
                  final String placeName = addressData.join(', ');
                  controller.text = placeName;
                }
              } catch (e) {
                controller.text = '';
              }

              googleMapController!.animateCamera(
                CameraUpdate.newLatLngZoom(
                  LatLng(
                    res?.result?.geometry?.location?.lat ?? latLng.latitude,
                    res?.result?.geometry?.location?.lng ?? latLng.longitude,
                  ),
                  15,
                ),
              );
              event.changePlace(
                AddressData(
                  title: controller.text,
                  address: controller.text,
                  location: LocationData(
                    latitude:
                        res?.result?.geometry?.location?.lat ?? latLng.latitude,
                    longitude:
                        res?.result?.geometry?.location?.lng ??
                        latLng.longitude,
                  ),
                ),
              );
            }
          },
        ),
        24.verticalSpace,
        Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.paddingOf(context).bottom,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const PopButton(heroTag: ''),
              24.horizontalSpace,
              Expanded(
                child: Consumer(
                  builder: (BuildContext context, WidgetRef ref, Widget? child) {
                    //final event = ref.read(profileProvider.notifier);
                    return CustomButton(
                      isLoading: false,
                      textColor: AppStyle.black,
                      title: AppHelpers.getTranslation(TrKeys.apply),
                      onPressed: () {
                        if (cameraPosition != null &&
                            cameraPosition?.target != null) {
                          // event.setAddress(LocationData(
                          //   latitude: cameraPosition?.target.latitude, longitude: cameraPosition?.target.longitude
                          // ));
                        }
                        Navigator.pop(context, state.place);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
