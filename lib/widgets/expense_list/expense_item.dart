import 'package:expensetracker/model/expense_data.dart';
import 'package:flutter/material.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem( this.expense,{super.key, });
  final ExpenseData expense;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 16
      ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(expense.title,style: Theme.of(context).textTheme.titleLarge),
              SizedBox(height: 6,),
              Row(
                children: [
                  Text('\$ ${expense.amount.toStringAsFixed(2)}'),
                  const Spacer(),
                  Row(
                    children: [
                        Icon(categoryIcons[Category.food]),
                        SizedBox(width: 10,),
                        Text(expense.formattedDate)
                    ],
                  )
                  ],
              )
            ],
          ),
        ),
      ),
    );
  }
}