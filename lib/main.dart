import 'package:bhumi_mobile/app/app.dart';
import 'package:bhumi_mobile/app/di/di.dart';
import 'package:flutter/cupertino.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initDependencies();
  runApp(
    const App(),
  );
}
