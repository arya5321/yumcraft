import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'recipe.dart'; // Assuming Recipe class is defined in recipe.dart
import 'recipe_details_page.dart'; // Import the updated RecipeDetailsPage

class RecipeListPage extends StatefulWidget {
  final String? dishName;
  final String? ingredients;

  RecipeListPage({this.dishName, this.ingredients});

  @override
  _RecipeListPageState createState() => _RecipeListPageState();
}

class _RecipeListPageState extends State<RecipeListPage> {
  List<Recipe> recipes = [];

  @override
  void initState() {
    super.initState();
    fetchRecipes();
  }

  Future<void> fetchRecipes() async {
    final response = await http.get(
      Uri.parse(
          'http://127.0.0.1:3000/get_dish?dishName=${widget.dishName ?? ''}'),
    );

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      setState(() {
        recipes = data.map((e) => Recipe.fromJson(e)).toList();
      });
    } else {
      throw Exception('Failed to load recipes');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recipes'),
      ),
      body: ListView.builder(
        itemCount: recipes.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(recipes[index].title),
            leading: Image.network(recipes[index].image),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      RecipeDetailsPage(recipe: recipes[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
