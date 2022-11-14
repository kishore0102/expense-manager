import 'package:expense/Transaction.dart';
import 'package:expense/transactionService.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class AddTransaction extends StatefulWidget {
  const AddTransaction({Key? key}) : super(key: key);

  @override
  State<AddTransaction> createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  var _categoryController = TextEditingController();
  var _noteController = TextEditingController();
  var _amountController = TextEditingController();
  var _activityTimeController = TextEditingController();

  bool _validateCategory = false;
  bool _validateNote = false;
  bool _validateAmount = false;

  String? type = "expense";
  String? activity_time = DateFormat('yyyy-MM-dd').format(DateTime.now());
  String? activity_time_full = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());

  var transactionSerivce = TransactionService();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Expense Tracker"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Add New Transaction',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.teal,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  RadioListTile(
                      title: Text("Expense"),
                      value: "expense", 
                      selected: true,
                      groupValue: type, 
                      onChanged: (value){
                        setState(() {
                            type = value.toString();
                        });
                      },
                  ),
                  RadioListTile(
                      title: Text("Income"),
                      value: "income", 
                      groupValue: type, 
                      onChanged: (value){
                        setState(() {
                            type = value.toString();
                        });
                      },
                  ),
                ]
              ),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                  controller: _categoryController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Groceries, Clothing, etc...',
                    labelText: 'Category',
                    errorText:
                        _validateCategory ? 'Value Can\'t Be Empty' : null,
                  )),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                  controller: _noteController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'What did you spend for ?',
                    labelText: 'Note',
                  )),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                  controller: _amountController,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  // inputFormatters: <TextInputFormatter>[
                  //   FilteringTextInputFormatter.allow(RegExp(r'^\D+|(?<=\d),(?=\d)')),
                  // ],
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'How much did you spend ?',
                    labelText: 'Amount',
                    errorText: _validateAmount ? 'Value Can\'t Be Empty' : null,
                  )),
              const SizedBox(
                height: 20.0,
              ),
              
              TextField(
                controller: TextEditingController(text: activity_time),
                decoration: const InputDecoration(
                    icon: Icon(Icons.calendar_today),
                    labelText: "Activity Date"
                ),
                readOnly: true,
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1950),
                    lastDate: DateTime(2100)
                  );
                  if (pickedDate != null) {
                    String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                    setState(() {
                      activity_time = formattedDate;
                    });
                  }
                },
              ),

              TextField(
                controller: TextEditingController(text: activity_time_full),
                decoration: const InputDecoration(
                    icon: Icon(Icons.calendar_today),
                    labelText: "Activity Date"
                ),
                readOnly: true,
                onTap: () async {
                  DatePicker.showDateTimePicker(context, showTitleActions: true,
                  onChanged: (pickedDate) {
                    setState(() {
                      activity_time_full = DateFormat('yyyy-MM-dd HH:mm:ss').format(pickedDate);
                    });
                  },
                  currentTime: DateTime.now());
                },
              ),

              const SizedBox(
                height: 20.0,
              ),
              Row(
                children: [
                  TextButton(
                      style: TextButton.styleFrom(
                          primary: Colors.white,
                          backgroundColor: Colors.teal,
                          textStyle: const TextStyle(fontSize: 15)),
                      onPressed: () async {
                        if (_categoryController.text.isEmpty) {
                          setState(() {
                            _validateCategory = true;
                          });
                        }
                        if (_amountController.text.isEmpty) {
                          setState(() {
                            _validateAmount = true;
                          });
                        }

                        if (_validateCategory == false && _validateAmount == false) {
                          var transaction = Transaction();
                          transaction.category = _categoryController.text;
                          transaction.note = _noteController.text;
                          transaction.amount = double.parse(_amountController.text);
                          transaction.type = type;
                          transaction.activity_time = activity_time_full;
                          print("saving transaction - ${transaction.transactionMap()}");
                          var result = await transactionSerivce.save(transaction);
                          print('result');
                          print(result);
                          Navigator.pop(context, result);
                        }
                      },
                      child: const Text('Save')),
                  const SizedBox(
                    width: 10.0,
                  ),
                  TextButton(
                      style: TextButton.styleFrom(
                          primary: Colors.white,
                          backgroundColor: Colors.red,
                          textStyle: const TextStyle(fontSize: 15)),
                      onPressed: () {
                        setState(() {
                          type = "expense";
                          _categoryController.text = "";
                          _amountController.text = "";
                          _noteController.text = "";
                          activity_time = DateFormat('yyyy-MM-dd').format(DateTime.now());
                        });
                      },
                      child: const Text('Clear'))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
