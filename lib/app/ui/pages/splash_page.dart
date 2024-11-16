import 'package:flutter/material.dart';
import 'package:models/app/ui/pages/auth_page.dart';
import 'package:models/app/ui/pages/home_page.dart';
import 'package:models/main.dart';

final activeSession = supabase.auth.currentSession;

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: activeSession == null ? const AuthPage() : const HomePage()),
    );
  }
}
