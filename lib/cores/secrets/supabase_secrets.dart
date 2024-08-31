import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppSecrets {
  static String get supabaseUrl => dotenv.env['SUPABASE_URL'] ?? '';
  static String get supabaseApon => dotenv.env['SUPABASE_APON'] ?? '';
}
