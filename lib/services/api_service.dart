import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import '../models/category.dart';
import '../models/meal.dart';

class ApiService {
  static const String _baseUrl = 'https://www.themealdb.com/api/json/v1/1';

  Future<List<Category>> getCategories() async {
    try {
      final response = await http
          .get(Uri.parse('$_baseUrl/categories.php'))
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        final List categories = data['categories'] ?? [];
        return categories.map((json) => Category.fromJson(json)).toList();
      } else {
        throw Exception('Erreur serveur: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Impossible de charger les catégories. Vérifiez votre connexion.');
    }
  }

  Future<Meal?> getRandomMeal() async {
    try {
      final response = await http
          .get(Uri.parse('$_baseUrl/random.php'))
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        final List? meals = data['meals'];
        if (meals != null && meals.isNotEmpty) {
          return Meal.fromJson(meals[0]);
        }
        return null;
      } else {
        throw Exception('Erreur serveur: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Impossible de charger la recette aléatoire.');
    }
  }

  Future<List<Meal>> getMealsByCategory(String categoryName) async {
    try {
      final response = await http
          .get(Uri.parse('$_baseUrl/filter.php?c=$categoryName'))
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        final List meals = data['meals'] ?? [];
        return meals.map((json) => Meal.fromJson(json)).toList();
      } else {
        throw Exception('Erreur serveur: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Impossible de charger les recettes.');
    }
  }

  Future<List<Meal>> searchMeals(String query) async {
    try {
      final response = await http
          .get(Uri.parse('$_baseUrl/search.php?s=$query'))
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        final List meals = data['meals'] ?? [];
        return meals.map((json) => Meal.fromJson(json)).toList();
      } else {
        throw Exception('Erreur serveur: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Impossible d\'effectuer la recherche.');
    }
  }

  Future<Meal?> getMealById(String id) async {
    try {
      final response = await http
          .get(Uri.parse('$_baseUrl/lookup.php?i=$id'))
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        final List? meals = data['meals'];
        if (meals != null && meals.isNotEmpty) {
          return Meal.fromJson(meals[0]);
        }
        return null;
      } else {
        throw Exception('Erreur serveur: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Impossible de charger les détails de la recette.');
    }
  }
}