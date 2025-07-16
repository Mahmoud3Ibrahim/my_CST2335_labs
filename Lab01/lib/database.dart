import 'dart:async';
import 'package:floor/floor.dart';
import 'to_do_item.dart'; // Import the model
import 'to_do_dao.dart'; // Import the DAO
import 'package:sqflite/sqflite.dart' as sqflite;

part 'database.g.dart'; // Generated code will go here

// This is the main database class
@Database(version: 1, entities: [ToDoItem])
abstract class AppDatabase extends FloorDatabase {
  ToDoDao get toDoDao; // We use this to talk to the database
}
