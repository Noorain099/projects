import 'package:expensetracker/widgets/expense_list/expenses_list.dart';
import 'package:expensetracker/model/expense_data.dart';
import 'package:expensetracker/widgets/new_expense.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
final List<ExpenseData> _registeredExpenses =[
  ExpenseData(
    category: Category.leisure, 
    title: "fh", 
    amount: 567, 
    date: DateTime.now(),
    ),

    ExpenseData(
    category: Category.food, 
    title: "fh", 
    amount: 567, 
    date: DateTime.now(),
    )
];

  void _openExpenseOverlay(){
    showModalBottomSheet(
      isScrollControlled: true,
      context: context, 
      builder: (ctx) =>  NewExpense(onAddExpense: _addExpense,));
  }
  void _addExpense(ExpenseData expense){
      setState(() {
        _registeredExpenses.add(expense);
      });
  }
  void _removeExpense(ExpenseData expense){
    final expenseIndex = _registeredExpenses.indexOf(expense);
      setState(() {
        _registeredExpenses.remove(expense);
      });
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: Duration(seconds: 2),
          content: Text("Expense Deleted..."),
          action: SnackBarAction(label: "Undo", onPressed: (){
            setState(() {
              _registeredExpenses.insert(expenseIndex, expense);
            });
          }),
          ),
        );

  }


  @override
  Widget build(BuildContext context) {
      Widget mainContent = Center(child: const Text("No Expenses found. Start adding some Expenses..."));
    if(_registeredExpenses.isNotEmpty){
          mainContent = ExpensesList(
                expenses: _registeredExpenses, 
                onRemoveExpense: _removeExpense,
                );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("Expenses"),
        actions: [
          IconButton(
            onPressed: 
            _openExpenseOverlay, 
            icon: Icon(Icons.add))
        ],
        //toolbarHeight: 10,
      ),
      body: Column(
        children: [
            
            Expanded(
              child: mainContent
              ),
        ],
      ),
    );
  }
}