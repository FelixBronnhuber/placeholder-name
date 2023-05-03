import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:placeholder_name/view_model/card_view_model.dart';
import 'package:provider/provider.dart';
import 'package:placeholder_name/view/screens/search_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: CardViewModel()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: true,
        title: 'Deck Builder',
        theme: ThemeData(
          appBarTheme: const AppBarTheme(),
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const SearchScreen(),
        },
      ),
    );
  }
}

