import 'package:flutter/material.dart';
import 'package:moneymanagementapp_flutter/Core/Colors.dart';
import 'package:moneymanagementapp_flutter/Model/Category/Category_model.dart';
import 'package:moneymanagementapp_flutter/db/Category/Category_db.dart';

class IncomeCategoryList extends StatelessWidget {
  const IncomeCategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: CategoryDB().incomeCategoryListListener,
        builder: (BuildContext cntx, List<CategoryModel> newList, Widget? _) {
          return ListView.separated(
              itemBuilder: (cntx, index) {
                final category = newList[index];
                return Card(
                  elevation: 3,
                  shadowColor: greyText,
                  color: whiteText,
                  child: ListTile(
                    title: Text(category.name,
                        style: TextStyle(
                            color:defaultColor, fontWeight: FontWeight.w500)),
                    trailing: IconButton(
                      onPressed: () {
                        CategoryDB.instance.deleteCategory(category.id);
                      },
                      icon: Icon(
                        Icons.delete,
                        color: greyText,
                      ),
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return SizedBox(height: 10);
              },
              itemCount: newList.length);
        });
  }
}
