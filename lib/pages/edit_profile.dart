import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:store_house/components/text_input.dart';
import 'package:store_house/config/avatar_file_names.dart';
import 'package:store_house/controller/edit_profile_controller.dart';
import 'package:store_house/util/notification_util.dart';
import 'package:store_house/util/string_formatter.dart';

class EditProfile extends StatelessWidget {
  static final String name = '/EDIT_PROFILE';
  final _formKey = GlobalKey<FormBuilderState>();
  final EditProfileController _editProfileController = Get.find();

  Future<void> _updateProfile(BuildContext context) async {
    try {
      Loader.show(context);
      if (_formKey.currentState!.saveAndValidate()) {
        var data = _formKey.currentState!.value;
        await _editProfileController.updateProfile(data);
        Get.back(result: data);
        showSuccessMessage('Some changes may apply after app restart.');
      }
    } catch (e) {
      showErrorMessage(e);
    } finally {
      Loader.hide();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FormBuilder(
        key: _formKey,
        initialValue: _editProfileController.getCurrentUser(),
        child: Container(
          margin: EdgeInsets.all(24),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            Obx(() {
              return Center(
                child: Lottie.asset(
                  _editProfileController.avatar.isEmpty
                      ? 'assets/avatar-beard-man.json'
                      : 'assets/${_editProfileController.avatar}.json',
                  width: 300,
                  height: 300,
                  fit: BoxFit.fill,
                ),
              );
            }),
            TextInput(name: 'displayName', label: 'Display Name'),
            // TextInput(
            //     name: 'phoneNumber',
            //     label: 'Phone Number',
            //     numberKeyboard: true, required: false),
            FormBuilderDropdown(
              decoration: InputDecoration(labelText: 'Avatar'),
              validator: FormBuilderValidators.compose(
                  [FormBuilderValidators.required(context)]),
              name: 'photoUrl',
              onChanged: (value) {
                _editProfileController.avatar = value.toString();
              },
              items: List.generate(AVATAR_FILE_NAMES.length, (index) {
                var item = AVATAR_FILE_NAMES[index];
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
            Spacer(),
            ElevatedButton(
              onPressed: () => _updateProfile(context),
              child: Text('UPDATE',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  )),
            )
          ]),
        ),
      ),
    );
  }
}
