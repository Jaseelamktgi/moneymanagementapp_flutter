import 'package:flutter/material.dart';
import 'package:moneymanagementapp_flutter/Core/Colors.dart';
import 'package:moneymanagementapp_flutter/Model/Category/Category_model.dart';
import 'package:moneymanagementapp_flutter/db/Category/Category_db.dart';

ValueNotifier<CategoryType> selectedCategoryNotifier =
    ValueNotifier(CategoryType.income);

final _categoryNameController = TextEditingController();

Future<void> showCategoryAddPopup(BuildContext context) async {
  showDialog(
      context: context,
      builder: (cntx) {
        return SimpleDialog(
          title: Text(
            'Add Category',
            style: TextStyle(color: defaultColor, fontWeight: FontWeight.w600),
          ),
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextFormField(
                cursorColor: defaultColor,
                controller: _categoryNameController,
                decoration: InputDecoration(
                  labelText: 'Category Name',
                  labelStyle: TextStyle(color: greyText),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: defaultColor),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: greyText),
                  ),
                  border: OutlineInputBorder(),
                ),
                style: TextStyle(color: defaultColor),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  RadioButton(title: 'Income', type: CategoryType.income),
                  RadioButton(title: 'Expense', type: CategoryType.expense),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  onPressed: () {
                    final _categoryName = _categoryNameController.text;
                    if (_categoryName.isEmpty) {
                      return;
                    }
                    final _type = selectedCategoryNotifier.value;
                    final _category = CategoryModel(
                        id: DateTime.now().millisecondsSinceEpoch.toString(),
                        name: _categoryName,
                        type: _type);

                    print(_category);
                    CategoryDB.instance.insertCategory(_category);
                    Navigator.of(cntx).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: defaultColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  child: Text(
                    'Add',
                    style: TextStyle(color: whiteText),
                  )),
            )
          ],
        );
      });
}

class RadioButton extends StatelessWidget {
  final String title;
  final CategoryType type;

  const RadioButton({super.key, required this.title, required this.type});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ValueListenableBuilder(
            valueListenable: selectedCategoryNotifier,
            builder: (BuildContext cntx, CategoryType newCategory, Widget? _) {
              return Radio<CategoryType>(
                value: type,
                activeColor: defaultColor,
                groupValue: newCategory,
                onChanged: (value) {
                  if (value == null) {
                    return;
                  }
                  selectedCategoryNotifier.value = value;
                  selectedCategoryNotifier.notifyListeners();
                },
              );
            }),
        Text(
          title,
          style: TextStyle(color: defaultColor),
        ),
      ],
    );
  }
}
