import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:tiktok_new_clone/controller/auth_controller.dart';
import 'package:tiktok_new_clone/utils/constants.dart';
import 'package:tiktok_new_clone/utils/router.dart';
import 'package:tiktok_new_clone/views/auth/signup_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void loginSubmit() {
    final form = _formKey.currentState;

    if (form == null || !form.validate()) {
      return;
    }

    form.save();

    AuthController.instance
        .signInUser(_emailController.text, _passwordController.text);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(
                      height: screenSize.height * 0.2,
                      image: const AssetImage('assets/images/tiktok-logo.png'),
                    ),
                    const Text(
                      'TikTok Clone',
                      style: TextStyle(
                          fontSize: 35.0, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                      controller: _emailController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                        hintText: 'Email',
                        label: const Text('Email'),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6.0),
                          borderSide: const BorderSide(color: Colors.white),
                        ),
                      ),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Email required';
                        }
                        if (!EmailValidator.validate(value)) {
                          return 'Enter a valid email';
                        }
                      },
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                      controller: _passwordController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: 'Password',
                        label: const Text('Password'),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6.0),
                          borderSide: const BorderSide(color: Colors.white),
                        ),
                      ),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Password required';
                        }
                        if (value.trim().length < 6) {
                          return 'Password a valid email';
                        }
                      },
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Container(
                      width: screenSize.width / 1.5,
                      height: screenSize.height * 0.07,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(55.0)),
                      ),
                      child: TextButton(
                        onPressed: () {
                          loginSubmit();
                        },
                        child: Text(
                          'Login',
                          style: TextStyle(color: kBackgroundColor),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Don\'t have an account?',
                        ),
                        TextButton(
                          onPressed: () {
                            nextPage(context, const SignupScreen());
                          },
                          child: const Text(
                            'Register Now',
                            style: TextStyle(color: kButtomColor),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
