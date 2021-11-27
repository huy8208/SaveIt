
import 'dart:convert';
import 'dart:core';
import 'package:get/get.dart';

class budget {
  List<Budgets> budgets;

  budget({this.budgets});

  budget.fromJson(Map<String, dynamic> json) {
    if (json['budgets'] != null) {
      budgets = new List<Budgets>();
      json['budgets'].forEach((v) {
        budgets.add(new Budgets.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.budgets != null) {
      data['budgets'] = this.budgets.map((v) => v.toJson()).toList();
    }
    return data;
  }

  void main(){
    
    Budgets budgets = Budgets.fromJson(jsonDecode(budget));
    print(budgets);
  }
}

class Budgets {
  String name;
  double price;
  String labelPercentage;
  double percentage;
  String color;
  int total;

  Budgets(
      {this.name,
      this.price,
      this.labelPercentage,
      this.percentage,
      this.color,
      this.total});

  Budgets.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    price = json['price'];
    labelPercentage = json['label_percentage'];
    percentage = json['percentage'];
    color = json['color'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['price'] = this.price;
    data['label_percentage'] = this.labelPercentage;
    data['percentage'] = this.percentage;
    data['color'] = this.color;
    data['total'] = this.total;
    return data;
  }
}
