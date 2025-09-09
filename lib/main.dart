import 'package:firebase_core/firebase_core.dart';
import 'package:flash_food/Core/Routes/routes.dart';
import 'package:flash_food/Core/Routes/routes_name.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform, // Use generated options
  );
  runApp(App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: RoutesName.onBoarding,
      onGenerateRoute: Routes.onGenerateRoute,
      theme: ThemeData(canvasColor: Colors.white),
    );
  }
}




