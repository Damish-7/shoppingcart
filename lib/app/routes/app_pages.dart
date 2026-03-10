// lib/app/routes/app_pages.dart
import 'package:get/get.dart';
import '../controllers/product_controller.dart';
import '../modules/auth/login_page.dart';
import '../modules/auth/register_page.dart';
import '../modules/home/home_page.dart';
import 'app_routes.dart';

class AppPages {
  static const initial = Routes.login;

  static final routes = <GetPage>[
    GetPage(
      name: Routes.login,
      page: () => const LoginPage(),
    ),
    GetPage(
      name: Routes.register,
      page: () => const RegisterPage(),
    ),
    GetPage(
      name: Routes.home,
      page: () => const HomePage(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => ProductController());
      }),
    ),
  ];
}