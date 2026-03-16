import 'package:test_bus_app/config/app_config.dart';
import 'package:test_bus_app/main_common.dart';

Future<void> main() async {
  const config = AppConfig(
    environment: Environment.prod,
    baseUrl: 'https://api.testbus.com',
    supabaseUrl: 'YOUR_SUPABASE_URL',
    supabaseAnonKey: 'YOUR_SUPABASE_ANON_KEY',
  );

  await mainCommon(config);
}
