import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/core.dart';
import '../../../auth/auth.dart';
import '../presentation.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ProfileBloc(sharedPreferencesHelper: SharedPreferencesHelper())
            ..add(LoadProfileEvent()),
      child: Scaffold(
        body: BlocListener<ProfileBloc, ProfileState>(
          listener: (context, state) {
            if (state is ProfileInitial) {
              Navigator.pushReplacementNamed(context, '/login');
            }
          },
          child: Column(
            children: <Widget>[
              _userHeader(context),
              Expanded(
                child: _menuSection(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _userHeader(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state is ProfileLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ProfileLoaded) {
          return Container(
            color: Colors.blue[800],
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
            child: SafeArea(
              bottom: false,
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.person,
                      size: 40,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          state.user.userData.fullName,
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(color: Colors.white),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          state.user.userData.email,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        } else if (state is ProfileError) {
          return Center(child: Text(state.message));
        } else {
          return const Center(child: Text('No user data'));
        }
      },
    );
  }

  Widget _menuSection(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildListItem(
          context,
          Icons.settings,
          "Settings",
          () {
            // Implement onTap functionality for Settings
          },
        ),
        _logoutButton(context),
      ],
    );
  }

  Widget _buildListItem(
      BuildContext context, IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Theme.of(context).colorScheme.primary),
      title: Text(
        title,
        style: TextStyle(
          color: Theme.of(context).colorScheme.onSurface,
        ),
      ),
      onTap: onTap,
    );
  }

  Widget _logoutButton(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.exit_to_app, color: Colors.red),
      title: const Text(
        "Logout",
        style: TextStyle(color: Colors.red),
      ),
      onTap: () async {
        final prefs = await SharedPreferences.getInstance();
        await prefs.clear();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      },
    );
  }
}
