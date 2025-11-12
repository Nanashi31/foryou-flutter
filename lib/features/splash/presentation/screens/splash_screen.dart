import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _redirect();
  }

  Future<void> _redirect() async {
    // Wait for a short duration to allow the frame to build.
    await Future.delayed(Duration.zero);

    // The user wants to ALWAYS start on the login screen.
    // To ensure this, we will sign out any existing session from a previous
    // hot-restart/debug session and then navigate to the login page.
    try {
      await Supabase.instance.client.auth.signOut();
    } catch (_) {
      // Ignore any error, the goal is to be logged out.
    }

    if (mounted) {
      Navigator.of(context).pushReplacementNamed('/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
