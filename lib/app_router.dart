import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:personal_finances/screens/dashboard_screen.dart';
import 'package:personal_finances/screens/login_screen.dart';
import 'package:personal_finances/screens/profile_screen.dart';
import 'package:personal_finances/screens/spending_screen.dart';
import 'package:personal_finances/screens/wallet_screen.dart';
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
              currentIndex: _getCurrentIndex(state.uri.toString()),
              onTabSelected: (index) {
                switch (index) {
                  case 0:
                    context.go('/dashboard');
                    break;

                  case 1:
                    context.go('/spending');
                    break;

                  case 2:
                    context.go('/wallet');
                    break;

                  case 3:
                    context.go('/profile');
                    break;

                  default:
                }
              },
            ),
          );
        },
        routes: [
          GoRoute(path: '/dashboard', builder: (context, state) => DashboardScreen()),
          GoRoute(path: '/spending', builder: (context, state) => SpendingScreen()),
          GoRoute(path: '/wallet', builder: (context, state) => WalletScreen()),
          GoRoute(path: '/profile', builder: (context, state) => ProfileScreen()),
        ]
      )
    ]
  );

  static int _getCurrentIndex(String? location) {
    switch (location) {
      case '/dashboard':
        return 0;

      case '/spending':
        return 1;

      case '/wallet':
        return 2;

      case '/profile':
        return 3;

      default:
        return 0;
    }
  }
}
