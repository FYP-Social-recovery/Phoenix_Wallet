import 'package:get/get.dart';

class AuthController extends GetxController {
  var splashScreenLoading = true.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    await initApp();
  }

  Future<void> initApp() async {
    await Future.delayed(const Duration(seconds: 5));

    splashScreenLoading.value = false;
  }
}
