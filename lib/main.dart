import 'package:flutter/material.dart';
import 'package:pincode_api/provider.dart';
import 'package:pincode_api/screens/homepage.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => themeprovider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'productsans',
        brightness: (context.watch<themeprovider>().current_theme == 0)
            ? (Brightness.light)
            : (Brightness.dark),
        useMaterial3: true,
        // colorSchemeSeed: Colors.green,
        // primaryColor: Colors.pink,
        primarySwatch: Colors.green,
        textTheme: TextTheme(
          titleSmall: TextStyle(
            fontSize: 18,
          ),
          titleMedium: TextStyle(
            fontSize: 16,
          ),
        ),
        dataTableTheme: DataTableThemeData(
          dividerThickness: 0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              width: 1,
            ),
          ),
          columnSpacing: 30,
        ),
        switchTheme: SwitchThemeData(
          splashRadius: 10,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            elevation: 7,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
              width: 2,
            ),
          ),
        ),
      ),
      home: homePage(),
    );
  }
}
