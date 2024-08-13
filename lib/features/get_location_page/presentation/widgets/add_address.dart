import "package:flutter/material.dart";
import "package:flutter_backgroud_app_example/core/extention/size_extention.dart";
import "package:flutter_backgroud_app_example/features/get_location_page/presentation/widgets/get_address_text_filed.dart";
import "package:gap/gap.dart";

class AddAddress extends StatefulWidget {
  const AddAddress({
    super.key,
    required this.textEditingControllerPlaceName,
    required this.textEditingControllerEntrance,
    required this.textEditingControllerFloor,
    required this.textEditingControllerApartment,
    required this.textEditingControllerReferencePoint,
    required this.hintTextPlaceName,
    required this.hintTextEntrance,
    required this.hintTextPlaceFloor,
    required this.hintTextPlaceApartment,
    required this.hintTextReferencePoint,
    required this.valueChangedPlaceName,
    required this.valueChangedEntrance,
    required this.valueChangedPlaceFloor,
    required this.valueChangedPlaceApartment,
    required this.valueChangedReferencePoint,
    required this.textEditingControllerAddressName,
    required this.hintTextAddressName,
    required this.valueChangedAddressName,
    required this.addOptionalData,
  });
  final TextEditingController textEditingControllerPlaceName;
  final TextEditingController textEditingControllerEntrance;
  final TextEditingController textEditingControllerFloor;
  final TextEditingController textEditingControllerApartment;
  final TextEditingController textEditingControllerReferencePoint;
  final TextEditingController textEditingControllerAddressName;
  final String hintTextPlaceName;
  final String hintTextEntrance;
  final String hintTextPlaceFloor;
  final String hintTextPlaceApartment;
  final String hintTextReferencePoint;
  final String hintTextAddressName;
  final ValueChanged valueChangedPlaceName;
  final ValueChanged valueChangedEntrance;
  final ValueChanged valueChangedPlaceFloor;
  final ValueChanged valueChangedPlaceApartment;
  final ValueChanged valueChangedReferencePoint;
  final ValueChanged valueChangedAddressName;
  final VoidCallback addOptionalData;
  @override
  State<AddAddress> createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> {
  double get width => MediaQuery.of(context).size.width;
  double get height => MediaQuery.of(context).size.height;
  //ThemeTextStyles get theme => Theme.of(context).extension<ThemeTextStyles>()!;
  @override
  Widget build(BuildContext context) => SizedBox(
        height: height * 0.5,
        width: double.infinity,
        child: DecoratedBox(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
            color: Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                (height / 50).ph,
                Center(
                  child: SizedBox(
                    height: 7,
                    width: 60,
                    child: DecoratedBox(
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color:const Color(0xffE5E5E5)),
                    ),
                  ),
                ),
               const Text(
                  "Адрес доставки",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20,color: Colors.black),
                ),
                (height / 60).ph,
                GetAddressTextFiled(
                    textEditingController: widget.textEditingControllerPlaceName,
                    valueChanged: widget.valueChangedPlaceName,
                    hintText: widget.hintTextPlaceName,
                    width: double.infinity,
                    height: height / 16,
                    hintTextColor: const Color(0xff2B2A28)),
                (height / 60).ph,
                Row(
                  children: [
                    GetAddressTextFiled(
                        textEditingController: widget.textEditingControllerEntrance,
                        valueChanged: widget.valueChangedEntrance,
                        hintText: widget.hintTextEntrance,
                        width: width * 0.29,
                        height: height / 16,
                        hintTextColor: const Color(0xff858585)),
                    const Gap(16),
                    GetAddressTextFiled(
                        textEditingController: widget.textEditingControllerFloor,
                        valueChanged: widget.valueChangedPlaceFloor,
                        hintText: widget.hintTextPlaceFloor,
                        width: width * 0.29,
                        height: height / 16,
                        hintTextColor: const Color(0xff858585)),
                    const Gap(16),
                    GetAddressTextFiled(
                        textEditingController: widget.textEditingControllerApartment,
                        valueChanged: widget.valueChangedPlaceApartment,
                        hintText: widget.hintTextPlaceApartment,
                        width: width * 0.29,
                        height: height / 16,
                        hintTextColor: const Color(0xff858585)),
                  ],
                ),
                (height / 60).ph,
                GetAddressTextFiled(
                    textEditingController: widget.textEditingControllerReferencePoint,
                    valueChanged: widget.valueChangedReferencePoint,
                    hintText: widget.hintTextReferencePoint,
                    width: double.infinity,
                    height: height / 16,
                    hintTextColor: const Color(0xff858585)),
                (height / 60).ph,
                GetAddressTextFiled(
                    textEditingController: widget.textEditingControllerAddressName,
                    valueChanged: widget.valueChangedAddressName,
                    hintText: widget.hintTextAddressName,
                    width: double.infinity,
                    height: height / 16,
                    hintTextColor: const Color(0xff858585)),
                (height / 60).ph,
                FilledButton(
                  onPressed: widget.addOptionalData,
                  style: FilledButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    backgroundColor: const Color(0xff858585),
                    minimumSize: Size(
                      double.infinity,
                      height / 16,
                    ),
                    padding: const EdgeInsets.all(16),
                  ),
                  child: const Text(
                    "Подтвердить",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
