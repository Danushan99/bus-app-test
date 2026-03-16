import 'package:test_bus_app/config/app_config.dart';
import 'package:test_bus_app/main_common.dart';

Future<void> main() async {
  const config = AppConfig(
    environment: Environment.dev,
    baseUrl: 'https://dev.api.testbus.com',
  );

  await mainCommon(config);
}
