import 'package:flutter/material.dart';
import '../models/meal.dart';

class FavoritesProvider extends ChangeNotifier {
  final List<Meal> _favorites = [];

  List<Meal> get favorites => _favorites;

  void toggleFavorite(Meal meal) {
    final isExist = _favorites.any((item) => item.id == meal.id);
    if (isExist) {
      _favorites.removeWhere((item) => item.id == meal.id);
    } else {
      _favorites.add(meal);
    }
    notifyListeners(); 
  }

  bool isFavorite(Meal meal) {
    return _favorites.any((item) => item.id == meal.id);
  }
}