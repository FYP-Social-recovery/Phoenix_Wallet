import 'package:get/get.dart';
import 'package:pheonix_wallet_app/src/controllers/auth_controller.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthController>(() => AuthController());
  }
}
