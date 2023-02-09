import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktok_new_clone/controller/auth_controller.dart';

import '../../utils/constants.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _usernameController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Align(
              child: GestureDetector(
                onTap: () => AuthController.instance.pickImage(),
                child: AuthController.instance.profilePhoto != null
                    ? CircleAvatar(
                        radius: 50.0,
                        backgroundImage: FileImage(
                          AuthController.instance.profilePhoto!,
                        ),
                      )
                    : CircleAvatar(
                        radius: 50.0,
                        backgroundColor: Colors.grey[200],
                        child: const Icon(
                          Icons.person,
                          color: kButtomColor,
                          size: 30.0,
                        ),
                      ),
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            TextFormField(
              controller: _usernameController,
              decoration: const InputDecoration(
                hintText: 'Username',
                label: Text('Username'),
                border: OutlineInputBorder(),
              ),
              validator: (String? value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Username required';
                }
                if (value.trim().length < 2) {
                  return 'Username must be at least 2 characters long';
                }
                return null;
              },
            ),
            const SizedBox(
              height: 10.0,
            ),
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(
                hintText: 'Email',
                label: Text('Email'),
                border: OutlineInputBorder(),
              ),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Email required';
                }
                if (!EmailValidator.validate(value)) {
                  return 'Enter a valid email';
                }
                return null;
              },
            ),
            const SizedBox(
              height: 10.0,
            ),
            TextFormField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                hintText: 'Password',
                label: Text('Password'),
                border: OutlineInputBorder(),
              ),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Password required';
                }
                if (value.trim().length < 6) {
                  return 'Enter a valid Password';
                }
                return null;
              },
            ),
            const SizedBox(
              height: 10.0,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(),
              onPressed: () {
                AuthController.instance.signUpUser(
                  _usernameController.text.trim(),
                  _emailController.text.trim(),
                  _passwordController.text.trim(),
                  AuthController.instance.profilePhoto,
                );
              },
              child: const Text(
                'Register',
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Already have an account?',
                  style: TextStyle(),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Login',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
