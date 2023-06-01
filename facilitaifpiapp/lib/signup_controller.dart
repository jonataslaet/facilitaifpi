import 'package:facilitaifpiapp/components/signup_field.dart';
import 'package:facilitaifpiapp/user_repository.dart';
import 'package:flutter/material.dart';

import 'logo_view.dart';

class SignupController extends StatefulWidget {
  const SignupController({super.key});

  @override
  State<SignupController> createState() => _SignupControllerState();
}

class _SignupControllerState extends State<SignupController> {
  UserRepository userRepository = UserRepository();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  String status = 'Não cadastrado';

  void cadastrarUsuario() {
    final email = emailController.text;
    final password = passwordController.text;
    userRepository.createUser(email, password);
  }

  @override
  Widget build(BuildContext context) {
    const burnedYellow = Color.fromARGB(238, 255, 183, 59);
    return SizedBox(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 10),
              child: Center(
                child: LogoView(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              child: SignupField(
                'Login',
                valueController: emailController,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: SignupField(
                'Senha',
                valueController: passwordController,
                keyboardType: TextInputType.number,
                obscureText: true,
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
                  onPressed: cadastrarUsuario,
                  child: const Text(
                    'Cadastrar',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                    ),
                  ),
                ),
              ),
            ),
            Text('Status: $status')
          ],
        ),
      ),
    );
  }
}
