import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'package:mercado_da_bola/login.dart';
import 'listacompras.dart';
import 'sobre.dart';

void main() {
  runApp(
    DevicePreview(
      enabled: true,
      builder: (context) => MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lista de Compras',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.black,
        ),
        textTheme: TextTheme(
          headline6: TextStyle(
            color: Colors.grey[600], 
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          labelStyle: TextStyle(
            color: Colors.grey[800], 
          ),
          errorStyle: TextStyle(
            color: Colors.red, 
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
                Colors.black ?? Colors.transparent), 
            foregroundColor: MaterialStateProperty.all<Color>(
                Colors.white),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(
                Colors.blueGrey),
          ),
        ),
        dialogTheme: DialogTheme(
          backgroundColor: Colors.grey[300] ?? Colors
              .transparent,
          titleTextStyle: TextStyle(
            color: Colors.black,
          ),
          contentTextStyle: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => PaginaLogin(), // Rota inicial para a página de login
        '/listaCompras': (context) => PaginaListaCompras(), // Rota para a página de lista de compras
        '/sobre': (context) => PaginaSobre(), // Rota para a página "Sobre"
      },
    );
  }
}
