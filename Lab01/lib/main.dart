import 'package:flutter/material.dart';
import 'database.dart';
import 'to_do_item.dart';
import 'to_do_dao.dart';

void main() {
  runApp(const MyApp()); // Start the app
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shopping List',
      home: const MyHomePage(), // Go to home page
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _itemController = TextEditingController(); // Controller for item name
  final TextEditingController _qtyController = TextEditingController(); // Controller for quantity

  late AppDatabase database; // Our Floor database
  late ToDoDao dao; // Our DAO
  List<ToDoItem> _items = []; // List of items

  @override
  void initState() {
    super.initState();
    setupDatabase(); // Load data when app starts
  }

  Future<void> setupDatabase() async {
    database = await $FloorAppDatabase.databaseBuilder('todo.db').build(); // Create database
    dao = database.toDoDao; // Get DAO
    _items = await dao.findAllItems(); // Load saved items
    setState(() {});
  }

  @override
  void dispose() {
    _itemController.dispose(); // Clean up
    _qtyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping List'), // Title
      ),
      body: Padding(
        padding: const EdgeInsets.all(8), // Padding around content
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _itemController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: _qtyController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () async {
                    String item = _itemController.text;
                    String qty = _qtyController.text;
                    if (item.isNotEmpty && qty.isNotEmpty) {
                      final newItem = ToDoItem(name: item, qty: qty); // Create new item
                      await dao.insertItem(newItem); // Save to database
                      _items = await dao.findAllItems(); // Reload items
                      _itemController.clear(); // Clear input
                      _qtyController.clear();
                      setState(() {});
                    }
                  },
                  child: const Text('Add'), // Button text
                ),
              ],
            ),
            Expanded(
              child: Builder(
                builder: (context) {
                  // Check if the list is empty
                  if (_items.isEmpty) {
                    // Show a message in the center if there are no items
                    return const Center(
                      child: Text('There are no items in the list'),
                    );
                  } else {
                    // If there are items, display them in a scrollable list
                    return ListView.builder(
                      itemCount: _items.length, // Number of items to display
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onLongPress: () {
                            // Show a confirmation dialog when user long-presses an item
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text('Delete this item?'),
                                  actions: [
                                    TextButton(
                                      onPressed: () async {

                                        // Delete the item from the database
                                        await dao.deleteItem(_items[index]);

                                        // Reload the updated list of items
                                        _items = await dao.findAllItems();

                                        // Close the dialog
                                        Navigator.of(context).pop();

                                        // Update the screen with new list
                                        setState(() {});
                                      },
                                      child: const Text('Yes'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        // Close the dialog without doing anything
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('No'),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: ListTile(
                            // Show the item name and quantity with numbering
                            title: Text(
                              '${index + 1}: ${_items[index].name} - quantity: ${_items[index].qty}',
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
