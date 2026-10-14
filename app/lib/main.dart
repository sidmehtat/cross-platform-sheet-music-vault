import 'package:flutter/material.dart';

import 'app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // TODO(firebase): run `flutterfire configure`, then:
  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const SheetMusicVaultApp());
}
