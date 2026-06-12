import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/meal.dart';
import '../providers/favorites_provider.dart';
import '../services/api_service.dart';

class MealDetailScreen extends StatefulWidget {
  final Meal meal;

  const MealDetailScreen({super.key, required this.meal});

  @override
  State<MealDetailScreen> createState() => _MealDetailScreenState();
}

class _MealDetailScreenState extends State<MealDetailScreen> {
  final ApiService _apiService = ApiService();
  late Future<Meal?> _mealFuture;

  @override
  void initState() {
    super.initState();
    _mealFuture = _apiService.getMealById(widget.meal.id);
  }

  Future<void> _launchVideo(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Impossible d\'ouvrir la vidéo')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final favoritesProvider = context.watch<FavoritesProvider>();
    final isFav = favoritesProvider.isFavorite(widget.meal);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.meal.name),
        actions: [
          IconButton(
            icon: Icon(isFav ? Icons.favorite : Icons.favorite_border),
            color: isFav ? Colors.red : null,
            onPressed: () {
              context.read<FavoritesProvider>().toggleFavorite(widget.meal);
              ScaffoldMessenger.of(context).clearSnackBars();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(isFav ? 'Retiré des favoris' : 'Ajouté aux favoris'),
                  duration: const Duration(seconds: 1),
                ),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: FutureBuilder<Meal?>(
          future: _mealFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Erreur: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data == null) {
              return const Center(child: Text('Détails introuvables.'));
            }

            final fullMeal = snapshot.data!;
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Image.network(fullMeal.thumbnail, height: 250, fit: BoxFit.cover),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(fullMeal.name, style: Theme.of(context).textTheme.headlineMedium),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 8,
                          children: [
                            if (fullMeal.category.isNotEmpty) Chip(label: Text(fullMeal.category)),
                            if (fullMeal.area.isNotEmpty) Chip(label: Text(fullMeal.area)),
                          ],
                        ),
                        const SizedBox(height: 16),
                        if (fullMeal.youtubeUrl.isNotEmpty)
                          ElevatedButton.icon(
                            onPressed: () => _launchVideo(fullMeal.youtubeUrl),
                            icon: const Icon(Icons.play_arrow, color: Colors.white),
                            label: const Text('Voir la recette en vidéo', style: TextStyle(color: Colors.white)),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                            ),
                          ),
                        const SizedBox(height: 16),
                        Text('Ingrédients', style: Theme.of(context).textTheme.titleLarge),
                        const SizedBox(height: 8),
                        ...fullMeal.ingredients.map((ingredient) => Text('- $ingredient')),
                        const SizedBox(height: 16),
                        Text('Instructions', style: Theme.of(context).textTheme.titleLarge),
                        const SizedBox(height: 8),
                        Text(fullMeal.instructions),
                        const SizedBox(height: 32),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}