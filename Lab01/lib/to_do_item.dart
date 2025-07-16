import 'package:floor/floor.dart';

// This class is the data model. Each object will be a row in the database.
@entity
class ToDoItem {
  @PrimaryKey(autoGenerate: true)
  final int? id; // Primary key

  final String name; // Name of the item
  final String qty; // Quantity of the item

  ToDoItem({this.id, required this.name, required this.qty});
}
