import 'dart:convert';


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
// ignore: unused_import
import 'package:google_sign_in/google_sign_in.dart';
import 'package:github_sign_in/github_sign_in.dart';

import 'package:http/http.dart' as http;
import 'package:network_speed/secret_key.dart' as SecretKeys;

// class GoogleSignInProvider extends ChangeNotifier {
//   bool _isSigningIn;
//   final googleSignIn = GoogleSignIn();
//   GoogleSignInProvider() {
//     _isSigningIn = false;
//   }
//   bool get isSigningIn => _isSigningIn;

//   set isSigningIn(bool isSigningIn) {
//     _isSigningIn = isSigningIn;
//     notifyListeners();
//   }

//   Future login() async {
//     isSigningIn = true;

//     final user = await googleSignIn.signIn();
//     print("user : -----$user");
//     if (user == null) {
//       isSigningIn = false;
//       return;
//     } else {
//       final googleAuth = await user.authentication;
//       print("googleAuth : -----${googleAuth.toString()}");
//       final credential = GoogleAuthProvider.credential(
//         accessToken: googleAuth.accessToken,
//         idToken: googleAuth.accessToken,
//       );

//       FirebaseAuth.instance.signInWithCredential(credential).then((credential) {
//         print(credential);
//         isSigningIn = false;
//       }).catchError(
//         (error) {
//           print(error);
//           isSigningIn = false;
//           logOut();
//         },
//       );
//     }
//   }

//   void logOut() async {
//     await googleSignIn.disconnect();
//     FirebaseAuth.instance.signOut();
//   }
// }

class GitHubSignInProvider extends ChangeNotifier {
  bool _isSigningIn;

  final gitHubSignIn = GitHubSignIn(
      clientId: SecretKeys.GITHUB_CLIENT_ID,
      clientSecret: SecretKeys.GITHUB_CLIENT_SECRET,
      redirectUrl: "https://network_speed.example.com/__/auth/handler");
  bool get isSigningIn => _isSigningIn;

  set isSigningIn(bool isSigningIn) {
    _isSigningIn = isSigningIn;
    notifyListeners();
  }

  GitHubSignInProvider() {
    _isSigningIn = false;
  }

  Future login(BuildContext context) async {
    logOut();

    isSigningIn = true;

    final result = await gitHubSignIn.signIn(context);

    final credential = GithubAuthProvider.credential(result.token);

    // final response = await http.post(
    //   "https://github.com/login/oauth/access_token",
    //   headers: {
    //     "Content-Type": "application/json",
    //     "Accept": "application/json"
    //   },
    //   body: jsonEncode(GitHubLoginRequest(
    //     clientId: SecretKeys.GITHUB_CLIENT_ID,
    //     clientSecret: SecretKeys.GITHUB_CLIENT_SECRET,
    //     code: code,
    //   )),
    // );

    // GitHubLoginResponse loginResponse =
    //     GitHubLoginResponse.fromJson(json.decode(response.body));

    // final credential = GithubAuthProvider.credential(loginResponse.accessToken);

    await FirebaseAuth.instance.signInWithCredential(credential);

    isSigningIn = false;
  }

  void logOut() {
    FirebaseAuth.instance.signOut();
  }
}

class GitHubLoginResponse {
  String accessToken;
  String tokenType;
  String scope;
  GitHubLoginResponse({this.accessToken, this.tokenType, this.scope});
  factory GitHubLoginResponse.fromJson(Map<String, dynamic> json) =>
      GitHubLoginResponse(
        accessToken: json["access_token"],
        tokenType: json["token_type"],
        scope: json["scope"],
      );
}

class GitHubLoginRequest {
  String clientId;
  String clientSecret;
  String code;
  GitHubLoginRequest({this.clientId, this.clientSecret, this.code});
  dynamic toJson() => {
        "client_id": clientId,
        "client_secret": clientSecret,
        "code": code,
      };
}
