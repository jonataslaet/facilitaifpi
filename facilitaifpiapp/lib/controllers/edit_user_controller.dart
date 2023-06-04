import 'package:facilitaifpiapp/components/signup_field.dart';
import 'package:facilitaifpiapp/models/user_model.dart';
import 'package:facilitaifpiapp/repositories/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class EditUserController extends StatefulWidget {
  const EditUserController({required this.userId, super.key});
  final int userId;
  
  @override
  State<EditUserController> createState() => _EditUserControllerState();
}

class _EditUserControllerState extends State<EditUserController> {
  UserRepository userRepository = UserRepository();
  Position? _currentPosition;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final imageUrlController = TextEditingController();

  void _loadUser() {
    userRepository.getUser(widget.userId).then((userModel) => {
      setState(() {
        emailController.text = userModel.name ?? '';
        passwordController.text = userModel.password ?? '';
        nameController.text = userModel.name ?? '';
        imageUrlController.text = userModel.avatarUrl ?? '';
      })
    });
  }

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _getCurrentLocation() async {
    final hasPermission = await _handleLocationPermission();
    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() => _currentPosition = position);
    }).catchError((e) {
      debugPrint(e);
    });
  }

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
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
                  
                  onPressed: () {
                    _updateUser(widget.userId, emailController.text, passwordController.text, nameController.text, imageUrlController.text);
                    Navigator.pushNamed(context, '/users');
                  },
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

  Future<UserModel> _updateUser(int? id, String email, String password, String name, String avatarUrl) async {
    if (id == null) throw Exception('Usuário não encontrado');
    return await userRepository.updateUser(widget.userId, email, password, name, avatarUrl, _currentPosition?.latitude ?? 0.0, _currentPosition?.longitude ?? 0.0);
  }
}
