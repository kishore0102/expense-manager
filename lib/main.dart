import 'dart:ffi';

import 'package:expense/Transaction.dart';
import 'package:expense/add_transaction.dart';
import 'package:expense/transactionService.dart';
import 'package:expense/view_transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'edit_transaction.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Expense Tracker",
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List<Transaction> transactionList = <Transaction>[];
  double income = 0;
  double expense = 0;
  final transactionService = TransactionService();

  refreshMainPage() async {
    var transactions = await transactionService.readAllTransactions();
    print("all transactions = " + transactions.toString());
    List<Transaction> outputList = <Transaction>[];
    transactions.forEach((transaction) {
      var transactionModel = Transaction();
      transactionModel.id = transaction['id'];
      transactionModel.category = transaction['category'];
      transactionModel.note = transaction['note'];
      transactionModel.amount = transaction['amount'];
      transactionModel.type = transaction['type'];
      transactionModel.activity_time = transaction['activity_time'];
      transactionModel.created_time = transaction['created_time'];
      transactionModel.modified_time = transaction['modified_time'];
      outputList.add(transactionModel);
    });

    double _income = await transactionService.calculateIncomeForCurrentMonth();
    double _expense = await transactionService.calculateExpenseForCurrentMonth();
    
    print('----------------------------------------------------');
    print('transaction list size = ${this.transactionList.length}');
    print('income');
    print(_income);
    print('expense');
    print(_expense);
    print('----------------------------------------------------');

    setState(() {
      transactionList = outputList;
      income = _income;
      expense = _expense;
    });

  }

  @override
  void initState() {
    refreshMainPage();
    super.initState();
  }

  _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  _deleteFormDialog(BuildContext context, id) {
    return showDialog(
        context: context,
        builder: (param) {
          return AlertDialog(
            title: const Text(
              'Are You Sure to Delete ?',
              style: TextStyle(color: Colors.teal, fontSize: 20),
            ),
            actions: [
              TextButton(
                  style: TextButton.styleFrom(
                      primary: Colors.white, // foreground
                      backgroundColor: Colors.red),
                  onPressed: ()  async{
                     var result = await transactionService.deleteTransactionById(id);
                     if (result != null) {
                       Navigator.pop(context);
                       refreshMainPage();
                       _showSuccessSnackBar(
                           'Transaction deleted successfully');
                     }
                  },
                  child: const Text('Delete')),
              TextButton(
                  style: TextButton.styleFrom(
                      primary: Colors.white, // foreground
                      backgroundColor: Colors.teal),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Close'))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Expense Tracker"),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          const SizedBox(
            height: 5.0,
          ),
          Card(
              child: ListTile(
                title: Text("Expense = $expense"),
                subtitle: Text("Income = $income"),
              ),
            ),
          const SizedBox(
            height: 5.0,
          ),
          Expanded(
            child: ListView.builder(
          itemCount: transactionList.length,
          itemBuilder: (context, index) {
            String title1 = transactionList[index].category ?? '';
            String title2 = transactionList[index].note ?? 'No note...';
            String title = (title1 == '' ? '' : '$title1 - ') + title2;
            return Card(
              child: ListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ViewTransaction(
                              transaction: transactionList[index],
                            )));
                },
                leading: const Icon(Icons.list),
                title: Text(title),
                subtitle: Text(transactionList[index].amount.toString()),

                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                        onPressed: () {
                          print('edit button pressed');
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => EditTransaction(
                          //               transaction: transactionList[index],
                          //             ))).then((data) {
                          //   if (data != null) {
                          //     refreshMainPage();
                          //     _showSuccessSnackBar(
                          //         'Transaction updated successfully...');
                          //   }
                          // });
                        },
                        icon: const Icon(
                          Icons.edit,
                          color: Colors.teal,
                        )),
                    IconButton(
                        onPressed: () {
                          _deleteFormDialog(context, transactionList[index].id);
                          refreshMainPage();
                        },
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ))
                  ],
                ),
              ),
            );
          }),
          ),
        ],
      ),   
    floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Transaction transaction = new Transaction();
          // transaction.category = "category";
          // transaction.note = "note";
          // transaction.amount = 15.50;
          // transaction.type = "expense";
          // transaction.activity_time = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
          // transactionService.save(transaction);
          // refreshMainPage();
          // _showSuccessSnackBar('Transaction added successfully...');

          Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const AddTransaction()))
              .then((data) {
            if (data != null) {
              refreshMainPage();
              _showSuccessSnackBar('Transaction added successfully...');
            } else {
              _showSuccessSnackBar('Error occured while adding the transaction...');
            }
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }

}
