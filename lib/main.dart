import 'package:flutter/material.dart';
import 'package:whisup/const/colors.dart';
import 'package:whisup/router/router.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: myRouter,
      theme: ThemeData(
        useMaterial3: false,
        scaffoldBackgroundColor: AppColors.white,
        bottomSheetTheme: const BottomSheetThemeData(
          backgroundColor: AppColors.white,
        ),
        primaryColor: AppColors.blueBackground,
      ),
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        return GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Scaffold(body: child),
        );
      },
    );
  }
}
