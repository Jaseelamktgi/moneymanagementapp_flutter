import 'package:hive_flutter/hive_flutter.dart';
part 'Category_model.g.dart';

//Enumerator treating as another table in Hive
//________________Enumerators_______________
@HiveType(typeId: 2)
enum CategoryType {
  @HiveField(0)
  income,

  @HiveField(1)
  expense,
}

//_______________CategoryModel______________
@HiveType(typeId: 1)
class CategoryModel {
  @HiveField(0)
  final id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final bool isDeleted;

  @HiveField(3)
  final CategoryType type;
  
  //______________CategoryModel Constructor___________  ___
  CategoryModel(
      {required this.id,
      required this.name,
      this.isDeleted = false,
      required this.type});

  @override
  String toString() {
    return '{$name $type}';
  }
}
