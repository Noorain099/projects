
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

final  uuid = Uuid();
final formatter = DateFormat.yMd();

enum Category { food, travel, leisure, work, }

const categoryIcons = {
  Category.food : Icons.lunch_dining,
  Category.leisure : Icons.movie_sharp,
  Category.travel : Icons.flight_takeoff,
  Category.work : Icons.work
};

class ExpenseData {
  final String title;
  final double amount;
  final String id;
  final DateTime date;
  final Category category;


  ExpenseData({ 
    required this.category,
    required this.title, 
    required this.amount, 
    required this.date}): id = uuid.v4();

    String get formattedDate {
          return formatter.format(date);
    }
}

