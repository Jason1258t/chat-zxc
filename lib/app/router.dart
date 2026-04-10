import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:chat_zxc/pages/welcome/welcome_screen.dart';
import 'package:chat_zxc/pages/auth/sign_in_screen.dart';
import 'package:chat_zxc/pages/auth/sign_up_screen.dart';
import 'package:chat_zxc/pages/auth/verify_email_screen.dart';
import 'package:chat_zxc/pages/auth/enter_name_screen.dart';

/// Временная заглушка состояния авторизации.
/// false = пользователь не авторизован (кидает на /welcome).
/// Переключи на true, чтобы протестировать защищенные роуты.
final ValueNotifier<bool> mockAuthState = ValueNotifier<bool>(false);

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    // Подписываем роутер на изменения состояния авторизации
    refreshListenable: mockAuthState,

    // Глобальный перехватчик (Auth Guard)
    redirect: (BuildContext context, GoRouterState state) {
      final bool isAuthenticated = mockAuthState.value;
      final String currentPath = state.uri.path;

      // Список публичных маршрутов (процесс авторизации)
      final bool isAuthRoute = currentPath.startsWith('/welcome') ||
          currentPath.startsWith('/auth');

      // Разрешаем доступ к UI-киту всегда (для удобства разработки)
      if (currentPath == '/kit') return null;

      // Если не авторизован и пытается зайти не на страницу авторизации -> на welcome
      if (!isAuthenticated && !isAuthRoute) {
        return '/welcome';
      }

      // Если авторизован, но находится на странице авторизации -> на главную
      if (isAuthenticated && isAuthRoute) {
        return '/';
      }

      return null; // Никаких изменений маршрута не требуется
    },

    routes: <RouteBase>[
      // ─── ЗАЩИЩЕННАЯ ЗОНА ──────────────────────────────────────────
      GoRoute(
        path: '/',
        builder: (context, state) => const Scaffold(
          body: Center(child: Text('Home Screen (Protected)')),
        ),
      ),

      // ─── ЗОНА АВТОРИЗАЦИИ ─────────────────────────────────────────
      GoRoute(
        path: '/welcome',
        builder: (context, state) => const WelcomeScreen(),
      ),
      GoRoute(
        path: '/auth/sign-in',
        builder: (context, state) => const SignInScreen(),
      ),
      GoRoute(
        path: '/auth/sign-up',
        builder: (context, state) => const SignUpScreen(),
      ),
      GoRoute(
        path: '/auth/verify-email',
        builder: (context, state) => const VerifyEmailScreen(),
      ),
      GoRoute(
        path: '/auth/enter-name',
        builder: (context, state) => const EnterNameScreen(),
      ),

    ],
  );
}