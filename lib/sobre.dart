import 'package:flutter/material.dart';

class PaginaSobre extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sobre'), // Título da página "Sobre"
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Este aplicativo de Lista de Compras foi desenvolvido para ajudar os usuários a criar e gerenciar suas listas de compras de forma eficiente.', // Descrição do propósito do aplicativo
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Roboto',
                  letterSpacing: 1.2,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Desenvolvedor: Fábio Henrique Ferreira', // Informação sobre o desenvolvedor do aplicativo
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontStyle: FontStyle.italic,
                  color: Colors.grey[700],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
