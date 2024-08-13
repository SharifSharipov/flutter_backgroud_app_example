import "dart:async";
import "package:flutter/material.dart";
import "package:flutter_backgroud_app_example/features/get_location_page/presentation/manager/bloc/location_bloc/location_bloc.dart";
import "package:flutter_backgroud_app_example/features/get_location_page/presentation/pages/get_location_page_mixin.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:yandex_mapkit/yandex_mapkit.dart" as yandex;

import "../../domain/service/location_service.dart";

class GetLocationPage extends StatefulWidget {
  const GetLocationPage({super.key});

  @override
  State<GetLocationPage> createState() => _GetLocationPageState();
}

class _GetLocationPageState extends State<GetLocationPage> with GetLocationPageMixin {
 // ThemeTextStyles get theme => Theme.of(context).extension<ThemeTextStyles>()!;
  TextEditingController textEditingControllerPlaceName = TextEditingController();
  TextEditingController textEditingControllerEntrance = TextEditingController();
  TextEditingController textEditingControllerFloor = TextEditingController();
  TextEditingController textEditingControllerApartment = TextEditingController();
  TextEditingController textEditingControllerReferencePoint = TextEditingController();
  TextEditingController textEditingControllerAddressName = TextEditingController();
  @override
  Widget build(BuildContext context) => BlocConsumer<LocationBloc, LocationState>(
        listener: (BuildContext context, LocationState state) {
          debugPrint("мапс: $mapObjects ");
          if (state is LocationSucces) {
            textEditingController.text = state.locationModel.response?.geoObjectCollection?.metaDataProperty
                    ?.geocoderMetaData?.address?.formatted ??
                "";
            addMarker(appLatLong: appLatLong);
          }
        },
        builder: (BuildContext context, LocationState state) => Scaffold(
          resizeToAvoidBottomInset: false,
          body: Stack(
            children: <Widget>[
              Positioned.fill(
                child: yandex.YandexMap(
                  mapObjects: mapObjects,
                  onCameraPositionChanged: (cameraPositon, reason, finished) {},
                  onMapCreated: mapControllerCompleter.complete,
                  onMapTap: (yandex.Point point) {
                    BlocProvider.of<LocationBloc>(context)
                        .add(GetLocationEvent(appLatLong: AppLatLong(lat: point.latitude, long: point.longitude)));
                    print("on map tap : ${point.latitude} ${point.longitude}");
                    updateMarker(appLatLong: AppLatLong(lat: point.latitude, long: point.longitude));
                /*    unawaited(showModalBottomSheet(
                      isScrollControlled: true,
                      backgroundColor: Colors.white,
                      showDragHandle: false,
                      elevation: 0,
                      context: context,
                      builder: (_) => Padding(
                        padding: EdgeInsets.zero,
                        child: Padding(
                          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                          child: AddAddress(
                            textEditingControllerPlaceName: textEditingControllerPlaceName,
                            textEditingControllerEntrance: textEditingControllerEntrance,
                            textEditingControllerFloor: textEditingControllerFloor,
                            textEditingControllerApartment: textEditingControllerApartment,
                            textEditingControllerReferencePoint: textEditingControllerReferencePoint,
                            hintTextPlaceName: (state is LocationSucces)
                                ? state.locationModel.response!.geoObjectCollection!.featureMember![0].geoObject!.name!
                                : "",
                            hintTextEntrance: "Подъезд",
                            hintTextPlaceFloor: "Этаж",
                            hintTextPlaceApartment: "Квартира",
                            hintTextReferencePoint: "Ориентир",
                            valueChangedPlaceName: (value) {
                              textEditingController.text = (state is LocationSucces)
                                  ? state
                                      .locationModel.response!.geoObjectCollection!.featureMember![0].geoObject!.name!
                                  : "";
                            },
                            valueChangedEntrance: (value) {},
                            valueChangedPlaceFloor: (value) {},
                            valueChangedPlaceApartment: (value) {},
                            valueChangedReferencePoint: (value) {},
                            textEditingControllerAddressName: textEditingControllerAddressName,
                            hintTextAddressName: "Название адреса",
                            valueChangedAddressName: (value) {},
                            addOptionalData: () {
                              if (textEditingControllerAddressName.text.isNotEmpty &&
                                  textEditingControllerApartment.text.isNotEmpty &&
                                  textEditingControllerEntrance.text.isNotEmpty &&
                                  textEditingControllerFloor.text.isNotEmpty &&
                                  textEditingControllerReferencePoint.text.isNotEmpty) {
                                print("ikki marta?");
                                BlocProvider.of<UploadLocationBloc>(context).add(UploadLocationSuccess(
                                    address: (state is LocationSucces)
                                        ? state.locationModel.response!.geoObjectCollection!.featureMember![0]
                                            .geoObject!.name!
                                        : "",
                                    entrance: textEditingControllerEntrance.text,
                                    floor: textEditingControllerFloor.text,
                                    apartment: textEditingControllerApartment.text,
                                    referencePoint: textEditingControllerReferencePoint.text,
                                    name: textEditingControllerAddressName.text));
                                context.go(Routes.basketPage);
                                print("add optional data------>qori aka---->${textEditingControllerAddressName.text}");
                              }
                              textEditingControllerEntrance.clear();
                              textEditingControllerFloor.clear();
                              textEditingControllerApartment.clear();
                              textEditingControllerReferencePoint.clear();
                              textEditingControllerAddressName.clear();
                            },
                          ),
                        ),
                      ),
                    ));*/
                  },
                ),
              ),
              Positioned(
                top: height / 15,
                left: 20,
                child: GestureDetector(
                  onTap: () {
                   // context.go(Routes.homePage);
                  },
                  child: SizedBox(
                    width: width / 8,
                    height: height / 20,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Colors.black.withOpacity(0.11),
                          )),
                      child: const Padding(
                        padding: EdgeInsets.all(4),
                        child: Icon(
                          Icons.arrow_back,
                          color: Colors.black,
                          size: 20,
                        )
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
