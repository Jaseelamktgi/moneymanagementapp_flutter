import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:moneymanagementapp_flutter/Core/Colors.dart';
import 'package:moneymanagementapp_flutter/db/Profile/Register_db.dart';


class RegistrationPage extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: defaultColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
            height: MediaQuery.of(context).size.height,
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
                      'Register',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          backgroundColor: defaultColor,
                          color: whiteText),
                    )
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      InputTextField('Name', nameController),
                      SizedBox(
                        height: 15,
                      ),
                      InputTextField('Username', usernameController),
                      SizedBox(
                        height: 15,
                      ),
                      InputTextField('Email', emailController),
                      SizedBox(
                        height: 15,
                      ),
                      InputTextField('Password', passwordController,
                          isObscure: true),
                      SizedBox(
                        height: 15,
                      ),
                      InputTextField(
                          'Confirm Password', confirmPasswordController,
                          isObscure: true),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        width: 60,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            onSubmit(
                                nameController.text,
                                usernameController.text,
                                emailController.text,
                                passwordController.text,
                                confirmPasswordController.text);
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
                            'Register',
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
        ),
      ),
    );
  }

  Widget InputTextField(String labelText, TextEditingController controller,
      {bool isObscure = false}) {
    return Column(
      children: [
        Container(
          height: 60,
          width: 300,
          child: TextFormField(
            controller: controller,
            // keyboardType: TextInputType.emailAddress,
            obscureText: isObscure,
            decoration: InputDecoration(
              fillColor: whiteText,
              labelText: labelText,
              labelStyle: TextStyle(color: whiteText, fontSize: 18),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: whiteText),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: whiteText),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red),
              ),
            ),
            style: TextStyle(color: whiteText, fontSize: 18),
          ),
        ),
      ],
    );
  }
}
