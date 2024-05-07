import 'package:flutter/material.dart';
import 'recipe.dart'; // Import the Recipe class
import 'recipe_list_page.dart'; // Import the RecipeListPage
import 'recipe_details_page.dart'; // Import the RecipeDetailsPage

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final TextEditingController _dishNameController =
      TextEditingController();
  late final TextEditingController _ingredientsController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Discover Best Recipes'),
      ),
      body: HomePageContent(
        dishNameController: _dishNameController,
        ingredientsController: _ingredientsController,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
        ],
        currentIndex: 0,
        selectedItemColor: Colors.blue,
        onTap: (index) {},
      ),
    );
  }
}

class HomePageContent extends StatelessWidget {
  final TextEditingController? dishNameController;
  final TextEditingController? ingredientsController;

  const HomePageContent({
    Key? key,
    this.dishNameController,
    this.ingredientsController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: dishNameController,
            decoration: InputDecoration(hintText: 'Enter recipe name'),
            onSubmitted: (value) {
              if (dishNameController != null &&
                  dishNameController!.text.isNotEmpty) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RecipeListPage(dishName: value),
                  ),
                );
              }
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: ingredientsController,
            decoration: InputDecoration(hintText: 'Enter ingredients'),
            onSubmitted: (value) {
              List<Recipe> recipes = fetchRecipesForIngredients(value);
              if (recipes.isNotEmpty) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RecipeDetailsPage(recipe: recipes[0]),
                  ),
                );
              }
            },
          ),
        ),
        _buildCategory(
            context, 'Desserts', fetchRecipesForCategory('Desserts')),
        _buildCategory(
            context, 'Side Dishes', fetchRecipesForCategory('Side Dishes')),
        _buildCategory(
            context, 'Main Dishes', fetchRecipesForCategory('Main Dishes')),
      ],
    );
  }

  List<Recipe> fetchRecipesForIngredients(String ingredients) {
    // Implement your logic to fetch recipes based on available ingredients
    // For now, returning a dummy list
    return [
      Recipe(
          title: 'Recipe 1',
          ingredients: ['Ingredient A', 'Ingredient B'],
          directions: 'Instructions for Recipe 1',
          total_time: 'Unknown',
          image: 'https://via.placeholder.com/150',
          calories: 'Unknown',
          carbohydrates_g: 'Unknown',
          sugars_g: 'Unknown',
          fat_g: 'Unknown',
          protein_g: 'Unknown'),
      Recipe(
          title: 'Recipe 2',
          ingredients: ['Ingredient C', 'Ingredient D'],
          directions: 'Instructions for Recipe 2',
          total_time: 'Unknown',
          image: 'https://via.placeholder.com/150',
          calories: 'Unknown',
          carbohydrates_g: 'Unknown',
          sugars_g: 'Unknown',
          fat_g: 'Unknown',
          protein_g: 'Unknown'),
    ];
  }

  List<Recipe> fetchRecipesForCategory(String category) {
    // Implement your logic to fetch recipes for a specific category
    // For now, returning a dummy list
    return [
      Recipe(
        title: '$category Recipe 1',
        ingredients: ['Ingredient 1', 'Ingredient 2'],
        directions: 'Instructions for $category Recipe 1',
        total_time: 'Unknown',
        image: 'https://via.placeholder.com/150',
        calories: 'Unknown',
        carbohydrates_g: 'Unknown',
        sugars_g: 'Unknown',
        fat_g: 'Unknown',
        protein_g: 'Unknown',
      ),
      Recipe(
          title: '$category Recipe 2',
          ingredients: ['Ingredient 3', 'Ingredient 4'],
          directions: 'Instructions for $category Recipe 2',
          total_time: 'Unknown',
          image: 'https://via.placeholder.com/150',
          calories: 'Unknown',
          carbohydrates_g: 'Unknown',
          sugars_g: 'Unknown',
          fat_g: 'Unknown',
          protein_g: 'Unknown'),
    ];
  }

  Widget _buildCategory(
      BuildContext context, String category, List<Recipe> recipes) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            category,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          height: 200, // Adjust height as needed
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: recipes.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          RecipeDetailsPage(recipe: recipes[index]),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: 150, // Adjust width as needed
                        height: 150, // Adjust height as needed
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                            image: NetworkImage(recipes[index].image),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(recipes[index].title),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
