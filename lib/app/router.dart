import 'package:chat_zxc/feature/auth/auth_controller.dart';
import 'package:chat_zxc/pages/auth/enter_name_screen.dart';
import 'package:chat_zxc/pages/auth/phone_screen.dart';
import 'package:chat_zxc/pages/auth/verify_phone_screen.dart';
import 'package:chat_zxc/pages/home/home_screen.dart';
import 'package:chat_zxc/pages/splash/splash_screen.dart';
import 'package:chat_zxc/pages/welcome/welcome_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'router.g.dart';

@riverpod
GoRouter appRouter(Ref ref) {
  final authStep = ref.watch(authControllerProvider);

  return GoRouter(
    initialLocation: '/',

    redirect: (context, state) {
      final path = state.uri.path;
      final isAuthPath = path.startsWith('/auth') || path == '/welcome';

      if (authStep == AuthStep.initial || authStep == AuthStep.loading) {
        return null;
      }

      if (authStep == AuthStep.unauthenticated) {
        return isAuthPath ? null : '/welcome';
      }

      if (authStep == AuthStep.needsProfile) {
        return path == '/auth/enter-name' ? null : '/auth/enter-name';
      }

      if (authStep == AuthStep.authenticated && isAuthPath) {
        return '/home';
      }

      return null;
    },

    routes: <RouteBase>[
      GoRoute(path: '/', builder: (context, state) => const SplashScreen()),

      // ─── ЗОНА АВТОРИЗАЦИИ ─────────────────────────────────────────
      GoRoute(
        path: '/welcome',
        builder: (context, state) => const WelcomeScreen(),
      ),
      GoRoute(
        path: '/auth/phone',
        builder: (context, state) => const PhoneScreen(),
      ),
      GoRoute(
        path: '/auth/verify-phone',
        builder: (context, state) => const VerifyPhoneScreen(),
      ),
      GoRoute(
        path: '/auth/enter-name',
        builder: (context, state) => const EnterNameScreen(),
      ),

      GoRoute(path: '/home', builder: (context, state) => const HomeScreen()),
    ],
  );
}
