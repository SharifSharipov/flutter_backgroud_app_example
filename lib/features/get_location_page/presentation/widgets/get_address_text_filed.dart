import "package:flutter/material.dart";
class GetAddressTextFiled extends StatelessWidget {
  const GetAddressTextFiled({super.key, required this.textEditingController, required this.valueChanged, required this.hintText, required this.width, required this.height, required this.hintTextColor});
  final TextEditingController textEditingController;
  final ValueChanged valueChanged;
  final String hintText;
  final double width;
  final double height;
  final Color hintTextColor;
  @override
  Widget build(BuildContext context) {
   // final themeTextStyles = Theme.of(context).extension<ThemeTextStyles>();
    return SizedBox(
      width: width,
      height: height,
      child: DecoratedBox(
        decoration: BoxDecoration(color:const Color(0xffF5F5F5), borderRadius: BorderRadius.circular(8)),
        child: Padding(
            padding: const EdgeInsets.all(3),
            child: TextField(
              onChanged:valueChanged,
              controller: textEditingController,
              style:const TextStyle(fontSize: 15,fontWeight: FontWeight.w400,color: Colors.black),
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: TextStyle(fontSize: 15,color: hintTextColor,fontWeight: FontWeight.w400),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
                disabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
                border: const OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
              ),
            )),
      ),
    );
  }
}
