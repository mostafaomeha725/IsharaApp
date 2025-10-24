import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:isharaapp/core/routes/app_routes.dart';
import 'package:isharaapp/core/theme/dark_theme.dart';
import 'package:isharaapp/core/theme/light_theme.dart';
import 'package:go_router/go_router.dart';
import 'package:isharaapp/core/theme/theme_controller.dart';
import 'package:isharaapp/core/widgets/custom_text.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const IsharaaApp());
}

class IsharaaApp extends StatefulWidget {
  const IsharaaApp({super.key});

  @override
  State<IsharaaApp> createState() => _IsharaaAppState();
}

class _IsharaaAppState extends State<IsharaaApp> {
  ThemeMode _themeMode = ThemeMode.dark;

  void _toggleTheme() {
    setState(() {
      _themeMode =
          _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  late final GoRouter _router = createRouter(
    onToggleTheme: _toggleTheme,
    themeMode: _themeMode,
  );

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(420, 910),
      minTextAdapt: true,
      splitScreenMode: true,
      useInheritedMediaQuery: true,
      builder: (context, child) {
        return ThemeController(
          themeMode: _themeMode,
          toggleTheme: _toggleTheme,
          child: MaterialApp.router(
            title: 'Isharaa',
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: _themeMode,
            routerConfig: _router,
          ),
        );
      },
    );
  }
}

class SplashScreen extends StatelessWidget {
  final VoidCallback onToggleTheme;
  final ThemeMode themeMode;

  const SplashScreen({
    super.key,
    required this.onToggleTheme,
    required this.themeMode,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDark = themeMode == ThemeMode.dark;

    return Scaffold(
      appBar: AppBar(
        title: const AppText('Isharaa App'),
        actions: [
          IconButton(
            icon: Icon(
              isDark ? Icons.wb_sunny_rounded : Icons.nightlight_round,
            ),
            tooltip: isDark ? 'Switch to Light Mode' : 'Switch to Dark Mode',
            onPressed: onToggleTheme,
          ),
        ],
      ),
      body: Center(
        child: AppText(
          'Hello Isharaa!',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
    );
  }
}
