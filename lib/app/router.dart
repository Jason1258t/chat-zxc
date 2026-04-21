import 'dart:developer';

import 'package:chat_zxc/feature/auth/auth_controller.dart';
import 'package:chat_zxc/pages/auth/enter_name_screen.dart';
import 'package:chat_zxc/pages/auth/phone_screen.dart';
import 'package:chat_zxc/pages/auth/verify_phone_screen.dart';
import 'package:chat_zxc/pages/home/home_screen.dart';
import 'package:chat_zxc/pages/splash/splash_screen.dart';
import 'package:chat_zxc/pages/welcome/welcome_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'router.g.dart';

@riverpod
GoRouter appRouter(Ref ref) {
  final authStep = ref.watch(
      authControllerProvider.select((state) => state.step)
  );

  return GoRouter(
    initialLocation: '/',

    redirect: (context, state) {
      final path = state.uri.path;
      final isAuthPath = path.startsWith('/auth') || path == '/welcome';

      log('====== Redirect status =========');
      log("Current authStep: $authStep");
      log("Current path: $path, it is ${isAuthPath ? '' : 'not '}auth location");
      log('===============================');
      log('');

      if (authStep == AuthStep.pending) return null;

      if (authStep == AuthStep.unauthenticated) {
        if (isAuthPath) return null;
        return '/welcome';
      }

      if (authStep == AuthStep.needsProfile) {
        if (path == '/auth/enter-name') return null;
        return '/auth/enter-name';
      }

      if (authStep == AuthStep.authenticated) {
        if (isAuthPath || path == '/') return '/home';
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
