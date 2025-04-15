import 'package:flutter/material.dart';

import 'router/app_router.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      initialRoute: AppRouter.home,
      navigatorKey: AppRouter.routeKey,
      onGenerateRoute: AppRouter.generateRoute,
    );
  }
}
