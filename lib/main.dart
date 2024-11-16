import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:models/app/injector.dart';
import 'package:models/app/ui/pages/auth_page.dart';
import 'package:models/app/ui/pages/home_page.dart';
import 'package:models/app/ui/pages/model_form_page.dart';
import 'package:models/app/ui/pages/splash_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupInjector();
  await dotenv.load(fileName: '.env');
  await Supabase.initialize(
      url: dotenv.env['SUPABASE_URL']!,
      anonKey: dotenv.env['SUPABASE_ANON_KEY']!);
  runApp(const MyApp());
}

final supabase = Supabase.instance.client;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Models',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routes: {
        '/': (context) => const SplashPage(),
        '/auth': (context) => const AuthPage(),
        '/home': (context) => const HomePage(),
        '/upload': (context) => const ModelFormPage(),
      },
    );
  }
}
