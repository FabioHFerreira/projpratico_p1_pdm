import 'package:flutter/material.dart';

class PaginaLogin extends StatefulWidget {
  @override
  PaginaLoginState createState() => PaginaLoginState();
}

class PaginaLoginState extends State<PaginaLogin> {
  TextEditingController emailController = TextEditingController();
  TextEditingController senhaController = TextEditingController();

  bool emailPreenchido = false;
  bool senhaPreenchida = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Login',
          style: TextStyle(
            color: Colors.grey[600],
          ),
        ),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              onChanged: (value) {
                setState(() {
                  emailPreenchido = value.isNotEmpty;
                });
              },
              decoration: InputDecoration(
                labelText: 'Email',
                labelStyle: TextStyle(color: Colors.grey[800]),
                errorText: emailPreenchido ? null : 'Insira seu email',
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: senhaController,
              onChanged: (value) {
                setState(() {
                  senhaPreenchida = value.isNotEmpty;
                });
              },
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Senha',
                labelStyle: TextStyle(color: Colors.grey[800]),
                errorText: senhaPreenchida ? null : 'Insira sua senha',
              ),
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    mostrarDialogoRecuperarSenha(context);
                  },
                  child: Text(
                    'Esqueceu a senha?',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.blueGrey[600],
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: emailPreenchido && senhaPreenchida
                      ? () {
                          Navigator.pushNamed(context, '/listaCompras');
                        }
                      : null,
                  child: Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.white,
                    ),
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/sobre');
                  },
                  child: Text(
                    'Sobre',
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      fontSize: 16.0,
                      color: Colors.blueGrey[600],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Função para mostrar o diálogo de recuperação de senha
  void mostrarDialogoRecuperarSenha(BuildContext context) {
    String email = '';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Esqueceu a senha?'),
          backgroundColor: Colors.grey[300],
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                onChanged: (value) {
                  email = value;
                },
                decoration: InputDecoration(
                  labelText: 'Email',
                  labelStyle: TextStyle(color: Colors.grey[800]),
                ),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  mostrarMensagem(context, email);
                },
                child: Text(
                  'Enviar',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Função para mostrar o diálogo com a mensagem de recuperação de senha enviada
  void mostrarMensagem(BuildContext context, String email) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Senha Esquecida',
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.grey[300],
          content: Text(
            'Um link de mudança de senha foi enviado para o email: $email',
            style: TextStyle(color: Colors.black),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'OK',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        );
      },
    );
  }
}
