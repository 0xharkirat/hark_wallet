import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hark_wallet/src/core/routing/app_router.dart';


// ignore: depend_on_referenced_packages
import 'package:flutter_web_plugins/url_strategy.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  usePathUrlStrategy();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final goRouter = ref.watch(appRouter);
    return MaterialApp.router(
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.black,
        scaffoldBackgroundColor: Colors.black,
        canvasColor: Colors.black,
        textTheme: const TextTheme(
          displayLarge:
          TextStyle(
            fontFamily: 'VT323',
            color: Colors.white,
            
          ),
          displayMedium: TextStyle(
            fontFamily: 'VT323',
            color: Colors.white,
          ),
          displaySmall: TextStyle(
            fontFamily: 'VT323',
            color: Colors.white,
          ),
          headlineLarge: TextStyle(
            fontFamily: 'VT323',
            color: Colors.white,
          ),
          headlineMedium: TextStyle(
            fontFamily: 'VT323',
            color: Colors.white,
          ),
          headlineSmall: TextStyle(
            fontFamily: 'VT323',
            color: Colors.white,
          ),
          titleLarge: TextStyle(
            fontFamily: 'VT323',
            color: Colors.white,
          ),
          titleMedium: TextStyle(
            fontFamily: 'VT323',
            color: Colors.white,
          ),
          titleSmall: TextStyle(
            fontFamily: 'VT323',
            color: Colors.white,
          ),
          bodyLarge: TextStyle(
            fontFamily: 'VT323',
            color: Colors.white,
          ),
          bodyMedium: TextStyle(
            fontFamily: 'VT323',
            color: Colors.white,
          ),
          bodySmall: TextStyle(
            fontFamily: 'VT323',
            color: Colors.white,
          ),
          labelLarge: TextStyle(
            fontFamily: 'VT323',
            color: Colors.white,
          ),
          labelMedium: TextStyle(
            fontFamily: 'VT323',
            color: Colors.white,
          ),
          labelSmall: TextStyle(
            fontFamily: 'VT323',
            color: Colors.white,
          ),

        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          iconTheme: IconThemeData(color: Colors.white),
          titleTextStyle:  TextStyle(
            fontFamily: 'VT323',
            color: Colors.white,
            fontSize: 24,
          ),
        ),
        buttonTheme: const ButtonThemeData(
          buttonColor: Colors.white, // Set button background to white
          textTheme: ButtonTextTheme.primary, // Set button text to black
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white, // Background color
            foregroundColor: Colors.black, // Text color
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            // Background color
            foregroundColor: Colors.white, // Text color
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      routerConfig: goRouter,
    );
  }
}
