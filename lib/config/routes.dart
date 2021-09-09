import 'package:get/get.dart';
import 'package:store_house/controller/main_app_controller.dart';
import 'package:store_house/pages/register.dart';

final routes = <GetPage>[
  GetPage(name: Register.name, page: () => Register(), binding: MainAppBinding())
];