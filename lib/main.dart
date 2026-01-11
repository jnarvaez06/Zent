import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personal_finances/app_router.dart';
import 'package:personal_finances/app_theme.dart';
import 'package:personal_finances/blocs/auth/auth_bloc.dart';
import 'package:personal_finances/blocs/income_expense/income_expense_bloc.dart';
import 'package:personal_finances/blocs/income_expense/income_expense_event.dart';
import 'package:personal_finances/firebase_options.dart';
import 'package:personal_finances/repositories/auth_repository.dart';
import 'package:personal_finances/repositories/income_expense_repository.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = MediaQuery.of(context).platformBrightness == Brightness.dark;

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthRepository>(
          create: (context) => AuthRepository()
        ),
        RepositoryProvider<IncomeExpenseRepository>(
          create: (context) => IncomeExpenseRepository()
        )
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
            create: (context) => AuthBloc(
              authRepository: RepositoryProvider.of<AuthRepository>(context)
            )
          ),
          BlocProvider<IncomeExpenseBloc>(
            create: (context) => IncomeExpenseBloc(
              RepositoryProvider.of<IncomeExpenseRepository>(context)              
            )..add(LoadTransactions())
          ),
        ],
        child: Builder(
          builder: (context) {
            return MaterialApp.router(
              title: 'Flutter Demo',
              theme: AppTheme.greenFinanceTheme,
              darkTheme: AppTheme.greenFinanceDarkTheme,
              themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
              debugShowCheckedModeBanner: false,
              routerConfig: AppRouter.router,
            );
          },
        ),
      ),
    );
  }
}
