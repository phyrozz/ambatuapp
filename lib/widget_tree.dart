import 'package:ambatuapp/main.dart';
import 'package:ambatuapp/pages/auth/login.dart';
import 'package:ambatuapp/pages/home.dart';
import 'package:flutter/material.dart';

import 'package:supabase_flutter/supabase_flutter.dart';

class AuthTree extends StatelessWidget {
  const AuthTree({super.key, required this.themeModel});

  final ThemeModel themeModel;

  @override
  Widget build(BuildContext context) {
    final supabaseClient = Supabase.instance.client;

    return StreamBuilder<AuthState>(
      stream: supabaseClient.auth.onAuthStateChange,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: Column(
                children: [
                  CircularProgressIndicator(),
                  SizedBox(
                    height: 18,
                  ),
                  Text("Ambatuload...")
                ],
              ),
            ),
          );
        } else {
          if (snapshot.hasData &&
              snapshot.data!.event == AuthChangeEvent.signedIn) {
            return const HomePage();
          } else {
            return const LoginPage();
          }
        }
      },
    );
  }
}
