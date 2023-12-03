import 'package:flutter/material.dart';
import 'package:moneymanagementapp_flutter/Core/Colors.dart';
import 'package:moneymanagementapp_flutter/Model/Category/Category_model.dart';
import 'package:moneymanagementapp_flutter/Model/Transaction/Transaction_model.dart';
import 'package:moneymanagementapp_flutter/db/Category/Category_db.dart';
import 'package:moneymanagementapp_flutter/db/Transaction/Transaction_db.dart';

class AddTransaction extends StatefulWidget {
  const AddTransaction({super.key});

  @override
  State<AddTransaction> createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  DateTime? selectedDate;
  CategoryType? selectedCategoryType;
  CategoryModel? selectedCategoryModel;
  String? CategoryID;

  final purposeEditingController = TextEditingController();
  final amountEditingController = TextEditingController();

  @override
  void initState() {
    selectedCategoryType = CategoryType.income;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: defaultColor,
                automaticallyImplyLeading: false,
                centerTitle: true,
        title: Text('Add Transaction',style: TextStyle(color: whiteText),),
      ),
      body: SingleChildScrollView(
        child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            cursorColor: defaultColor,
            controller: purposeEditingController,
            keyboardType: TextInputType.text,
            style: const TextStyle(
              color: defaultColor,
            ),
            decoration: InputDecoration(
              labelText: 'Purpose',
              labelStyle: const TextStyle(
                color: defaultColor,
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: defaultColor),
              ),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            cursorColor: defaultColor,
            controller: amountEditingController,
            keyboardType: TextInputType.number,
            style: const TextStyle(
              color: defaultColor,
            ),
            decoration: InputDecoration(
              labelText: 'Amount',
              labelStyle: const TextStyle(
                color: defaultColor,
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: defaultColor),
              ),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: TextButton.icon(
                onPressed: () async {
                  final selecteddateTemp = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now().subtract(Duration(days: 30)),
                      lastDate: DateTime.now());
                  if (selecteddateTemp == null) {
                    return;
                  } else {
                    print(selecteddateTemp.toString());
                    setState(() {
                      selectedDate = selecteddateTemp;
                    });
                  }
                },
                icon: Icon(
                  Icons.calendar_today,
                  color: defaultColor,
                ),
                label: Text(
                  selectedDate == null
                      ? 'Select Date'
                      : selectedDate!.toString(),
                  style: TextStyle(color: defaultColor),
                )),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  Radio(
                      value: CategoryType.income,
                      activeColor: defaultColor,
                      groupValue: selectedCategoryType,
                      onChanged: (newValue) {
                        setState(() {
                          selectedCategoryType = CategoryType.income;
                          CategoryID = null;
                        });
                      }),
                  Text('Income', style: TextStyle(color: defaultColor)),
                ],
              ),
              SizedBox(
                width: 50,
              ),
              Row(
                children: [
                  Radio(
                      value: CategoryType.expense,
                      activeColor: defaultColor,
                      groupValue: selectedCategoryType,
                      onChanged: (newValue) {
                        setState(() {
                          selectedCategoryType = CategoryType.expense;
                          CategoryID = null;
                        });
                      }),
                  Text(
                    'Expense',
                    style: TextStyle(color: defaultColor),
                  ),
                ],
              ),
            ],
          ),
          DropdownButtonFormField(
            iconEnabledColor: defaultColor,
            hint: Text(
              'Select Category',
              style: TextStyle(color: defaultColor),
            ),
            value: CategoryID,
            items: (selectedCategoryType == CategoryType.income
                    ? CategoryDB.instance.incomeCategoryListListener.value
                    : CategoryDB.instance.expenseCategoryListListener.value)
                .map((e) {
              return DropdownMenuItem(
                child: Text(e.name, style: TextStyle(color: defaultColor)),
                value: e.id,
                onTap: () {
                  print(e.toString());
                  selectedCategoryModel = e;
                },
              );
            }).toList(),
            onChanged: (selectedValue) {
              print(selectedValue);
              setState(() {
                print(selectedValue);
                CategoryID = selectedValue.toString();
              });
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: defaultColor),
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Center(
            child: Container(
              height: 50.0,
              width: 250.0,
              child: ElevatedButton(
                onPressed: () async {
                  await addTransaction();
                  print('pressed');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: defaultColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                child: Text(
                  'Add Transaction',
                  style: TextStyle(color: whiteText),
                ),
              ),
            ),
          )
        ],
                ),
              ),
      ),
    );
  }

  Future<void> addTransaction() async {
    final purposeText = purposeEditingController.text;
    final amountText = amountEditingController.text;
    if (purposeText.isEmpty || amountText.isEmpty) {
      return;
    }
    if (selectedCategoryModel == null || selectedDate == null) {
      return;
    }
    try {
      final parsedAmount = double.tryParse(amountText);

      if (parsedAmount == null) {
        print('Invalid amount: $amountText');
        return;
      }
      

      final _model = TransactionModel(
          purpose: purposeText,
          amount: parsedAmount!,
          date: selectedDate!,
          type: selectedCategoryType!,
          category: selectedCategoryModel!);

      await TransactionDB.instance.addTransaction(_model);
    } catch (err) {
      print('Error creating TransactionModel: $err');
    }

    Navigator.of(context).pop();
    TransactionDB.instance.refresh();
  }
}
