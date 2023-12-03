import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:moneymanagementapp_flutter/Model/Transaction/Transaction_model.dart';

const TRANSACTION_DB_NAME = 'transaction_db';

abstract class CategoryDbFunctions {
  Future<void> addTransaction(TransactionModel value);
  Future<List<TransactionModel>> getAllTransactions();
  Future<void> deleteTransaction(String transactionId);
}

class TransactionDB implements CategoryDbFunctions {
  TransactionDB._internal(); //named constructor
  static TransactionDB instance = TransactionDB._internal();

  factory TransactionDB() {
    return instance;
  }

  ValueNotifier<List<TransactionModel>> transactionListNotifier =
      ValueNotifier([]);

  @override
  Future<void> addTransaction(TransactionModel value) async {
    final _transactionDB =
        await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    await _transactionDB.put(value.id, value);
  }

  Future<void> refresh() async {
    final transactionList = await getAllTransactions();
    transactionList.sort((first, second) => second.date.compareTo(first.date));
    transactionListNotifier.value.clear();
    transactionListNotifier.value.addAll(transactionList);
    transactionListNotifier.notifyListeners();
  }

  @override
  Future<List<TransactionModel>> getAllTransactions() async {
    final _transactionDB =
        await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    return _transactionDB.values.toList();
  }

  @override
  Future<void> deleteTransaction(String transactionId) async {
    final _categoryDB =
        await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    await _categoryDB.delete(transactionId);
    refresh();
  }

  Future<Map<String, double>> calculateTotals() async {
    double totalIncome = 0.0;
    double totalExpense = 0.0;

    final transactions = await TransactionDB.instance.getAllTransactions();

    for (var transaction in transactions) {
      print(transaction.type);
      if (transaction.type=='Income') {
        totalIncome += transaction.amount;
        print('Income $totalIncome');
      } else {
        totalExpense += transaction.amount;
          print('Expense $totalExpense');
      }
    }

    double totalBalance = totalIncome - totalExpense;

    return {
      'totalIncome': totalIncome,
      'totalExpense': totalExpense,
      'totalBalance': totalBalance,
    };
  }
}
