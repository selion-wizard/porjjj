import 'package:taskmanager/feature/auth/page/login.dart';
import 'package:taskmanager/feature/auth/page/register.dart';
import 'package:taskmanager/feature/profile_screen/profile.dart';
import 'package:taskmanager/feature/page/home_page.dart';
import 'package:go_router/go_router.dart';
import 'package:taskmanager/feature/page/cart_page.dart';
import 'package:taskmanager/feature/page/orders_history_page.dart';

abstract class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: LoginPage.route,
    routes: [
      GoRoute(
        path: LoginPage.route,
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: RegisterPage.route,
        builder: (context, state) => const RegisterPage(),
      ),
      GoRoute(
        path: HomePage.route,
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: ProfilePage.route,
        builder: (context, state) => ProfilePage(),
      ),
      GoRoute(
        path: CartPage.route,
        builder: (context, state) => const CartPage(),
      ),
      GoRoute(
        path: OrdersHistoryPage.route,
        builder: (context, state) => const OrdersHistoryPage(),
      ),
    ],
  );
}