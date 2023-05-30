import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(context) {
    const burnedYellow = Color.fromARGB(238, 255, 183, 59);
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 60),
              child: Center(
                child: Container(
                  alignment: Alignment.topCenter,
                  height: 150.0,
                  width: 190.0,
                  child: Image.asset('assets/images/logo-ifpi.png'),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              child: TextField(
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black,
                      width: 5.0,
                      style: BorderStyle.solid
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black,
                      width: 5.0,
                      style: BorderStyle.solid
                    ),
                  ),
                  labelText: 'Email',
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: TextField(
                obscureText: true,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black,
                      width: 5.0,
                      style: BorderStyle.solid
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black,
                      width: 5.0,
                      style: BorderStyle.solid
                    ),
                  ),
                  labelText: 'Senha',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Container(
                width: 330,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                    width: 3.0,
                  ),
                  color: burnedYellow,
                ),
                child: ElevatedButton(
                  style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll<Color>(
                      burnedYellow,
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/home');
                  },
                  child: const Text(
                    'Entrar',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                    ),
                  ),
                ),
              ),
            ),
            const Text('Cadastrar conta'),
          ],
        ),
      ),
    );
  }
}
