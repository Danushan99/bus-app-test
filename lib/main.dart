import 'package:test_bus_app/main_dev.dart' as dev;

/// Default entry point that redirects to development.
/// Use 'flutter run -t lib/main_prod.dart' for production.
Future<void> main() async {
  await dev.main();
}
