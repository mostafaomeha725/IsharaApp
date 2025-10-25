import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:isharaapp/core/routes/app_routes.dart';
import 'package:isharaapp/core/theme/dark_theme.dart';
import 'package:isharaapp/core/theme/gender_controller.dart';
import 'package:isharaapp/core/theme/light_theme.dart';
import 'package:go_router/go_router.dart';
import 'package:isharaapp/core/theme/theme_controller.dart';
import 'package:isharaapp/features/home/presentation/screens/widgets/gender_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(GenderProvider(child: const IsharaaApp()));
}

class IsharaaApp extends StatefulWidget {
  const IsharaaApp({super.key});
  @override
  State<IsharaaApp> createState() => _IsharaaAppState();
}

class _IsharaaAppState extends State<IsharaaApp> {
  ThemeMode _themeMode = ThemeMode.dark;
  GenderTheme _genderTheme = GenderTheme.boy;
  void _toggleTheme() {
    setState(() {
      _themeMode =
          _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  void _changeGender(GenderTheme gender) {
    setState(() {
      _genderTheme = gender;
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
          child: GenderController(
            genderTheme: _genderTheme,
            onGenderChanged: _changeGender,
            child: MaterialApp.router(
              title: 'Isharaa',
              debugShowCheckedModeBanner: false,
              theme: lightTheme,
              darkTheme: darkTheme,
              themeMode: _themeMode,
              routerConfig: _router,
            ),
          ),
        );
      },
    );
  }
}
