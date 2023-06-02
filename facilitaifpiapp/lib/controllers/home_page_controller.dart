import 'package:facilitaifpiapp/components/styled_text.dart';
import 'package:flutter/material.dart';

import '../views/logo_view.dart';

class HomePageController extends StatefulWidget {
  const HomePageController({super.key});

  @override
  State<HomePageController> createState() => _HomePageControllerState();
}

class _HomePageControllerState extends State<HomePageController> {
  
  @override
  Widget build(BuildContext context) {
    const burnedYellow = Color.fromARGB(238, 255, 183, 59);
    final squareSideSize = MediaQuery.of(context).size.width / 2;
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 60),
            child: Center(
              child: LogoView(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 60),
            child: Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
                      child: ElevatedButton(
                          onPressed: (){
                            Navigator.pushNamed(context, '/users');
                          },
                          style: ButtonStyle(
                            fixedSize: MaterialStatePropertyAll<Size>(Size.square(squareSideSize-8.0)),
                            backgroundColor: const MaterialStatePropertyAll<Color>(burnedYellow),
                            shape: const MaterialStatePropertyAll<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.zero,
                                side: BorderSide(color: burnedYellow)
                              ),
                            ),
                          ),
                          child: const StyledText(text: 'Contatos'),
                        ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
                      child: ElevatedButton(
                        onPressed: (){},
                        style: ButtonStyle(
                          fixedSize: MaterialStatePropertyAll<Size>(Size.square(squareSideSize-8.0)),
                          backgroundColor: const MaterialStatePropertyAll<Color>(burnedYellow),
                          shape: const MaterialStatePropertyAll<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero,
                              side: BorderSide(color: burnedYellow)
                            ),
                          ),
                        ),
                        child: const StyledText(text: 'Mapas'),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
                      child: ElevatedButton(
                          onPressed: (){},
                          style: ButtonStyle(
                            fixedSize: MaterialStatePropertyAll<Size>(Size.square(squareSideSize-8.0)),
                            backgroundColor: const MaterialStatePropertyAll<Color>(burnedYellow),
                            shape: const MaterialStatePropertyAll<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.zero,
                                side: BorderSide(color: burnedYellow)
                              ),
                            ),
                          ),
                          child: const StyledText(text: 'Extra'),
                        ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
                      child: ElevatedButton(
                        onPressed: (){},
                        style: ButtonStyle(
                          fixedSize: MaterialStatePropertyAll<Size>(Size.square(squareSideSize-8.0)),
                          backgroundColor: const MaterialStatePropertyAll<Color>(burnedYellow),
                          shape: const MaterialStatePropertyAll<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero,
                              side: BorderSide(color: burnedYellow)
                            ),
                          ),
                        ),
                        child: const StyledText(text: 'Extra'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
