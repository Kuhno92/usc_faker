import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:usc_faker/bloc/UscProvider/usc_provider_bloc.dart';
import 'package:usc_faker/screens/provider_selection_screen.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'usc_faker',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          primaryColor: Colors.grey,
          textTheme: TextTheme(
              bodyMedium: TextStyle(fontSize: 16.0, color: Colors.white),
              bodyLarge: TextStyle(fontSize: 20.0, color: Colors.red))),
      home: BlocProvider(
        create: (context) => UscProviderBloc()..add(LoadUscProvider()),
        lazy: false,
        child: ProviderSelectionScreen(),
      ),
    );
  }
}
