import 'package:lets_get_serious/Auth/auth_page.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SentryFlutter.init(
    (options) {
      options.dsn =
          'https://faba9c5843334b20f4963acc8f77211a@o4508663950737408.ingest.us.sentry.io/4508663952703488';
      options.profilesSampleRate = 1.0;
      options.tracesSampleRate = 1.0;
    },
  );

  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: 'AIzaSyB9jg8kSOzgtnRERm7rd1kdcJqL73M7cUA',
      appId: '1:235128482918:android:f70d1a98f42b16493fd1a7',
      messagingSenderId: '235128482918',
      projectId: 'florai-ad17c',
    ),
  );

  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AuthPage(),
    );
  }
}
