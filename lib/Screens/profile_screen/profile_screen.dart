import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:moneymanagementapp_flutter/Core/Colors.dart';
import 'package:moneymanagementapp_flutter/Model/Profile/Profile_model.dart';

class ProfileScreen extends StatefulWidget {
  @override
  ProfileScreenState createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
  late UserProfile _userProfile;

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  Future<void> _loadUserProfile() async {
    final userBox = await Hive.openBox<UserProfile>('user_profiles');
    if (userBox.isNotEmpty) {
      _userProfile = userBox.getAt(0)!;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: defaultColor,
                toolbarHeight: 100.0,
        title: Text(
          'Profile Details',
          style: TextStyle(color: whiteText),
        ),
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30.0),
            bottomRight: Radius.circular(30.0),
            topLeft: Radius.circular(5.0),
            topRight: Radius.circular(5.0),
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                shadowColor: defaultColor,
                color: whiteText,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                elevation: 1,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 60,
                        backgroundImage:
                            AssetImage('assets/images/person1.png'),
                      ),
                      SizedBox(height: 16),
                      Text(
                        _userProfile.name,
                        style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: defaultColor),
                      ),
                      SizedBox(height: 16),
                      _buildDetailItem('Email', _userProfile.email,Icons.alternate_email),
                      _buildDetailItem('Username', _userProfile.username,Icons.person),
                      _buildDetailItem('Password', '* * * *',Icons.password
                          // _userProfile
                          //     .password
                          ), // You might not want to display the actual password
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailItem(String label, String value,IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 10),
      child: Card(
        elevation: 5,
        child: ListTile(
          leading:Icon(icon),
           
          title:  Row(
            children: [
              Text(
              '$label:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: defaultColor,
              ),
             ),
             SizedBox(width: 10,),
              Text(
                  value,
                  style: TextStyle(
                      fontSize: 16, color: greyText, fontWeight: FontWeight.bold),
                ),
            ],
          ),
        ),
      ),
      
    );
  }
}
