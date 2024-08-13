import "package:flutter/material.dart";
class LineTextField extends StatefulWidget {
  const LineTextField({
    super.key,
    required this.controller, required this.onChanged, required this.hintText,
  });
  final TextEditingController controller;
 final ValueChanged onChanged;
 final String hintText;
  @override
  State<LineTextField> createState() => _LineTextFieldState();
}

class _LineTextFieldState extends State<LineTextField> {
  double get height => MediaQuery.of(context).size.height;
  double get width => MediaQuery.of(context).size.width;
  @override
  Widget build(BuildContext context) => Column(
      children: [
        Container(
          width: width * 0.85/ 2,
          padding: EdgeInsets.only(left: width / 7, bottom: height / 188),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color:Color(0xffF5F5F5), ),
          child: Center(
            child: TextField(
              onChanged:widget.onChanged,
              controller: widget.controller,
              onTapOutside: (_) => FocusScope.of(context).unfocus(),
              style: TextStyle(
                color: Colors.black.withOpacity(0.8),
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: widget.hintText,
                hintStyle: TextStyle(
                  color:Colors.black.withOpacity(0.8),
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ),
      ],
    );
}
