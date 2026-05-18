import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/meal.dart';
import '../providers/favorites_provider.dart';
import '../widgets/meal_card.dart';
import 'favorites_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static final List<Meal> _mockMeals = [
    Meal(id: '1', name: 'Lasagne', thumbnail: 'https://www.themealdb.com/images/media/meals/w18ki11628773321.jpg'),
    Meal(id: '2', name: 'Poutine', thumbnail: 'https://www.themealdb.com/images/media/meals/ypxpwv1568161514.jpg'),
    Meal(id: '3', name: 'Sushi', thumbnail: 'https://www.themealdb.com/images/media/meals/g046bb1663960946.jpg'),
    Meal(id: '4', name: 'Tacos', thumbnail: 'https://www.themealdb.com/images/media/meals/uvuyxu1503067369.jpg'),
    Meal(id: '5', name: 'Burger', thumbnail: 'https://www.themealdb.com/images/media/meals/lrstqq1529445310.jpg'),
    Meal(id: '6', name: 'Crepes', thumbnail: 'https://www.themealdb.com/images/media/meals/9f47121683206412.jpg'),
  ];

  @override
  Widget build(BuildContext context) {
    final favoriteCount = context.watch<FavoritesProvider>().favorites.length;

    return Scaffold(
      appBar: AppBar(
        title: const Text('MealMate'),
        actions: [
          IconButton(
            icon: Badge(
              label: Text('$favoriteCount'),
              isLabelVisible: favoriteCount > 0,
              child: const Icon(Icons.favorite),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const FavoritesScreen()),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {},
          ),
        ],
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(8.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.8,
        ),
        itemCount: _mockMeals.length,
        itemBuilder: (context, index) {
          return MealCard(meal: _mockMeals[index]);
        },
      ),
    );
  }
}