import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:news/core/dependency_injection/injection_container.dart' as di;
import 'package:news/core/theme/app_theme.dart';
import 'package:news/presentation/screens/splash_screen.dart';
import 'package:news/presentation/screens/home_screen.dart';
import 'package:news/presentation/state/home_state.dart';
import 'package:news/presentation/state/category_state.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Set status bar style
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    ),
  );
  
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => di.sl<HomeState>()),
        ChangeNotifierProvider(create: (_) => di.sl<CategoryState>()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'ताज़ा ख़बर',
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.light,
        initialRoute: '/',
        routes: {
          '/': (context) => const SplashScreen(),
          '/home': (context) => const HomeScreen(),
        },
      ),
    );
  }
}