import 'package:hive/hive.dart';
    part 'Profile_model.g.dart';
@HiveType(typeId: 0)
class UserProfile {
  @HiveField(0)
  late String name;

  @HiveField(1)
  late String username;

  @HiveField(2)
  late String email;

  @HiveField(3)
  late String password;

  UserProfile({
    required this.name,
    required this.username,
    required this.email,
    required this.password,
  });
}

