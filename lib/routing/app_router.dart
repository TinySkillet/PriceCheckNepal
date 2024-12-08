// lib/routes/app_router.dart
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:price_check_np/pages/email_sent_success_page.dart';
import 'package:price_check_np/pages/forgot_password.dart';
import 'package:price_check_np/pages/home_content.dart';
import 'package:price_check_np/pages/home_page.dart';
import 'package:price_check_np/pages/landing_page.dart';
import 'package:price_check_np/pages/laptop_specs_page.dart';
import 'package:price_check_np/pages/login_page.dart';
import 'package:price_check_np/pages/profile_page.dart';
import 'package:price_check_np/pages/register_page.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    redirect: (BuildContext context, GoRouterState state) {
      // Check if user is logged in
      final bool loggedIn = FirebaseAuth.instance.currentUser != null;

      // Define paths that don't require authentication
      final bool isLoggingIn = state.matchedLocation == '/login';
      final bool isSigningUp = state.matchedLocation == '/signup';
      final bool isForgotPassword = state.matchedLocation == '/forgotpassword';
      final bool isEmailSent = state.matchedLocation == '/emailsent';

      // Allow unauthenticated access to specific routes
      final bool isPublicRoute =
          isLoggingIn || isSigningUp || isForgotPassword || isEmailSent;

      // Redirect logic
      if (!loggedIn && !isPublicRoute) {
        // If not logged in and not on a public route, redirect to login
        return '/';
      }

      if (loggedIn && isPublicRoute) {
        // If logged in and trying to access login/signup pages, redirect to home
        return '/home';
      }

      // Allow navigation
      return null;
    },
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const LandingPage(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: '/signup',
        builder: (context, state) => const RegisterPage(),
      ),
      GoRoute(
        path: '/forgotpassword',
        builder: (context, state) => ForgotPaswordPage(),
      ),
      GoRoute(
        path: "/emailsent",
        builder: (context, state) => const PasswordResetEmailSentSuccessPage(),
      ),

      StatefulShellRoute.indexedStack(
          builder: (context, state, shell) => HomePage(shell: shell),
          branches: [
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: "/home",
                  builder: (context, state) => HomeContent(),
                ),
                GoRoute(
                  path: "/laptop-specs",
                  builder: (context, state) {
                    final laptop = state.extra as Map<String, dynamic>;
                    return LaptopSpecsPage(laptop: laptop);
                  },
                ),
                GoRoute(
                  path: "/search",
                  builder: (context, state) => HomeContent(),
                ),
              ],
            ),
            StatefulShellBranch(routes: [
              GoRoute(
                path: "/profile",
                builder: (context, state) => const ProfilePage(),
              )
            ])
          ]),
      // Home Route with Nested Routes
    ],
  );
}