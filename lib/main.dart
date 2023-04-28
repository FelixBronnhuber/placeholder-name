import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:placeholder_name/view_model/card_view_model.dart';
import 'package:provider/provider.dart';
import 'package:placeholder_name/view/screens/search_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: CardViewModel()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Deck Builder',
        theme: ThemeData(
          appBarTheme: AppBarTheme(),
          primarySwatch: Colors.blue,
          accentColor: Colors.blueGrey,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => SearchScreen(),
        },
      ),
    );
  }
}

