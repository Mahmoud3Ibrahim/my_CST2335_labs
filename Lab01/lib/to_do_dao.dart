import 'package:floor/floor.dart';
import 'to_do_item.dart';

// DAO = Data Access Object. This handles database operations.
@dao
abstract class ToDoDao {
  @Query('SELECT * FROM ToDoItem')
  Future<List<ToDoItem>> findAllItems(); // Get all items from the database

  @insert
  Future<void> insertItem(ToDoItem item); // Add an item to the database

  @delete
  Future<void> deleteItem(ToDoItem item); // Delete an item from the database
}
