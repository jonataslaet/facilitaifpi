import 'package:facilitaifpiapp/components/login_field.dart';
import 'package:facilitaifpiapp/logo_view.dart';
import 'package:flutter/material.dart';

class LoginPageController extends StatefulWidget {
  const LoginPageController({super.key});

  @override
  State<LoginPageController> createState() => _LoginPageControllerState();
}

class _LoginPageControllerState extends State<LoginPageController> {
  @override
  Widget build(context) {
    const burnedYellow = Color.fromARGB(238, 255, 183, 59);
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 60),
              child: Center(
                child: LogoView(),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              child: LoginField('Email'),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: LoginField('Senha', obscureText: true),
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
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/signup');
              },
              child: const Text('Cadastrar'),
            ),
          ],
        ),
      ),
    );
  }
}
