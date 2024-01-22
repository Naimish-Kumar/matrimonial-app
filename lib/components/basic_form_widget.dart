import 'package:active_matrimonial_flutter_app/components/common_input.dart';
import 'package:flutter/material.dart';

class BasicFormWidget extends StatelessWidget {
  final text;
  final hint;
  final controller;
  final min_line;
  final max_line;
  final keyboard_type;
  final validator;
  final style;

  BasicFormWidget(
      {Key? key,
      this.text,
      this.hint,
      this.controller,
      this.min_line,
      this.max_line,
      this.keyboard_type,
      this.validator,
      this.style})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        text != null
            ? Text(
                text,
                style: style,
              )
            : const SizedBox(),
        const SizedBox(
          height: 5,
        ),
        SizedBox(
          child: TextFormField(
            validator: validator,
            minLines: min_line,
            maxLines: max_line,
            keyboardType: keyboard_type,
            controller: controller,
            decoration: InputStyle.inputDecoration_text_field(hint: hint),
          ),
        ),
      ],
    );
  }
}

class EducationViewModel {
  final id;
  final present;
  final degree_hint;
  final institute_hint;
  final start_hint;
  final end_hint;
  final degree_controller;
  final institute_controller;
  final start_controller;
  final end_controller;
  final min_line;
  final max_line;
  final keyboard_type;
  final validator;
  final style;

  EducationViewModel(
      {this.degree_hint,
      this.id,
      this.present,
      this.institute_hint,
      this.start_hint,
      this.end_hint,
      this.degree_controller,
      this.institute_controller,
      this.start_controller,
      this.end_controller,
      this.min_line,
      this.max_line,
      this.keyboard_type,
      this.validator,
      this.style});
}

class CareerViewModel {
  final designation_text;
  final company_text;
  final start;
  final id;
  final present;
  final end;
  final designation_controller;
  final company_controller;
  final start_controller;
  final end_controller;

  CareerViewModel(
      {this.designation_text,
      this.id,
      this.present,
      this.company_text,
      this.start,
      this.end,
      this.designation_controller,
      this.company_controller,
      this.start_controller,
      this.end_controller});
}
