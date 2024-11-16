import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:supabase_auth_ui/supabase_auth_ui.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.fromLTRB(24.0, 96.0, 24.0, 24.0),
        children: [
          Column(
            children: [
              const Text(
                'Supabase Auth UI',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 24.0),
              SupaMagicAuth(
                redirectUrl:
                    kIsWeb ? null : "io.supabase.modelsi://login-callback/",
                onSuccess: (session) => Navigator.pushNamed(context, '/home'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
