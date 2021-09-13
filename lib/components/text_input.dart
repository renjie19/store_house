import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:store_house/util/string_formatter.dart';

class TextInput extends StatelessWidget {
  final String name;
  final String label;
  final bool required;
  final bool numberKeyboard;

  TextInput(
      {required this.name,
      required this.label,
      this.required = true,
      this.numberKeyboard = false});

  @override
  Widget build(BuildContext context) {
    return FormBuilderField(
      name: name,
      enabled: true,
      validator: FormBuilderValidators.compose(_generateValidations(context)),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      valueTransformer: numberKeyboard ? toNumberFormat : toSnakeCase,
      builder: (FormFieldState<dynamic> field) {
        return TextFormField(
          initialValue: field.value,
          onChanged: (value) {
            field.didChange(value);
          },
          decoration:
              InputDecoration(labelText: label, errorText: field.errorText),
          validator:
              FormBuilderValidators.compose(_generateValidations(context)),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          keyboardType:
              numberKeyboard ? TextInputType.number : TextInputType.text,
          inputFormatters: numberKeyboard
              ? [FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}'))]
              : [],
        );
      },
    );
  }

  List<String? Function(String?)> _generateValidations(BuildContext context) {
    var validators = <String? Function(String?)>[];
    if (required) {
      validators.add(FormBuilderValidators.required(context));
    }
    if (numberKeyboard) {
      validators.add(FormBuilderValidators.numeric(context));
    }
    return validators;
  }
}
