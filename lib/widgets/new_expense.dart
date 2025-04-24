import 'package:expensetracker/model/expense_data.dart';
import 'package:flutter/material.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});

  final void Function(ExpenseData expense) onAddExpense;

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
 
//   var _enteredTitle = "";
// void _saveTitleInput (String inputalue){
//   _enteredTitle = inputalue;
// }

final _titleController = TextEditingController();
final _amountController = TextEditingController();
DateTime? _selectedDate ;
Category  _selectedCategory = Category.leisure;


void _submitData(){
  final enteredAmount = double.tryParse(_amountController.text);
  final amountIsInvalid = enteredAmount == null || enteredAmount <= 0;
  if(_titleController.text.trim().isEmpty || amountIsInvalid || _selectedDate == null){
      showDialog(context: context, builder: (ctx) => AlertDialog(
        title: Text("Invalid Input"),
        content: Text("Please make sure you entered everything correctly!!"),
        actions: [
          TextButton(onPressed: (){
            Navigator.pop(ctx);
          }, child: Text("Okay!")
          ),
        ],
      ));
      return;
  }
  widget.onAddExpense(
    ExpenseData(
      category: _selectedCategory, 
      title: _titleController.text, 
      amount: enteredAmount, 
      date: _selectedDate!
      )
    );
    Navigator.pop(context);
}


void _datePicker () async{
  final now = DateTime.now();
  final firstDate = DateTime(now.year -1,now.month,now.day);
  
    final pickedDate = await showDatePicker(
      context: context, 
      initialDate: now,
      firstDate: firstDate , 
      lastDate: now,
      );
      setState(() {
        _selectedDate = pickedDate;
      });
}


@override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.fromLTRB(16, 20,16 , 16),
    child: Column(
      children: [
        TextField(
          //onChanged: _saveTitleInput,
          controller: _titleController,
          maxLength: 50,
          decoration: InputDecoration(
            
            label: Text("Title")
          ),
        ),
        Row(
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: TextField(
                //onChanged: _saveTitleInput,
                keyboardType: TextInputType.number,
                controller: _amountController,
                
                decoration: InputDecoration(
                  prefixText:'\$',
                  label: Text("Amount")
                ),
              ),
            ),
            SizedBox(width: 20,),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
              Text(_selectedDate  == null ?"No date Selected": formatter.format(_selectedDate!)),
              IconButton(
                onPressed: _datePicker,
                icon: Icon(Icons.calendar_month))
            ],))
          ],
        ),
        SizedBox(height: 16,),
        Row(
          children: [
            
            DropdownButton(
              value: _selectedCategory,
              items: Category.values.map(
                (category) => DropdownMenuItem(
                  value: category,
                  child: Text(category.name.toUpperCase(),
                  ))).toList(), 
                  onChanged: (value){
                    if(value == null){
                        return;
                      }
                    setState(() {  
                      _selectedCategory = value;
                    });
                    print(value);
                  }),
                  Spacer(),
            TextButton(onPressed: (){
                Navigator.pop(context);
            }, 
            child: Text("Cancel")),
            ElevatedButton(
              onPressed: _submitData,
            child: Text("Save expense"))
          ],
        )
      ],
    ),);
  }
}