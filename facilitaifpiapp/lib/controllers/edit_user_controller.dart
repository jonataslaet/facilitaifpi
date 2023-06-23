import 'package:facilitaifpiapp/components/signup_field.dart';
import 'package:facilitaifpiapp/models/user_model.dart';
import 'package:facilitaifpiapp/repositories/user_repository.dart';
import 'package:flutter/material.dart';

class EditUserController extends StatefulWidget {
  const EditUserController(this.userModel, {super.key});
  final UserModel userModel;
  
  @override
  State<EditUserController> createState() => _EditUserControllerState();
}

class _EditUserControllerState extends State<EditUserController> {
  final UserRepository userRepository = UserRepository();
  
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final imageUrlController = TextEditingController();

  void _loadUser() {
    setState(() {
      emailController.text = widget.userModel.name ?? '';
      passwordController.text = widget.userModel.password ?? '';
      nameController.text = widget.userModel.name ?? '';
      imageUrlController.text = widget.userModel.avatarUrl ?? '';
    });
  }

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  void updateUser() {
    final email = emailController.text;
    final password = passwordController.text;
    final name = nameController.text;
    final imageUrl = imageUrlController.text;
    userRepository.updateUser(widget.userModel.userId!, email, password, name, imageUrl);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    const burnedYellow = Color.fromARGB(238, 255, 183, 59);
    return SizedBox(
      child: Scaffold(
        appBar: AppBar(title: const Text("Atualizar Contatos")),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              child: SignupField(
                'Login',
                valueController: emailController,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              child: SignupField(
                'Senha',
                valueController: passwordController,
                keyboardType: TextInputType.number,
                obscureText: true,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              child: SignupField(
                'Nome',
                valueController: nameController,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: SignupField(
                'Link de avatar',
                valueController: imageUrlController,
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
                  onPressed: updateUser,
                  child: const Text(
                    'Atualizar',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
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
  
}
