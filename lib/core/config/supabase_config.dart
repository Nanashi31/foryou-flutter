import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseConfig {
  static const String supabaseUrl = 'https://uklohjdookcdibmogivq.supabase.co';
  static const String supabaseAnonKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InVrbG9oamRvb2tjZGlibW9naXZxIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjI4NzE3NDAsImV4cCI6MjA3ODQ0Nzc0MH0.jJ43YiWZiZ5zrkPIGKjjJC2DhXNpp6AnIzwqIhiw0nw';

  static Future<void> init() async {
    await Supabase.initialize(
      url: supabaseUrl,
      anonKey: supabaseAnonKey,
    );
  }

  static SupabaseClient get client => Supabase.instance.client;
}