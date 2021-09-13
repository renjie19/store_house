import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:store_house/controller/main_app_controller.dart';
import 'package:store_house/util/notification_util.dart';
import 'package:store_house/util/string_formatter.dart';

class Register extends StatelessWidget {
  static final String name = '/REGISTER';
  final _formKey = GlobalKey<FormBuilderState>();
  final MainAppController _mainAppController = Get.find();

  final List<String> _avatarLinks = [
    'avatar-beard-man',
    'avatar-girl',
    'male-avatar',
    'female-avatar',
    'salad-cat'
  ];

  Future<void> _register(BuildContext context) async {
    try {
      if (_formKey.currentState!.saveAndValidate()) {
        Loader.show(context);
        final data = _formKey.currentState!.value;
        await _mainAppController.register(data['email'], data['password'],
            data['displayName'], data['photoUrl']);
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
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Obx(() {
                  return Center(
                    child: Lottie.asset(
                      'assets/${_mainAppController.selectedAvatar}.json',
                      height: 180,
                      width: 180,
                      fit: BoxFit.fill,
                    ),
                  );
                }),
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
                FormBuilderDropdown(
                  name: 'photoUrl',
                  onChanged: (value) {
                    _mainAppController.selectedAvatar = value.toString();
                  },
                  items: List.generate(_avatarLinks.length, (index) {
                    var item = _avatarLinks[index];
                    return DropdownMenuItem(
                      value: item,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(toSnakeCase(item.replaceAll('-', ' '))),
                          Center(
                            child: CircleAvatar(
                              child: Lottie.asset(
                                'assets/$item.json',
                                height: 30,
                                width: 30,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 16),
                  child: MaterialButton(
                    padding: EdgeInsets.all(16),
                    color: Theme.of(context).primaryColor,
                    onPressed: () => _register(context),
                    child: Text(
                      'REGISTER',
                      style: TextStyle(
                          color: Theme.of(context).accentColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
