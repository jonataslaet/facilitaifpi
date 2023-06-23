import 'package:facilitaifpiapp/components/signup_field.dart';
import 'package:facilitaifpiapp/repositories/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class SignupController extends StatefulWidget {
  const SignupController({super.key});

  @override
  State<SignupController> createState() => _SignupControllerState();
}

class _SignupControllerState extends State<SignupController> {
  final UserRepository userRepository = UserRepository();
  Position? _currentPosition;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final imageUrlController = TextEditingController();

  String status = 'Não cadastrado';

  void createUser() {
    final email = emailController.text;
    final password = passwordController.text;
    final name = nameController.text;
    final imageUrl = imageUrlController.text;
    userRepository.createUser(email, password, name, imageUrl, _currentPosition?.latitude ?? 0.0, _currentPosition?.longitude ?? 0.0);
    Navigator.pushNamed(context, '/users');
  }

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
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

  @override
  Widget build(BuildContext context) {
    const burnedYellow = Color.fromARGB(238, 255, 183, 59);
    return SizedBox(
      child: Scaffold(
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
                  onPressed: createUser,
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

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Serviços de localização está desabilitados. Por favor, habilite os serviços.')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Permissões de localização estão negadas.')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Permissões de localização estão permanentemente negadas, não podemos requisitar permissões.')));
      return false;
    }
    return true;
  }
}
