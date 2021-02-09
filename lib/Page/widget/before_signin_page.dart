import 'dart:async';

import 'package:flutter/material.dart';
import 'package:network_speed/provider/auth_provider.dart';
import 'package:provider/provider.dart';
import 'package:uni_links/uni_links.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:network_speed/secret_key.dart' as SecretKeys;

class BeforeSignIn extends StatefulWidget {
  const BeforeSignIn({
    Key key,
  }) : super(key: key);

  @override
  _BeforeSignInState createState() => _BeforeSignInState();
}

class _BeforeSignInState extends State<BeforeSignIn> {
  // StreamSubscription _subs;

  // googleSignIn(BuildContext context) async {
  //   final provider = Provider.of<GoogleSignInProvider>(context, listen: false);
  //   await provider.login();
  // }

  // @override
  // void initState() {
  //   _initDeepLinkListener();
  //   super.initState();
  // }

  // @override
  // void dispose() {
  //   _disposeDeepLinkListener();
  //   super.dispose();
  // }

  // void _initDeepLinkListener() async {
  //   _subs = getLinksStream().listen((String link) {
  //     _checkDeepLink(link);
  //   }, cancelOnError: true);
  // }

  // void _checkDeepLink(String link) {
  //   if (link != null) {
  //     String code = link.substring(link.indexOf(RegExp('code=')) + 5);
  //     final provider =
  //         Provider.of<GitHubSignInProvider>(context, listen: false);
  //     provider.login(context).then((firebaseUser) {
  //       print(firebaseUser.email);
  //       print(firebaseUser.photoURL);
  //       print("LOGGED IN AS: " + firebaseUser.displayName);
  //     }).catchError((e) {
  //       print("LOGIN ERROR: " + e.toString());
  //     });
  //   }
  // }

  // void _disposeDeepLinkListener() {
  //   if (_subs != null) {
  //     _subs.cancel();
  //     _subs = null;
  //   }
  // }

  gitHubSignIn(BuildContext context) async {
    const String url = "https://github.com/login/oauth/authorize" +
        "?client_id=" +
        SecretKeys.GITHUB_CLIENT_ID +
        "&scope=public_repo%20read:user%20user:email";
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
      );
    } else {
      print("CANNOT LAUNCH THIS URL!");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // SIgnInMethod(
          //   methodname: "Google",
          //   onPressed: googleSignIn(context),
          //   iconLoacation: "assets/google.jpg",
          // ),
          SIgnInMethod(
            methodname: "GitHub",
            onPressed: () async {
              //   const String url = "https://github.com/login/oauth/authorize" +
              //       "?client_id=" +
              //       SecretKeys.GITHUB_CLIENT_ID +
              //       "&scope=public_repo%20read:user%20user:email";
              //   if (await canLaunch(url)) {
              //     print("jjdjdjd");
              //     await launch(
              //       url,
              //       forceSafariVC: false,
              //       forceWebView: false,
              //     );
              //   } else {
              //     print("CANNOT LAUNCH THIS URL!");
              //   }
              // },
              final provider =
                  Provider.of<GitHubSignInProvider>(context, listen: false);
              await provider.login(context);
            },
            iconLoacation: "assets/github.png",
          ),
        ],
      ),
    );
  }
}

class SIgnInMethod extends StatelessWidget {
  final String methodname;
  final Function onPressed;
  final String iconLoacation;
  const SIgnInMethod({
    Key key,
    this.methodname,
    this.onPressed,
    this.iconLoacation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlineButton(
      splashColor: Colors.grey,
      onPressed: onPressed,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      highlightElevation: 0,
      borderSide: BorderSide(color: Colors.grey),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(image: AssetImage(iconLoacation), height: 35.0),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                'Sign in with $methodname',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
