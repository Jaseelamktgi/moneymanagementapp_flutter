import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:moneymanagementapp_flutter/Core/Colors.dart';
import 'package:moneymanagementapp_flutter/Model/Category/Category_model.dart';
import 'package:moneymanagementapp_flutter/Model/Transaction/Transaction_model.dart';
import 'package:moneymanagementapp_flutter/Screens/Transactions/Widgets/appbar.dart';
import 'package:moneymanagementapp_flutter/db/Category/Category_db.dart';
import 'package:moneymanagementapp_flutter/db/Transaction/Transaction_db.dart';

class TransactionScreen extends StatelessWidget {
  const TransactionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TransactionDB.instance.refresh();
    CategoryDB.instance.refreshUI();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: defaultColor,
        toolbarHeight: 150.0,
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30.0),
            bottomRight: Radius.circular(30.0),
            topLeft: Radius.circular(5.0),
                        topRight: Radius.circular(5.0),

          ),
        ),
        flexibleSpace: PreferredSizeWidgetExample(),
      ),
      body: ValueListenableBuilder(
          valueListenable: TransactionDB.instance.transactionListNotifier,
          builder:
              (BuildContext cntx, List<TransactionModel> newList, Widget? _) {
            return ListView.separated(
                padding: EdgeInsets.all(10),
                itemBuilder: (cntx, index) {
                  final value = newList[index];
                  final _date = DateFormat('ddMMM y').format(value.date);
                  print('valueeee ${value}');
                  return Slidable(
                    startActionPane:
                        ActionPane(motion: ScrollMotion(), children: [
                      SlidableAction(
                        onPressed: (cntx) {
                          TransactionDB.instance.deleteTransaction(value.id!);
                        },
                        icon: Icons.delete,
                        label: 'Delete',
                      )
                    ]),
                    child: Card(
                      color: whiteText,
                      shadowColor: defaultColor,
                      elevation: 5,
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: ListTile(
                          leading: CircleAvatar(
                            child: Text(
                              'Rs\n${value.amount}',
                              style: TextStyle(color: whiteText, fontSize: 12),
                              textAlign: TextAlign.center,
                            ),
                            radius: 30,
                            backgroundColor: value.type == CategoryType.income
                                ? defaultColor
                                : warning,
                          ),
                          title: Text(
                            '${value.category.name}',
                            style: TextStyle(
                                color: defaultColor,
                                fontWeight: FontWeight.w600),
                          ),
                          subtitle: Text(
                            '${_date}',
                            style: TextStyle(
                                color: greyText, fontWeight: FontWeight.w600),
                          ),
                          trailing: IconButton(
                            onPressed: () {
                              TransactionDB.instance
                                  .deleteTransaction(value.id.toString());
                            },
                            icon: Icon(
                              Icons.delete,
                              color: greyText,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return SizedBox(height: 10);
                },
                itemCount: newList.length);
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed('/add_transaction');
        },
        child: Icon(Icons.add, color: whiteText),
        backgroundColor: defaultColor,
      ),
    );
  }
  
}

