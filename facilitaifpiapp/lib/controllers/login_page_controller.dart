import 'package:facilitaifpiapp/components/login_field.dart';
import 'package:facilitaifpiapp/models/user_model.dart';
import 'package:facilitaifpiapp/repositories/user_repository.dart';
import 'package:flutter/material.dart';

import '../views/logo_view.dart';

class LoginPageController extends StatefulWidget {
  const LoginPageController({super.key});

  @override
  State<LoginPageController> createState() => _LoginPageControllerState();
}

class _LoginPageControllerState extends State<LoginPageController> {
  final userRepository = UserRepository();
  final _formKey = GlobalKey<FormState>();
  UserModel? _loggedUser;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void doLogin() async {
    if (_formKey.currentState!.validate()) {
      await searchUserByEmailAndPassword(
              emailController.text, passwordController.text)
          .then((UserModel loggedUser) {
        setState(() {
          _loggedUser = loggedUser;
        });
        Navigator.pushNamed(context, '/home');
      }).catchError((e) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Login ou senha estão incorretos.'),
          ),
        );
        debugPrint(e.toString());
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Os campos de login e senha devem ser preenchidos '),
        ),
      );
    }
  }

  Future<UserModel> searchUserByEmailAndPassword(
      String email, String password) async {
    return await userRepository.getUserByEmailAndPassword(email, password);
  }

  @override
  Widget build(context) {
    const burnedYellow = Color.fromARGB(238, 255, 183, 59);
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 60),
                child: Center(
                  child: LogoView(),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                child: LoginField('Email', controller: emailController),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: LoginField('Senha',
                    controller: passwordController, obscureText: true),
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
                    onPressed: doLogin,
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
      ),
    );
  }
}
