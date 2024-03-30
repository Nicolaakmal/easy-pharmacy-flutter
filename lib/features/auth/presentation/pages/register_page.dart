import 'package:flutter/material.dart';
import 'package:group_8_easy_pharmacy/features/auth/presentation/pages/login_page.dart';
// import 'package:flutter_icons/flutter_icons.dart';
import '../../../../shared/shared.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
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
                  'Create an account✨',
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8.0),
                const Text(
                  'Welcome! Please enter your details.',
                  style: TextStyle(fontSize: 16.0, color: Colors.black54),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                CustomInputField(
                  fieldType: InputFieldType.text,
                  label: 'Name',
                  hintText: 'Enter your name',
                  controller: TextEditingController(),
                  onChanged: (value) {
                    print('Name: $value');
                  },
                  // Optional: Customize styles if needed
                  labelStyle: const TextStyle(color: Colors.black),
                  hintStyle: const TextStyle(color: Colors.grey),
                  fillColor: Colors.grey[200],
                  prefixIcon: const Icon(Icons.person, color: Colors.grey),
                  cursorColor: Colors.blue,
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.015),
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
                  fieldType: InputFieldType.text,
                  label: 'Phone Number',
                  hintText: 'Enter your phone number',
                  controller: TextEditingController(),
                  onChanged: (value) {
                    print('Phone number: $value');
                  },
                  // Optional: Customize styles if needed
                  labelStyle: const TextStyle(color: Colors.black),
                  hintStyle: const TextStyle(color: Colors.grey),
                  fillColor: Colors.grey[200],
                  prefixIcon: const Icon(Icons.person, color: Colors.grey),
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
                    const Text('Must be at least 8 characters'),
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                CustomButton(
                  onPressed: () {},
                  buttonType: ButtonType.elevated,
                  label: "Sign up",
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.015),
                CustomButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginPage(),
                      ),
                    );
                  },
                  buttonType: ButtonType.outlined,
                  label: "Sign up with Google",
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Image.asset(
                        'assets/icons/google_logo.png',
                        height: 24.0,
                      ),
                      const SizedBox(width: 8.0),
                      const Text('Sign up with Google'),
                    ],
                  ),
                  // icon: IconData(),
                ),
              ],
            ),
            const CustomButton(
              buttonType: ButtonType.text,
              label: "Already have an account? Log in here ",
            )
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
