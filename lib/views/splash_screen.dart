import 'package:flutter/material.dart';
import 'package:tiktok_new_clone/utils/router.dart';
import 'package:tiktok_new_clone/views/auth/login_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void count() {
    Future.delayed(Duration(seconds: 1), () {
      nextPageReplacement(context, LoginPage());
    });
  }

  @override
  void initState() {
    count();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: FlutterLogo(
            size: 40.0,
          ),
        ),
      ),
    );
  }
}
