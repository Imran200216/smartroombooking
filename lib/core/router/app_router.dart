import 'package:go_router/go_router.dart';
import 'package:smartroombooking/features/auth/presentation/screens/auth_forget_password_screen.dart';
import 'package:smartroombooking/features/auth/presentation/screens/auth_login_screen.dart';
import 'package:smartroombooking/features/auth/presentation/screens/auth_sign_up_screen.dart';
import 'package:smartroombooking/features/bottom_nav/presentation/screens/bottom_nav.dart';
import 'package:smartroombooking/features/on_boarding/presentation/screens/on_boarding_screen.dart';
import 'package:smartroombooking/features/splash/presentation/screens/splash_screen.dart';
import 'package:smartroombooking/features/user_type/presentation/screens/user_type_screen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: "/splashScreen",
  routes: [
    /// splash screen
    GoRoute(
      path: '/splashScreen',
      name: "splashScreen",
      builder: (context, state) => const SplashScreen(),
    ),

    /// on boarding screen
    GoRoute(
      path: '/onBoardingScreen',
      name: "onBoardingScreen",
      builder: (context, state) => const OnBoardingScreen(),
    ),

    /// auth login screen
    GoRoute(
      path: '/authLoginScreen',
      name: "authLoginScreen",
      builder: (context, state) => const AuthLoginScreen(),
    ),

    /// auth login screen
    GoRoute(
      path: '/authSignUpScreen',
      name: "authSignUpScreen",
      builder: (context, state) => const AuthSignUpScreen(),
    ),

    /// auth forget password screen
    GoRoute(
      path: '/authForgetPasswordScreen',
      name: "authForgetPasswordScreen",
      builder: (context, state) => const AuthForgetPasswordScreen(),
    ),

    /// user type screen
    GoRoute(
      path: '/userTypeScreen',
      name: "userTypeScreen",
      builder: (context, state) => const UserTypeScreen(),
    ),

    /// bottom nav  screen
    GoRoute(
      path: '/bottomNav',
      name: "bottomNav",
      builder: (context, state) => const BottomNav(),
    ),
  ],
);
