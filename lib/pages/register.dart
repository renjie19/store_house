import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:get/get.dart';
import 'package:store_house/controller/main_app_controller.dart';
import 'package:store_house/util/notification_util.dart';

class Register extends StatelessWidget {
  static final String name = '/REGISTER';
  final _formKey = GlobalKey<FormBuilderState>();
  final MainAppController _mainAppController = Get.find();

  Future<void> _register(BuildContext context) async {
    try {
      if (_formKey.currentState!.saveAndValidate()) {
        Loader.show(context);
        final data = _formKey.currentState!.value;
        await _mainAppController.register(
            data['email'], data['password'], data['displayName']);
        Get.back();
      }
    } catch (errorMessage) {
      showErrorMessage(errorMessage);
    } finally {
      Loader.hide();
    }
  }

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
                  validator: FormBuilderValidators.compose(
                      [FormBuilderValidators.required(context)]),
                ),
                FormBuilderTextField(
                  name: 'displayName',
                  maxLength: 10,
                  decoration: InputDecoration(labelText: 'Display Name'),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: FormBuilderValidators.compose(
                      [FormBuilderValidators.required(context)]),
                ),
                MaterialButton(
                  onPressed: () => _register(context),
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
