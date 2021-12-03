import 'package:flutter/material.dart';
import 'package:sportvisio/app/styles.dart';
import 'package:sportvisio/core/helpers/ui_helpers.dart';

class UpdatedFields extends StatelessWidget {
  final String title;
  final String? value;

  const UpdatedFields({Key? key, required this.title, this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            textAlign: TextAlign.left,
            style: bodyStyle,
          ),
        ),
        UIHelper.horizontalSpaceSm,
        Expanded(
          child: Text(
            value ?? "",
            textAlign: TextAlign.left,
            style: bodyStyle,
          ),
        ),
      ],
    );
  }
}
