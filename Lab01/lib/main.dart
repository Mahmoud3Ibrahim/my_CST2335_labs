import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,

      ),
      home: MyHomePage(title: 'Browse Page'), // ← ربط الصفحة هنا
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
      child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          "BROWSE CATEGORIES",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 40.0),
        ),
        Text(
          "Not sure about exactly which recipe you're looking for? Do a search, or dive into our most popular categories.",
          textAlign: TextAlign.start,
        ),
        Text(
          "By Meat",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 25 , fontWeight: FontWeight.bold  ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                CircleAvatar(
                    backgroundImage: AssetImage('images/beef.jpeg'), radius: 50),
                Text("beef",
                    style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20,
                      shadows: [ Shadow (color: Colors.black , offset: Offset(0, 0))],),),
              ],
            ),
            Stack(
              alignment: Alignment.center,
              children: [
                CircleAvatar(
                    backgroundImage: AssetImage('images/Chicken.jpg'),
                    radius: 50),
                Text("Chicken",
                    style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20,
                      shadows: [ Shadow (color: Colors.black , offset: Offset(0, 0))],),),
              ],
            ),
            Stack(
              alignment: Alignment.center,
              children: [
                CircleAvatar(
                    backgroundImage: AssetImage('images/pork.jpg'), radius: 50),
                Text("bork",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20, shadows: [ Shadow (color: Colors.black)],),),
              ],
            ),
            Stack(
              alignment: Alignment.center,
              children: [
                CircleAvatar(
                    backgroundImage: AssetImage('images/Seafood.jpg'),
                    radius: 50),
                Text("seafood",
                    style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20, shadows: [ Shadow (color: Colors.black)],),),
              ],
            ),
          ],
        ),
        SizedBox(height: 20),
        Text(
          "By Course",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 25 , fontWeight: FontWeight.bold  ),
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                CircleAvatar(
                    backgroundImage: AssetImage('images/MainDishes.jpg'),
                    radius: 50),
                Text("Main Dishes"),
              ],
            ),
            Column(
              children: [
                CircleAvatar(
                    backgroundImage: AssetImage('images/Salad.jpg'), radius: 50),
                Text("Salad"),
              ],
            ),
            Column(
              children: [
                CircleAvatar(
                    backgroundImage: AssetImage('images/SlideDishes.jpg'),
                    radius: 50),
                Text("Side Dishes"),
              ],
            ),
            Column(
              children: [
                CircleAvatar(
                    backgroundImage: AssetImage('images/Crockpot.jpg'),
                    radius: 50),
                Text("Crockpot"),
              ],
            ),
          ],
        ),
        SizedBox(height: 20),
        Text(
          "By Dessert",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 25 , fontWeight: FontWeight.bold  ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                CircleAvatar(
                    backgroundImage: AssetImage('images/iceCream.jpg'),
                    radius: 50),
                Text("ice Cream"),
              ],
            ),
            Column(
              children: [
                CircleAvatar(
                    backgroundImage: AssetImage('images/Brownies.jpg'), radius: 50),
                Text("Brownies"),
              ],
            ),
            Column(
              children: [
                CircleAvatar(
                    backgroundImage: AssetImage('images/Pies.jpg'),
                    radius: 50),
                Text("Pies"),
              ],
            ),
            Column(
              children: [
                CircleAvatar(
                    backgroundImage: AssetImage('images/Cookies.jpg'),
                    radius: 50),
                Text("Cookies"),
              ],
            ),
          ],
        ),
      ],
    ),
    ),
    );
  }
  }

