import 'package:test_bus_app/config/app_config.dart';
import 'package:test_bus_app/main_common.dart';

Future<void> main() async {
  const config = AppConfig(
    environment: Environment.dev,
    baseUrl: 'https://dev.api.testbus.com',
    supabaseUrl: 'https://gmokuxqsgspcanfwhbgm.supabase.co',
    supabaseAnonKey: 'sb_publishable_1q_7w5qceKc189TrCoj4aA_mUh6uBFW',
  );

  await mainCommon(config);
}
