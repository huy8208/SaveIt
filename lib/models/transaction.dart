import 'package:flutter/material.dart';

class TransactionModel {
  final IconData icon;
  final String description;
  final String category;
  final String price;
  final String date;

  TransactionModel({
    required this.icon,
    required this.description,
    required this.category,
    required this.price,
    required this.date,
  });
}

var testData = [
  TransactionModel(
      icon: Icons.search,
      description: "Haiwaii",
      category: "Banana",
      price: "\$300",
      date: "sun 06"),
  TransactionModel(
      icon: Icons.search,
      description: "Haiwaii",
      category: "Banana",
      price: "\$300",
      date: "sun 06"),
  TransactionModel(
      icon: Icons.search,
      description: "Haiwaii",
      category: "Banana",
      price: "\$300",
      date: "sun 06")
];
