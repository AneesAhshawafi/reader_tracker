import 'package:flutter/material.dart';
import 'package:reader_tracker/app_router.dart';

void main() {
  runApp(MainApp(appRouter: AppRouter()));
}

class MainApp extends StatelessWidget {
  final AppRouter appRouter;
  const MainApp({super.key, required this.appRouter});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
        useMaterial3: true,
      ),
      onGenerateRoute: appRouter.generateRoute,
      // home: MainScreen(),
    );
  }
}
