import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/favorites_provider.dart';
import '../widgets/meal_card.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favorites = context.watch<FavoritesProvider>().favorites;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mes favoris'),
      ),
      body: SafeArea(
        child: favorites.isEmpty
            ? Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Aucun favori pour le moment.'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Découvrir des recettes'),
              ),
            ],
          ),
        )
            : GridView.builder(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0, bottom: 32.0),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.8,
          ),
          itemCount: favorites.length,
          itemBuilder: (context, index) {
            final meal = favorites[index];
            return Dismissible(
              key: Key(meal.id),
              direction: DismissDirection.horizontal,
              onDismissed: (direction) {
                context.read<FavoritesProvider>().toggleFavorite(meal);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Retiré des favoris'),
                    duration: Duration(seconds: 1),
                  ),
                );
              },
              background: Container(
                color: Colors.red,
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: const Icon(Icons.delete, color: Colors.white),
              ),
              child: MealCard(meal: meal),
            );
          },
        ),
      ),
    );
  }
}