import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:network_speed/Page/login.dart';

final ScrollController controller = ScrollController();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(Myapp());
}

class Myapp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginPage(),
    );
  }
}
