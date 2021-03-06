import 'package:get/get.dart';
import 'package:store_house/controller/create_item_controller.dart';
import 'package:store_house/controller/edit_profile_controller.dart';
import 'package:store_house/controller/item_details_controller.dart';
import 'package:store_house/controller/item_management_controller.dart';
import 'package:store_house/controller/main_app_controller.dart';
import 'package:store_house/pages/create_item.dart';
import 'package:store_house/pages/edit_item.dart';
import 'package:store_house/pages/edit_profile.dart';
import 'package:store_house/pages/item_details.dart';
import 'package:store_house/pages/item_management.dart';
import 'package:store_house/pages/profile.dart';
import 'package:store_house/pages/register.dart';

final routes = <GetPage>[
  GetPage(name: Register.name, page: () => Register(), binding: MainAppBinding()),
  GetPage(name: ItemManagement.name, page: () => ItemManagement(), binding: ItemManagementBinding()),
  GetPage(name: ItemDetails.name, page: () => ItemDetails(), binding: ItemDetailsBinding()),
  GetPage(name: Profile.name, page: () => Profile()),
  GetPage(name: EditItem.name, page: () => EditItem(), binding: CreateItemBinding()),
  GetPage(name: CreateItem.name, page: () => CreateItem(), binding: CreateItemBinding()),
  GetPage(name: EditProfile.name, page: () => EditProfile(), binding: EditProfileBinding()),
];