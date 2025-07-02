import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shopping List',
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _itemController = TextEditingController(); // controller for item
  final TextEditingController _qtyController = TextEditingController(); // controller for qty
  final List<String> _items = []; // list to hold items

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping List'), // title
      ),
      body: Padding(
        padding: const EdgeInsets.all(8), // small padding around content
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _itemController,
                    decoration: const InputDecoration(
                      hintText: 'Item', // placeholder text
                      border: OutlineInputBorder(), // simple border
                    ),
                  ),
                ),
                SizedBox(width: 8), // simple space between fields
                Expanded(
                  child: TextField(
                    controller: _qtyController,
                    decoration: const InputDecoration(
                      hintText: 'Qty', // placeholder for qty
                      border: OutlineInputBorder(), // simple border
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
                SizedBox(width: 8), // simple space before button
                ElevatedButton(
                  onPressed: () {
                    String item = _itemController.text;
                    String qty = _qtyController.text;
                    if (item != '' && qty != '') {
                      setState(() {
                        _items.add('$item  quantity: $qty');
                        _itemController.clear();
                        _qtyController.clear();
                      });
                    }
                  },
                  child: const Text('Add'),
                ),
              ],
            ),
            Expanded(
              child: _items.isEmpty
                  ? const Center(child: Text('There are no items in the list'))
                  : ListView.builder(
                itemCount: _items.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onLongPress: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Delete this item?'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    _items.removeAt(index);
                                  });
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Yes'),
                              ),
                              TextButton(
                                onPressed: () {
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
                      title: Text('${index + 1}: ${_items[index]}'),

                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
