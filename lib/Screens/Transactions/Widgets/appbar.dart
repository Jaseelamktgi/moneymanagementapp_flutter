import 'package:flutter/material.dart';
import 'package:moneymanagementapp_flutter/Core/Colors.dart';
import 'package:moneymanagementapp_flutter/db/Category/Category_db.dart';
import 'package:moneymanagementapp_flutter/db/Transaction/Transaction_db.dart';

class PreferredSizeWidgetExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, double>>(
        future: TransactionDB.instance.calculateTotals(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // If the Future is still running, show a loading indicator
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            // If there's an error, display an error message
            return Text('Error: ${snapshot.error}');
          } else {
            // If the Future is complete, build the UI with the data
            double totalIncome = snapshot.data?['totalIncome'] ?? 0.0;
            double totalExpense = snapshot.data?['totalExpense'] ?? 0.0;
            double totalBalance = snapshot.data?['totalBalance'] ?? 0.0;
// Get total income, total expense, and total balance
            // double totalIncome = transactionDB.getTotalIncome();
            // double totalExpense = transactionDB.getTotalExpense();
            // double totalBalance = transactionDB.getTotalBalance();

            return Container(
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    'Total Balance',
                    style: TextStyle(
                        color: whiteText,
                        fontWeight: FontWeight.w700,
                        fontSize: 18),
                  ),
                  Text(
                    '\$ ${totalBalance.toStringAsFixed(2)}',
                    style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: whiteText),
                  ),
                  SizedBox(height: 15.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        padding: EdgeInsets.all(5),
                        width: 120.0,
                        height: 60.0,
                        decoration: BoxDecoration(
                          color: whiteText,
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Column(
                          children: [
                            Text(
                              'Income',
                              style: TextStyle(color: defaultColor),
                            ),
                            Text(
                              '\$ $totalIncome',
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(5),
                        width: 120.0,
                        height: 60.0,
                        decoration: BoxDecoration(
                          color: whiteText,
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Column(
                          children: [
                            Text('Expense',
                                style: TextStyle(color: defaultColor)),
                            Text(
                              '\$${totalExpense}',
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }
        });
  }
}
