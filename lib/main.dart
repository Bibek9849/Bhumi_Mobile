import 'package:bhumi_mobile/app/app.dart';
import 'package:bhumi_mobile/app/di/di.dart';
import 'package:bhumi_mobile/core/network/hive_service.dart';
import 'package:flutter/cupertino.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await HiveService.init();
  await initDependencies();
  runApp(
    const App(),
  );
}
