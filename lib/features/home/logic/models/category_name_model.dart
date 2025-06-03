import 'package:flutter/material.dart';

class CategoryNameModel{
  final String name;
  final IconData icon;

  CategoryNameModel({required this.name, required this.icon});


}
List<CategoryNameModel> categoryNames = [
  CategoryNameModel(name: 'Sports', icon: Icons.sports_basketball),
  CategoryNameModel(name: 'Electronics', icon: Icons.laptop),
  CategoryNameModel(name: 'Collections', icon: Icons.collections),
  CategoryNameModel(name: 'Book', icon: Icons.book),
  CategoryNameModel(name: 'Game', icon: Icons.games_outlined),
  CategoryNameModel(name: 'Bikes', icon: Icons.bike_scooter),
];