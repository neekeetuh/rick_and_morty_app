import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:rick_and_morty_app/src/features/auth/presentation/bloc/auth_bloc.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is UserAuthorized) {
          final user = state.user;
          final photoUrl = user.photoUrl ??
              'https://sun9-38.userapi.com/s/v1/ig2/nDGdDxMuWkKpd8U-j7qwMBJrfFDb1UjiSnSBWdOe71whC0ahEd6nQ1od_vuzKCacGrjiT8qNl3MvIIgLqP_DuSHs.jpg?quality=95&as=32x32,48x48,72x72,108x108,160x160,240x240,360x360,480x480,540x540,640x640,720x720,736x736&from=bu&cs=736x0';

          return Scaffold(
            appBar: AppBar(
              title: const Text('Profile'),
              actions: [
                IconButton(
                  icon: const Icon(Icons.logout),
                  onPressed: () {
                    context.read<AuthBloc>().add(const SignOutUser());
                  },
                ),
              ],
            ),
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.grey.shade300,
                      backgroundImage: CachedNetworkImageProvider(photoUrl),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      user.displayName,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      user.email,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(height: 40),
                    ElevatedButton.icon(
                      icon: const Icon(Icons.logout),
                      label: const Text('SIGN OUT'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red.shade400,
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () {
                        context.read<AuthBloc>().add(const SignOutUser());
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        }
        return const Scaffold(
          body: Center(
            child: Text('Something went wrong.'),
          ),
        );
      },
    );
  }
}
