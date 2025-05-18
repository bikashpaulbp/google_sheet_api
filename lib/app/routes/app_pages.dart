import 'package:get/get.dart';

import '../modules/backup/bindings/backup_binding.dart';
import '../modules/backup/views/backup_view.dart';
import '../modules/email_add/bindings/email_add_binding.dart';
import '../modules/email_add/views/email_add_view.dart';
import '../modules/face_auth/bindings/face_auth_binding.dart';
import '../modules/face_auth/views/face_auth_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/splash_screen/bindings/splash_screen_binding.dart';
import '../modules/splash_screen/views/splash_screen_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH_SCREEN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH_SCREEN,
      page: () => const SplashScreenView(),
      binding: SplashScreenBinding(),
    ),
    GetPage(
      name: _Paths.FACE_AUTH,
      page: () => FaceAuthView(),
      binding: FaceAuthBinding(),
    ),
    // GetPage(
    //   name: _Paths.BACKUP,
    //   page: () => const BackupView(),
    //   binding: BackupBinding(),
    // ),
    GetPage(
      name: _Paths.EMAIL_ADD,
      page: () => const EmailAddView(),
      binding: EmailAddBinding(),
    ),
  ];
}
