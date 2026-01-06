import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:personal_finances/screens/login_screen.dart';
import 'package:personal_finances/widgets/nav_bar.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/login',
    routes: [
      GoRoute(path: '/login', builder: (context, state) => LoginScreen(),),
      ShellRoute(
        builder: (context, state, child) {
          final user = FirebaseAuth.instance.currentUser;

          if (user == null) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              context.go('/login');
            });
          }

          return Scaffold(
            body: child,
            bottomNavigationBar: NavBar(
              currentIndex: currentIndex,
              onTabSelected: (index) {
                switch (index) {
                  case 0:
                    context.go('/dashboard');
                    break;
                  default:
                }
              },
            ),
          );
        },
        routes: routes
      )
    ]
  );
}
