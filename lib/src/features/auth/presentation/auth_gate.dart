import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_app/src/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:rick_and_morty_app/src/features/auth/presentation/login_screen.dart';
import 'package:rick_and_morty_app/src/features/auth/presentation/profile_screen.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is UserAuthorized) {
          return const ProfileScreen();
        }
        if (state is UserUnauthorized) {
          return const LoginScreen();
        }
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
