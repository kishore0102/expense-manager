// import 'package:expense/Transaction.dart';
// import 'package:expense/transactionService.dart';
// import 'package:flutter/material.dart';

// class EditTransaction extends StatefulWidget {
//   final Transaction transaction;
//   const EditTransaction({Key? key, required this.transaction}) : super(key: key);

//   @override
//   State<EditTransaction> createState() => _EditTransactionState();
// }

// class _EditTransactionState extends State<EditTransaction> {
//   var _transactionCategoryController = TextEditingController();
//   var _transactionNoteController = TextEditingController();
//   var _transactionDescriptionController = TextEditingController();


//   bool _validateName = false;
//   bool _validateContact = false;
//   bool _validateDescription = false;
//   var _transactionService = TransactionService();

//   @override
//   void initState() {
//     setState(() {
//       _transactionNameController.text=widget.transaction.name??'';
//       _transactionContactController.text=widget.transaction.contact??'';
//       _transactionDescriptionController.text=widget.transaction.description??'';
//     });
//     super.initState();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("SQLite CRUD"),
//       ),
//       body: SingleChildScrollView(
//         child: Container(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Text(
//                 'Edit New transaction',
//                 style: TextStyle(
//                     fontSize: 20,
//                     color: Colors.teal,
//                     fontWeight: FontWeight.w500),
//               ),
//               const SizedBox(
//                 height: 20.0,
//               ),
//               TextField(
//                   controller: _transactionNameController,
//                   decoration: InputDecoration(
//                     border: const OutlineInputBorder(),
//                     hintText: 'Enter Name',
//                     labelText: 'Name',
//                     errorText:
//                     _validateName ? 'Name Value Can\'t Be Empty' : null,
//                   )),
//               const SizedBox(
//                 height: 20.0,
//               ),
//               TextField(
//                   controller: _transactionContactController,
//                   decoration: InputDecoration(
//                     border: const OutlineInputBorder(),
//                     hintText: 'Enter Contact',
//                     labelText: 'Contact',
//                     errorText: _validateContact
//                         ? 'Contact Value Can\'t Be Empty'
//                         : null,
//                   )),
//               const SizedBox(
//                 height: 20.0,
//               ),
//               TextField(
//                   controller: _transactionDescriptionController,
//                   decoration: InputDecoration(
//                     border: const OutlineInputBorder(),
//                     hintText: 'Enter Description',
//                     labelText: 'Description',
//                     errorText: _validateDescription
//                         ? 'Description Value Can\'t Be Empty'
//                         : null,
//                   )),
//               const SizedBox(
//                 height: 20.0,
//               ),
//               Row(
//                 children: [
//                   TextButton(
//                       style: TextButton.styleFrom(
//                           primary: Colors.white,
//                           backgroundColor: Colors.teal,
//                           textStyle: const TextStyle(fontSize: 15)),
//                       onPressed: () async {
//                         setState(() {
//                           _transactionNameController.text.isEmpty
//                               ? _validateName = true
//                               : _validateName = false;
//                           _transactionContactController.text.isEmpty
//                               ? _validateContact = true
//                               : _validateContact = false;
//                           _transactionDescriptionController.text.isEmpty
//                               ? _validateDescription = true
//                               : _validateDescription = false;

//                         });
//                         if (_validateName == false &&
//                             _validateContact == false &&
//                             _validateDescription == false) {
//                           // print("Good Data Can Save");
//                           var _transaction = transaction();
//                           _transaction.id=widget.transaction.id;
//                           _transaction.name = _transactionNameController.text;
//                           _transaction.contact = _transactionContactController.text;
//                           _transaction.description = _transactionDescriptionController.text;
//                           var result=await _transactionService.Updatetransaction(_transaction);
//                           Navigator.pop(context,result);
//                         }
//                       },
//                       child: const Text('Update Details')),
//                   const SizedBox(
//                     width: 10.0,
//                   ),
//                   TextButton(
//                       style: TextButton.styleFrom(
//                           primary: Colors.white,
//                           backgroundColor: Colors.red,
//                           textStyle: const TextStyle(fontSize: 15)),
//                       onPressed: () {
//                         _transactionNameController.text = '';
//                         _transactionContactController.text = '';
//                         _transactionDescriptionController.text = '';
//                       },
//                       child: const Text('Clear Details'))
//                 ],
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
