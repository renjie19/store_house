import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:fluttericon/typicons_icons.dart';
import 'package:get/get.dart';
import 'package:store_house/controller/main_app_controller.dart';
import 'package:store_house/pages/register.dart';
import 'package:store_house/util/notification_util.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormBuilderState>();
  final MainAppController _mainAppController = Get.find();
  bool _visible = false;

  final inputDecoration = InputDecoration(
    labelStyle: TextStyle(color: Colors.white),
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.white),
    ),
  );

  _login(BuildContext context) async {
    try {
      if (_formKey.currentState!.saveAndValidate()) {
        Loader.show(context);
        var data = _formKey.currentState!.value;
        print(data);
        await _mainAppController.login(data['email'], data['password']);
      }
    } on String catch (e) {
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
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  'STORE\n        HOUSE',
                  style: TextStyle(
                      fontSize: 64,
                      fontWeight: FontWeight.w900,
                      color: Theme.of(context).primaryColor),
                ),
              ),
              SizedBox(height: 20),
              Card(
                elevation: 0,
                color: Theme.of(context).primaryColor,
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      FormBuilderTextField(
                        style: TextStyle(color: Colors.white),
                        name: 'email',
                        decoration:
                            inputDecoration.copyWith(labelText: 'Email'),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(context),
                          FormBuilderValidators.email(context)
                        ]),
                      ),
                      FormBuilderTextField(
                          style: TextStyle(color: Colors.white),
                          name: 'password',
                          obscureText: !_visible,
                          keyboardType: TextInputType.visiblePassword,
                          decoration: inputDecoration.copyWith(
                            labelText: 'Password',
                            suffixIcon: !_visible
                                ? IconButton(
                                    onPressed: () =>
                                        setState(() => _visible = !_visible),
                                    icon: Icon(
                                      FontAwesome.eye_off,
                                      color: Theme.of(context).accentColor,
                                    ),
                                  )
                                : IconButton(
                                    onPressed: () =>
                                        setState(() => _visible = !_visible),
                                    icon: Icon(
                                      FontAwesome.eye,
                                      color: Theme.of(context).accentColor,
                                    ),
                                  ),
                          ),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(context),
                          ]))
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              MaterialButton(
                minWidth: 200,
                padding: EdgeInsets.all(8),
                color: Theme.of(context).primaryColor,
                elevation: 0,
                onPressed: () => _login(context),
                child: Text(
                  'LOGIN',
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: Colors.white),
                ),
              ),
              MaterialButton(
                minWidth: 200,
                onPressed: () => Get.toNamed(Register.name),
                child: Text(
                  'Register',
                  style: TextStyle(
                      fontSize: 18, color: Theme.of(context).primaryColor),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
