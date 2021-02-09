import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:network_speed/Page/widget/after_signin_page.dart';
// ignore: unused_import
import 'package:network_speed/Page/widget/background_button_pointer.dart';
import 'package:network_speed/Page/widget/before_signin_page.dart';
import 'package:network_speed/provider/auth_provider.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider<GitHubSignInProvider>(
        create: (context) => GitHubSignInProvider(),
        child: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            final provider = Provider.of<GitHubSignInProvider>(context);
            if (provider.isSigningIn) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasData) {
              return AfterSignIn();
            } else {
              return BeforeSignIn();
            }
          },
        ),
      ),
    );
  }
}
