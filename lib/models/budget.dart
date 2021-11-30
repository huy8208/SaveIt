// To parse this JSON data, do
//
//     final budget = budgetFromJson(jsonString);

import 'dart:convert';

Budget budgetFromJson(String str) => Budget.fromJson(json.decode(str));

String budgetToJson(Budget data) => json.encode(data.toJson());

class Budget {
  Budget({
    required this.budgets,
  });

  List<BudgetElement> budgets;

  factory Budget.fromJson(Map<String, dynamic> json) => Budget(
        budgets: List<BudgetElement>.from(
            json["budgets"].map((x) => BudgetElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "budgets": List<dynamic>.from(budgets.map((x) => x.toJson())),
      };
}

class BudgetElement {
  BudgetElement({
    required this.name,
    required this.price,
    required this.labelPercentage,
    required this.percentage,
    required this.color,
    required this.total,
  });

  String name;
  int price;
  String labelPercentage;
  double percentage;
  String color;
  int total;

  factory BudgetElement.fromJson(Map<String, dynamic> json) => BudgetElement(
        name: json["name"],
        price: json["price"],
        labelPercentage: json["label_percentage"],
        percentage: json["percentage"].toDouble(),
        color: json["color"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "price": price,
        "label_percentage": labelPercentage,
        "percentage": percentage,
        "color": color,
        "total": total,
      };
}
