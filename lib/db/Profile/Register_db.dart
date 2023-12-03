import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:moneymanagementapp_flutter/Core/Colors.dart';
import 'package:moneymanagementapp_flutter/Model/Profile/Profile_model.dart';

Future<void> onSubmit(
    String nameController,
    String usernameController,
    String emailController,
    String passwordController,
    String confirmPasswordController) async {
  {
    if (nameController.isEmpty ||
        usernameController.isEmpty ||
        passwordController.isEmpty ||
        confirmPasswordController.isEmpty) {
      _showError('All fields must be filled');
      return;
    }
    if (passwordController != confirmPasswordController) {
      _showError('Password and confirm password do not match');
      return;
    }

    try {
      UserProfile userProfile = UserProfile(
        name: nameController,
        username: usernameController,
        email: emailController,
        password: passwordController,
      );

      print(nameController);
      print(userProfile);

      final userDataBox = await Hive.openBox<UserProfile>('user_profiles');
      int addedIndex = await userDataBox.add(userProfile);
      await userDataBox.close();

      if (addedIndex != -1) {
        print(
            'User profile added successfully at index $addedIndex: $userProfile');
        Get.toNamed('/login');
      } else {
        print('Failed to add user profile');
      }
    } catch (e) {
      print('Error adding user profile: $e');
      _showError('Error adding user profile');
    }
  }
}

void _showError(String errorMessage) {
  Get.snackbar(
    "Error",
    errorMessage,
    backgroundColor: warning,
    colorText: whiteText,
  );
}
