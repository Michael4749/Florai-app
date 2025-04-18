import 'package:postgres/postgres.dart';
import 'dart:developer';

class DataBase {

  // Constructor with named parameters
  DataBase({
    this.name,
    required this.email,
    required this.password,
    this.id,
  });

  final int? id;
  final String? name;
  final String email;
  final String password;

  PostgreSQLConnection? _connection;

  Future<void> connection() async {
    // Initialize the database connection
    _connection = PostgreSQLConnection(
      'switchyard.proxy.rlwy.net', // host
      56856, // port
      'railway', // database name
      username: 'postgres',
      password: 'RFZfFTNbQfIjNWYxTWNsGlJqfzjocEdZ',
    );

    try {
      // Open the connection
      await _connection!.open();

      // Get the table name based on the flavor

      // Create the tables
      await createTables();

      // Insert the user data
      await insertUserData();

    } catch (e) {
      log("Error connecting to the database: $e");
    } finally {
      // Ensure the connection is closed
      await _connection?.close();
    }
  }

  Future<void> createTables() async {
    try {
      // List of tables to create

      if (email.isEmpty && password.isEmpty) {
        _connection = PostgreSQLConnection(
          'switchyard.proxy.rlwy.net', // host
          56856, // port
          'railway', // database name
          username: 'postgres',
          password: 'RFZfFTNbQfIjNWYxTWNsGlJqfzjocEdZ',
        );
        await _connection!.open();
      }

      // Iterate through each table and create if not exists
      await _connection!.query(
        'CREATE TABLE IF NOT EXISTS users (id SERIAL PRIMARY KEY, username TEXT NOT NULL CHECK (LENGTH(username) >= 3), email TEXT UNIQUE NOT NULL, user_password TEXT NOT NULL,plants TEXT[])',
      );
      log("tables created successfully");
    } catch (e) {
      log("Error creating tables: $e");
    } finally {
      if (email.isEmpty && password.isEmpty) {
        await _connection?.close();
      }
    }
  }

  Future<void> insertUserData() async {

    
    try {
      // Check if the user already exists
      List<List<dynamic>> result;
      if (id != null) {
        result = await _connection!.query(
          'SELECT * FROM users WHERE id = @id',
          substitutionValues: {'id': id},
        );
      } else {
        result = await _connection!.query(
          'SELECT * FROM users WHERE email = @email',
          substitutionValues: {'email': email},
        );
      }

      // If the user doesn't exist, insert new data
      if (result.isEmpty) {
        await _connection!.query(
          'INSERT INTO users (username, email, user_password, plants) VALUES (@name, @email, @password, @plants)',
          substitutionValues: {
            'name': name,
            'email': email,
            'password': password,
            'plants': []
          },
        );
        log('User inserted successfully into table users.');
      } else {
        id != null
            ? log('User with ID $id already exists in table users.')
            : log('User with email $email already exists in table users.');
      }
    } catch (e) {
      log("Error inserting data into table users: $e");
    }
  }
}
