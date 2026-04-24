import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Food App',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        useMaterial3: true, 
      ),
      home: HomeScreen(),
    );
  }
}

// ================= 1. HOME SCREEN =================
class HomeScreen extends StatelessWidget {
  final List<Map<String, String>> foods = [
    {"name": "Burger", "emoji": "🍔", "price": "15\$", "desc": "Juicy beef burger with cheese"},
    {"name": "Pizza", "emoji": "🍕", "price": "25\$", "desc": "Italian pizza with pepperoni"},
    {"name": "Shawarma", "emoji": "🌯", "price": "10\$", "desc": "Delicious chicken shawarma"},
    {"name": "Juice", "emoji": "🥤", "price": "5\$", "desc": "Fresh natural orange juice"},
    {"name": "Pasta", "emoji": "🍝", "price": "18\$", "desc": "Creamy white sauce pasta"},
    {"name": "Zinger", "emoji": "🥪", "price": "12\$", "desc": "Spicy crispy chicken zinger"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Food Menu", style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: foods.length,
          itemBuilder: (context, index) {
            return Card(
              elevation: 4,
              margin: EdgeInsets.symmetric(vertical: 8),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              child: ListTile(
                contentPadding: EdgeInsets.all(10),
                leading: CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.orange.withOpacity(0.2),
                  child: Text(foods[index]["emoji"]!, style: TextStyle(fontSize: 30)),
                ),
                title: Text(foods[index]["name"]!, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                subtitle: Text("Special Offer! Click for details"),
                trailing: Icon(Icons.arrow_forward_ios, color: Colors.orange),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailsScreen(food: foods[index]),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

class DetailsScreen extends StatelessWidget {
  final Map<String, String> food;

  DetailsScreen({required this.food});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(food["name"]!),
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(food["emoji"]!, style: TextStyle(fontSize: 100)),
            SizedBox(height: 20),
            Text(food["name"]!, style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                food["desc"]!, 
                textAlign: TextAlign.center, 
                style: TextStyle(fontSize: 18, color: Colors.grey[600]),
              ),
            ),
            Text(
              food["price"]!, 
              style: TextStyle(fontSize: 24, color: Colors.green, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pop(context);

               
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Success! ${food["name"]} added to cart"),
                    backgroundColor: Colors.green,
                    duration: Duration(seconds: 2),
                    behavior: SnackBarBehavior.floating, 
                  ),
                );
              },
              icon: Icon(Icons.shopping_cart),
              label: Text("Order Now"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ),
    );
  }
}