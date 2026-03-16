import 'package:test_bus_app/config/app_config.dart';
import 'package:test_bus_app/main_common.dart';

Future<void> main() async {
  const config = AppConfig(
    environment: Environment.staging,
    baseUrl:
        'https://staging.api.testbus.com', // Replace with actual Staging URL
  );

  await mainCommon(config);
}
