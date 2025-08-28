import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_app/src/features/auth/presentation/bloc/auth_bloc.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _repeatedPasswordController = TextEditingController();
  bool _isLoading = false;
  final formKey = GlobalKey<FormState>();

  void _signUp() {
    if (_emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty &&
        _repeatedPasswordController.text.isNotEmpty) {
      final isValid = formKey.currentState!.validate();
      if (!isValid) return;
      setState(() => _isLoading = true);
      context.read<AuthBloc>().add(SignUpUser(
            email: _emailController.text,
            password: _passwordController.text,
            repeatedPassword: _repeatedPasswordController.text,
          ));
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _repeatedPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        setState(() => _isLoading = false);

        if (state is AuthErrorState) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(state.errorMessage),
                backgroundColor: Colors.red,
              ),
            );
        }
        if (state is UserAuthorized) {
          if (Navigator.of(context).canPop()) {
            Navigator.of(context).pop();
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Sign Up')),
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Create Account',
                    style: Theme.of(context).textTheme.headlineMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: (email) =>
                        email != null && !EmailValidator.validate(email)
                            ? 'Enter a correct email'
                            : null,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.email),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    validator: (password) =>
                        password != null && password.length < 6
                            ? 'Enter a password with at least 6 symbols in it'
                            : null,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.lock_outline),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _repeatedPasswordController,
                    obscureText: true,
                    validator: (password) =>
                        password != null && password.length < 6
                            ? 'Enter a password with at least 6 symbols in it'
                            : null,
                    decoration: const InputDecoration(
                      labelText: 'Repeat Password',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.lock),
                    ),
                  ),
                  const SizedBox(height: 24),
                  _isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                          onPressed: _signUp,
                          child: const Text('SIGN UP'),
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
