import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class Register extends StatelessWidget {
  static final String name = '/REGISTER';
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: FormBuilder(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FormBuilderTextField(
                  name: 'email',
                  decoration: InputDecoration(labelText: 'Email'),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(context),
                    FormBuilderValidators.email(context)
                  ]),
                ),
                FormBuilderTextField(
                  name: 'password',
                  decoration: InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(context),
                    FormBuilderValidators.equal(context,
                        _formKey.currentState?.fields['confirmPassword']?.value)
                  ]),
                ),
                FormBuilderTextField(
                  name: 'confirmPassword',
                  decoration: InputDecoration(labelText: 'Confirm Password'),
                  obscureText: true,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(context),
                    FormBuilderValidators.equal(context,
                        _formKey.currentState?.fields['password']?.value)
                  ]),
                ),
                MaterialButton(
                  onPressed: () {},
                  child: Text('REGISTER'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
