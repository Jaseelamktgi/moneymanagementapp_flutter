import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moneymanagementapp_flutter/Core/Colors.dart';
import 'package:moneymanagementapp_flutter/db/Profile/Login_db.dart';


class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: defaultColor,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: Icon(
                      Icons.arrow_back,
                      color: whiteText,
                    )),
                SizedBox(
                  width: 50,
                ),
                Text(
                  'Login',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      backgroundColor: defaultColor,
                      color: whiteText),
                )
              ],
            ),
            SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InputTextField('Email', emailController),
                  SizedBox(height: 16),
                  InputTextField('Password', passwordController,
                      isObscure: true),
                  SizedBox(height: 32),
                  Container(
                    width: 100,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        onLogin(emailController.text, passwordController.text);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: whiteText,
                        foregroundColor: defaultColor,
                        side: BorderSide(color: whiteText),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Text(
                        'Login',
                        style: TextStyle(
                            color: defaultColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 18),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget InputTextField(String labelText, TextEditingController controller,
      {bool isObscure = false}) {
    return Container(
      height: 70,
      width: 300,
      child: TextFormField(
        controller: controller,
        obscureText: isObscure,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: TextStyle(color: whiteText),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: whiteText),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: whiteText),
          ),
        ),
        style: TextStyle(color: whiteText, fontSize: 18),
      ),
    );
  }
}
