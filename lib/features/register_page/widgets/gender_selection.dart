
import 'package:flutter/material.dart';
import 'package:finalprojectfresh/features/register_page/widgets/styles.dart';

import '../../../shared/colors.dart';
class TypeSelection extends StatefulWidget {
  const TypeSelection({super.key});

  @override
  State<TypeSelection> createState() => _TypeSelectionState();
}

class _TypeSelectionState extends State<TypeSelection> {
  String? gender;

  @override
  Widget build(BuildContext context) {
    // late AppLocalizations locale;
    // locale = AppLocalizations.of(context)!;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Row(
          children: [
            Transform.translate(
              offset: const Offset(-7, 0),
              child: Radio(
                  activeColor: Colors.white,
                  value: 'doctor',
                  groupValue: gender,
                  onChanged: (value) {
                    setState(() {
                      gender = value as String;
                    });
                  }),
            ),
            Text(
            "Doctor",
              style: Styles.textStyle18.copyWith(
                fontSize: 12,
                color: Colors.white,
              ),
            ),
          ],
        ),
        // const SizedBox(
        //   width: 50,
        // ),
        Row(
          children: [
            Transform.translate(
              offset: const Offset(-7, 0),
              child: Radio(
                  activeColor: Colors.white,
                  value: 'student',
                  groupValue: gender,
                  onChanged: (value) {
                    setState(() {
                      gender = value as String;
                    });
                  }),
            ),
            Text(
            "Student",
              style: Styles.textStyle18.copyWith(
                fontSize: 12,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
