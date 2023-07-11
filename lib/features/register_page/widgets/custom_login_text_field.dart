import 'package:flutter/material.dart';

class CustomLoginTextField extends StatelessWidget {
  final String stringInTextField;
  final bool obscureText;
  final TextInputType textInputType;
  final double? height;
  final double? width;
  final Icon iconSuffix;
  final int? multiLine;
  final TextEditingController typeController;


  const CustomLoginTextField({
    Key? key,
    this.width,
    this.multiLine,
    required this.stringInTextField,
    required this.textInputType,
    required this.obscureText,
    required this.typeController,
    this.height, required this.iconSuffix,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: 10, horizontal: width != null ? 0 : 30),
      child: Container(
        height: height ?? 53,
        width: width,
        decoration:
        BoxDecoration(
          border: Border.all(color: const Color(0xff707070)),
          color: const Color(0xffffffff),
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.all(6),

        child: TextFormField(
            controller: typeController,
            textAlign: TextAlign.right,
            validator: (value) {
              if (value!.isEmpty) {
                return "please enter your $stringInTextField";
              }
              return null;
            },
            obscureText: obscureText,
            keyboardType: textInputType,
            maxLines: multiLine ?? 1,
            decoration: InputDecoration(
              suffixIcon: iconSuffix,
              label: Text(
                stringInTextField,
                style: const TextStyle(
                    color: Color(0xff9d9d9e),
                    fontWeight: FontWeight.w600,
                    fontSize: 12),
              ),
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              focusedErrorBorder: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                  vertical: 6, horizontal: 10), // space of text
              border: OutlineInputBorder(
                borderSide: const BorderSide(width: 0.5),
                borderRadius: BorderRadius.circular(16),
              ),
            )),
      ),
    );
  }
}
