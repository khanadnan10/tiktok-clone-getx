import 'package:flutter/Material.dart';
import 'package:tiktok_new_clone/controller/auth_controller.dart';
import 'package:tiktok_new_clone/utils/constants.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Column(
          children: [
            Text(firebaseAuth.currentUser!.uid),
            TextButton(
                onPressed: () => AuthController.instance.signOut(),
                child: Text('Sign out')),
          ],
        ),
      )),
    );
  }
}
