import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spesa_app/core/repository/list_item_repository.dart';
import 'package:spesa_app/core/repository/lists_repository.dart';
import 'package:spesa_app/locator.dart';

import 'ui/router.dart';

void main() async {
  setupLocator();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(SpesaApp());
}

class SpesaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => locator<ListsRepository>()),
        ChangeNotifierProvider(create: (_) => locator<ListItemRepository>())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        title: 'Leo App',
        theme: ThemeData(
          fontFamily: 'Poppins',
          brightness: Brightness.light,
        ),
        darkTheme: ThemeData(
          fontFamily: 'Poppins',
          brightness: Brightness.dark,
        ),
        onGenerateRoute: AppRouter.generateRoute,
      ),
    );

    // return MaterialApp(
    //   title: 'Spesa App',
    //   theme: ThemeData(
    //     // Define the default brightness and colors.
    //     brightness: Brightness.light,
    //     primaryColor: Color(0xff0B132B),
    //     accentColor: Color(0xff2274A5),
    //
    //     // FCA311 E5E5E5 FFFFFF
    //     // Define the default font family.
    //     fontFamily: 'Poppins',
    //   ),
    //   home: Authentication(),
    // );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      body: Container(),
    ); // This trailing comma makes auto-formatting nicer for build methods.
  }
}
