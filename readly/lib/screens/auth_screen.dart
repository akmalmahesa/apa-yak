import 'package:flutter/material.dart';
import '../core/theme.dart';
import '../navigator.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _emailController = TextEditingController(text: 'alex@readly.app');
  final _passwordController = TextEditingController(text: 'alex123');
  bool _isLogin = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _enterApp() {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const AppNavigator()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 20),
                const Text(
                  'Welcome to Readly',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Georgia',
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Login or register to continue as Alex.',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.caption,
                ),
                const SizedBox(height: 28),
                Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppColors.borderColor),
                  ),
                  child: Column(
                    children: [
                      ToggleButtons(
                        isSelected: [_isLogin, !_isLogin],
                        borderRadius: BorderRadius.circular(14),
                        onPressed: (index) {
                          setState(() => _isLogin = index == 0);
                        },
                        selectedColor: Colors.white,
                        fillColor: AppColors.primary,
                        color: AppColors.textPrimary,
                        constraints: const BoxConstraints(
                          minHeight: 44,
                          minWidth: 120,
                        ),
                        children: const [Text('Login'), Text('Register')],
                      ),
                      const SizedBox(height: 18),
                      TextField(
                        controller: _emailController,
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          labelText: 'Password',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 18),
                      SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: ElevatedButton(
                          onPressed: _enterApp,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: Text(
                            _isLogin
                                ? 'Login as Alex'
                                : 'Create account & continue',
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextButton(
                        onPressed: _enterApp,
                        child: const Text('Skip for now'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
