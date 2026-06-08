class Meal {
  final String id;
  final String name;
  final String thumbnail;
  final String category;
  final String area;
  final String instructions;
  final String youtubeUrl;
  final List<String> ingredients;

  Meal({
    required this.id,
    required this.name,
    required this.thumbnail,
    this.category = '',
    this.area = '',
    this.instructions = '',
    this.youtubeUrl = '',
    this.ingredients = const [],
  });

  factory Meal.fromJson(Map<String, dynamic> json) {
    List<String> parsedIngredients = [];
    for (int i = 1; i <= 20; i++) {
      final ingredient = json['strIngredient$i'];
      final measure = json['strMeasure$i'];

      if (ingredient != null && ingredient.toString().trim().isNotEmpty) {
        final measureText = (measure != null && measure.toString().trim().isNotEmpty)
            ? '$measure - '
            : '';
        parsedIngredients.add('$measureText$ingredient');
      }
    }

    return Meal(
      id: json['idMeal'] ?? '',
      name: json['strMeal'] ?? '',
      thumbnail: json['strMealThumb'] ?? '',
      category: json['strCategory'] ?? '',
      area: json['strArea'] ?? '',
      instructions: json['strInstructions'] ?? '',
      youtubeUrl: json['strYoutube'] ?? '',
      ingredients: parsedIngredients,
    );
  }
}