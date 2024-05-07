import 'package:flutter/material.dart';
import 'recipe.dart'; // Import the Recipe class

class RecipeDetailsPage extends StatelessWidget {
  final Recipe recipe;

  RecipeDetailsPage({required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(recipe.title), // Use the title property of the recipe
      ),
      body: ListView(
        children: [
          Image.network(recipe.image), // Display the image
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Ingredients:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                for (var ingredient in recipe.ingredients)
                  Text('- $ingredient'),
                SizedBox(height: 16),
                Text(
                  'Instructions:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(recipe
                    .directions), // Use the directions property of the recipe
                SizedBox(height: 16),
                Text(
                  'Nutritional Facts:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(recipe
                    .total_time), // Use the total_time property of the recipe
                Text(
                    recipe.calories), // Use the calories property of the recipe
                Text(recipe
                    .carbohydrates_g), // Use the carbohydrates_g property of the recipe
                Text(
                    recipe.sugars_g), // Use the sugars_g property of the recipe
                Text(recipe.fat_g), // Use the fat_g property of the recipe
                Text(recipe
                    .protein_g), // Use the protein_g property of the recipe
                SizedBox(height: 16),
                Text(
                  'Reviews:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                // Add a ListView.builder here if you have a list of reviews
                // For example:
                // ListView.builder(
                //   shrinkWrap: true,
                //   itemCount: recipe.reviews.length,
                //   itemBuilder: (context, index) {
                //     return ListTile(
                //       title: Text(recipe.reviews[index]),
                //     );
                //   },
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
