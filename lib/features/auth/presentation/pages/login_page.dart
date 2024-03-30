import 'package:flutter/material.dart';
import 'package:group_8_easy_pharmacy/features/auth/presentation/pages/otp_verification.dart';
import 'package:group_8_easy_pharmacy/features/auth/presentation/pages/register_page.dart';
// import 'package:flutter_icons/flutter_icons.dart';


import '../../../../shared/shared.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SizedBox(height: MediaQuery.of(context).size.height * 0.075),
                const Text(
                  'Log in to your account✨',
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8.0),
                const Text(
                  'Welcome back! Please enter your details.',
                  style: TextStyle(fontSize: 16.0, color: Colors.black54),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                CustomInputField(
                  fieldType: InputFieldType.email,
                  label: 'Email',
                  hintText: 'Enter your email',
                  controller: TextEditingController(),
                  onChanged: (value) {
                    print('Email: $value');
                  },
                  // Optional: Customize styles if needed
                  labelStyle: const TextStyle(color: Colors.black),
                  hintStyle: const TextStyle(color: Colors.grey),
                  fillColor: Colors.grey[200],
                  prefixIcon: const Icon(Icons.email, color: Colors.grey),
                  cursorColor: Colors.blue,
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.015),
                CustomInputField(
                  fieldType: InputFieldType.password,
                  label: 'Password',
                  hintText: 'Enter your password',
                  controller: TextEditingController(),
                  onChanged: (value) {
                    print('Password: $value');
                  },
                  // Optional: Customize styles if needed
                  labelStyle: const TextStyle(color: Colors.black),
                  hintStyle: const TextStyle(color: Colors.grey),
                  fillColor: Colors.grey[200],
                  prefixIcon: const Icon(Icons.lock, color: Colors.grey),
                  cursorColor: Colors.blue,
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                Row(
                  children: <Widget>[
                    Checkbox(value: true, onChanged: (newValue) {}),
                    const Text('Remember for 30 days'),
                    const Spacer(),
                    TextButton(
                      child: const Text('Forgot password'),
                      onPressed: () {},
                    ),
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                CustomButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OtpVerificationPage(),
                      ),
                    );
                  },
                  buttonType: ButtonType.elevated,
                  label: "Log In",
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.015),
                CustomButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RegisterPage(),
                      ),
                    );
                  },
                  buttonType: ButtonType.outlined,
                  label: "Log In with Google",
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Image.asset(
                        'assets/icons/google_logo.png',
                        height: 24.0,
                      ),
                      const SizedBox(width: 8.0),
                      const Text('Log In with Google'),
                    ],
                  ),
                  // icon: IconData(),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                CustomButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const RegisterPage()));
                  },
                  buttonType: ButtonType.outlined,
                  label: "Log In with Phone Number",
                  icon: Icons.phone_outlined,
                ),
              ],
            ),
            const CustomButton(
              buttonType: ButtonType.text,
              label: "Don\'t have an account? Sign up here ",
            )
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
