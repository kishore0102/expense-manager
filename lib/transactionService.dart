import 'package:expense/Transaction.dart';
import 'package:expense/transactions_repo.dart';

import 'DateUtils.dart';

class TransactionService {

  final String table = 'transactions';  
  late TransactionsRepo transactionsRepo;

  TransactionService() {
    transactionsRepo = TransactionsRepo();
  }

  // read all records
  readAllTransactions() async {
    return await transactionsRepo.readAllData(table);
  }

  // calculate income for current month
  calculateIncomeForCurrentMonth() async {
    var currentYearMonth = DateUtils.currentDateToStringInYearMonth();
    return await transactionsRepo.calculateAmountSumForMonth(table, currentYearMonth, 'income');
  }

  // calculate income for current month
  calculateExpenseForCurrentMonth() async {
    var currentYearMonth = DateUtils.currentDateToStringInYearMonth();
    return await transactionsRepo.calculateAmountSumForMonth(table, currentYearMonth, 'expense');
  }

  //Read a Single Record By ID
  readTransactionById(id) async {
    return await transactionsRepo.readDataById(table, id);
  }

  //Read for a given month
  readTransactionForMonth(month) async {
    return await transactionsRepo.readDataByMonth(table, month);
  }

  //Read for the current month
  readTransactionForCurrentMonth() async {
    var currentYearMonth = DateUtils.currentDateToStringInYearMonth();
    return await transactionsRepo.readDataByMonth(table, currentYearMonth);
  }

  //Update Transaction
  updateTransaction(data) async {
    return await transactionsRepo.updateData(table, data);
  }

  //Delete Transaction
  deleteTransactionById(id) async {
    return await transactionsRepo.deleteDataById(table, id);
  }

  // save transaction
  save(Transaction transaction) async {
    return await transactionsRepo.insertData(table, transaction.transactionMap());
  }

}
