import 'package:flutter/material.dart';

import 'app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // TODO: set up firebase (flutterfire configure) then uncomment
  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const SheetMusicVaultApp());
}
