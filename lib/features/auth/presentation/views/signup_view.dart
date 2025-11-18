import 'package:blood_bank/presentation/views/home_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> with TickerProviderStateMixin {
  final TextEditingController _emailCtrl = TextEditingController();
  final TextEditingController _passwordCtrl = TextEditingController();
  final TextEditingController _nameCtrl = TextEditingController();
  final TextEditingController _phoneCtrl = TextEditingController();

  late AnimationController _fadeCtrl;
  late Animation<double> _fade;
  late AnimationController _buttonCtrl;

  bool _obscure = true;

  @override
  void initState() {
    super.initState();
    _fadeCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _fade = CurvedAnimation(parent: _fadeCtrl, curve: Curves.easeOut);
    _fadeCtrl.forward();

    _buttonCtrl = AnimationController(
      vsync: this,
      lowerBound: 0.9,
      upperBound: 1.0,
      duration: const Duration(milliseconds: 140),
      value: 1,
    );
  }

  @override
  void dispose() {
    _fadeCtrl.dispose();
    _buttonCtrl.dispose();
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    _nameCtrl.dispose();
    super.dispose();
  }

  bool _validateInputs() {
    final email = _emailCtrl.text.trim();
    final pass = _passwordCtrl.text;
    final name = _nameCtrl.text.trim();

    if (name.isEmpty) {
      _showMessage('Please enter your full name');
      return false;
    }

    if (email.isEmpty ||
        !RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}").hasMatch(email)) {
      _showMessage('Please enter a valid email');
      return false;
    }

    if (pass.length < 6) {
      _showMessage('Password must be at least 6 characters');
      return false;
    }

    return true;
  }

  void _showMessage(String msg) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(backgroundColor: Colors.red, content: Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFAFAFA),
      body: SafeArea(
        child: FadeTransition(
          opacity: _fade,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 150),
                  const Text(
                    'Create Account',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Join the community and help save lives',
                    style: TextStyle(color: Colors.black54),
                  ),
                  const SizedBox(height: 30),

                  _inputField(
                    label: 'Full Name',
                    controller: _nameCtrl,
                    icon: Icons.person_outline,
                  ),
                  const SizedBox(height: 16),

                  _inputField(
                    label: 'Phone',
                    controller: _phoneCtrl,
                    icon: Icons.person_outline,
                  ),
                  const SizedBox(height: 16),
                  _inputField(
                    label: 'Email',
                    controller: _emailCtrl,
                    icon: Icons.email_outlined,
                  ),
                  const SizedBox(height: 16),
                  _inputField(
                    label: 'Password',
                    controller: _passwordCtrl,
                    icon: Icons.lock_outline,
                    obscure: _obscure,
                    suffix: IconButton(
                      onPressed: () => setState(() => _obscure = !_obscure),
                      icon: Icon(
                        _obscure ? Icons.visibility_off : Icons.visibility,
                      ),
                    ),
                  ),

                  const SizedBox(height: 28),
                  ScaleTransition(
                    scale: _buttonCtrl,
                    child: SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: ElevatedButton(
                        onPressed: () async {
                          await _buttonCtrl.reverse();
                          await _buttonCtrl.forward();
                          try {
                            UserCredential userCredential = await FirebaseAuth
                                .instance
                                .createUserWithEmailAndPassword(
                                  email: _emailCtrl.text.trim(),
                                  password: _passwordCtrl.text.trim(),
                                );
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomeView(),
                              ),
                            );
                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'weak-password') {
                              print('The password provided is too weak.');
                            } else if (e.code == 'email-already-in-use') {
                              print(
                                'The account already exists for that email.',
                              );
                            }
                          } catch (e) {
                            print(e);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xffD32F2F),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          elevation: 3,
                        ),
                        child: const Text(
                          'Sign Up',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 18),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Already have an account? '),
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: const Text(
                          'Login',
                          style: TextStyle(
                            color: Color(0xffD32F2F),
                            fontWeight: FontWeight.bold,
                          ),
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
    );
  }

  Widget _inputField({
    required String label,
    required TextEditingController controller,
    required IconData icon,
    bool obscure = false,
    Widget? suffix,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.grey[700]),
        suffixIcon: suffix,
        filled: true,
        fillColor: Colors.grey.shade100,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 20,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Color(0xffD32F2F), width: 2),
        ),
      ),
    );
  }
}
