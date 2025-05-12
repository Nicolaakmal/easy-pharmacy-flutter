import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import '../../../../core/core.dart';
import '../../auth.dart';


class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _obscureText = true;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => AuthBloc(
          loginUser: LoginUser(
            AuthRepositoryImpl(
              apiServicesLogin: ApiServicesLoginImpl(http.Client()),
              apiServicesRegistration:
                  ApiServicesRegistrationImpl(http.Client()),
            ),
          ),
          registerUser: RegisterUser(
            AuthRepositoryImpl(
              apiServicesLogin: ApiServicesLoginImpl(http.Client()),
              apiServicesRegistration:
                  ApiServicesRegistrationImpl(http.Client()),
            ),
          ),
          sharedPreferencesHelper: SharedPreferencesHelper(),
        ),
        child: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthRegistered) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
              );
            } else if (state is AuthError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
          },
          child: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              return Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.blue.shade700, Colors.blue.shade300],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                padding: const EdgeInsets.all(16.0),
                child: Center(
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Card(
                            elevation: 6.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            shadowColor: Colors.black.withOpacity(0.2),
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  const Text(
                                    'Create an account',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 24,
                                      color: Colors.black,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'Welcome! Please enter your details.',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey[700],
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 24),
                                  _buildTextField(
                                    controller: _nameController,
                                    label: 'Name',
                                    hintText: 'Enter your name',
                                    icon: Icons.person,
                                    textInputAction: TextInputAction.next,
                                    validator: (value) =>
                                        value == null || value.isEmpty
                                            ? 'Name cannot be empty'
                                            : null,
                                  ),
                                  const SizedBox(height: 16),
                                  _buildTextField(
                                    controller: _emailController,
                                    label: 'Email',
                                    hintText: 'Enter your email',
                                    icon: Icons.email,
                                    textInputAction: TextInputAction.next,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Email cannot be empty';
                                      } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                                          .hasMatch(value)) {
                                        return 'Enter a valid email';
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(height: 16),
                                  _buildTextField(
                                    controller: _phoneController,
                                    label: 'Phone Number',
                                    hintText: 'Enter your phone number',
                                    icon: Icons.phone,
                                    textInputAction: TextInputAction.next,
                                    keyboardType: TextInputType.phone,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Phone number cannot be empty';
                                      } else if (!RegExp(r'^[0-9]+$')
                                          .hasMatch(value)) {
                                        return 'Enter a valid phone number';
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(height: 16),
                                  _buildTextField(
                                    controller: _passwordController,
                                    label: 'Password',
                                    hintText: 'Enter your password',
                                    icon: Icons.lock,
                                    textInputAction: TextInputAction.done,
                                    obscureText: _obscureText,
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        _obscureText
                                            ? Icons.visibility_off
                                            : Icons.visibility,
                                        color: Colors.grey,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _obscureText = !_obscureText;
                                        });
                                      },
                                    ),
                                    validator: (value) =>
                                        value == null || value.isEmpty
                                            ? 'Password cannot be empty'
                                            : null,
                                  ),
                                  const SizedBox(height: 16),
                                  state is AuthLoading
                                      ? const Center(
                                          child: CircularProgressIndicator())
                                      : ElevatedButton(
                                          onPressed: () {
                                            if (_formKey.currentState!
                                                .validate()) {
                                                  //1. kirim RegisterEvent ke AuthBloc dg data yg telah diisi pengguna
                                              context.read<AuthBloc>().add(
                                                  RegisterEvent(
                                                      fullName:
                                                          _nameController.text,
                                                      email:
                                                          _emailController.text,
                                                      phoneNumber:
                                                          _phoneController.text,
                                                      password:
                                                          _passwordController
                                                              .text,
                                                      roleUser: "user"));
                                            } else {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                const SnackBar(
                                                    content: Text(
                                                        'Please fill in all fields')),
                                              );
                                            }
                                          },
                                          style: ElevatedButton.styleFrom(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 16, vertical: 12),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            backgroundColor: const Color(0xFF2196F3),
                                            foregroundColor: Colors.white,
                                          ),
                                          child: const Text('Sign up'),
                                        ),
                                  // SizedBox(height: 16),
                                  // Row(
                                  //   children: [
                                  //     Expanded(
                                  //         child: Divider(
                                  //             color: Colors.grey,
                                  //             thickness: 1,
                                  //             endIndent: 10)),
                                  //     Text("or",
                                  //         style: TextStyle(
                                  //             color: Colors.grey,
                                  //             fontWeight: FontWeight.bold)),
                                  //     Expanded(
                                  //         child: Divider(
                                  //             color: Colors.grey,
                                  //             thickness: 1,
                                  //             indent: 10)),
                                  //   ],
                                  // ),
                                  // SizedBox(height: 16),
                                  // OutlinedButton(
                                  //   onPressed: () {
                                  //     // Handle sign up with Google
                                  //   },
                                  //   style: OutlinedButton.styleFrom(
                                  //     padding: const EdgeInsets.symmetric(
                                  //         horizontal: 16, vertical: 12),
                                  //     shape: RoundedRectangleBorder(
                                  //       borderRadius: BorderRadius.circular(8),
                                  //     ),
                                  //     side: BorderSide(color: Colors.blue),
                                  //   ),
                                  //   child: Row(
                                  //     mainAxisSize: MainAxisSize.min,
                                  //     children: [
                                  //       Image.asset(
                                  //           'assets/icons/google_logo.png',
                                  //           height: 24.0),
                                  //       SizedBox(width: 8),
                                  //       const Text('Sign up with Google'),
                                  // ],
                                  //   ),
                                  // ),
                                  // SizedBox(height: 16),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Already have an account?",
                                  style: TextStyle(color: Colors.white)),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const LoginScreen()));
                                },
                                child: const Text(' Log in',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.yellow)),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hintText,
    required IconData icon,
    bool obscureText = false,
    TextInputAction? textInputAction,
    Widget? suffixIcon,
    String? Function(String?)? validator,
    TextInputType? keyboardType,
  }) {
    return TextFormField(
      controller: controller,
      textInputAction: textInputAction,
      keyboardType: keyboardType ?? TextInputType.text,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: label,
        hintText: hintText,
        labelStyle: const TextStyle(color: Colors.black),
        hintStyle: const TextStyle(color: Colors.grey),
        fillColor: Colors.grey[200],
        filled: true,
        prefixIcon: Icon(icon, color: Colors.grey),
        suffixIcon: suffixIcon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
      ),
      validator: validator,
      cursorColor: Colors.blue,
    );
  }
}
