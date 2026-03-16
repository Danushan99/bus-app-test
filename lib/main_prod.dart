import 'package:test_bus_app/config/app_config.dart';
import 'package:test_bus_app/main_common.dart';

Future<void> main() async {
  const config = AppConfig(
    environment: Environment.prod,
    baseUrl: 'https://api.testbus.com', // Replace with actual Prod URL
  );

  await mainCommon(config);
}
