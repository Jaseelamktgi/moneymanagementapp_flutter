import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moneymanagementapp_flutter/Core/Colors.dart';


class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30,),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ImageFolder(assetName: 'mask_group.png',),
                  const SizedBox(
                    height: 30,
                  ),
                  const Text(
                    textAlign:TextAlign.center,
                    'Spend Smarter Save More',
                    style: TextStyle(
                      
                        fontSize: 36,
                        color: defaultColor,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        Get.toNamed('/register');
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: defaultColor,
                          minimumSize:const Size(300, 50),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30))),
                      child: const Text('Get Started', style: TextStyle(color: whiteText))),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Already have an account?',
                        
                      ),
                      TextButton(
                          onPressed: () {
                            Get.toNamed('/login');
                          },
                          child: const Text(
                            'Log In',
                            style: TextStyle(
                              color: defaultColor,
                            ),
                          ))
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ImageFolder extends StatelessWidget {
  const ImageFolder({
    super.key, required this.assetName,
  });

final String assetName;

  @override
  Widget build(BuildContext context) {
    return Image.asset('assets/images/${assetName}');
  }
}
