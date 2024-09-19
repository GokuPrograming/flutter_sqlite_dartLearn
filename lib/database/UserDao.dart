import 'package:movieapp/database/database_herper.dart';
import 'package:movieapp/model/user_model.dart';
import 'package:sqflite/sqflite.dart';

/// Esta clase es para acceder a los métodos relacionados con la tabla 'users'
class UserDao {
  // Accede a la instancia de la base de datos
  Future<Database> get database async => await DatabaseHelper.instance.db;

  /// Lee todos los usuarios de la base de datos
  Future<List<UserModel>> readAll() async {
    final db = await database; // Espera a que la base de datos esté lista
    final List<Map<String, dynamic>> data = await db.query('users');
    return data.map((e) => UserModel.fromMap(e)).toList();
  }

  /// Inserta un nuevo usuario en la base de datos
  Future<int> insert(UserModel user) async {
    final db = await database; // Espera a que la base de datos esté lista
    return await db.insert('users', user.toMap());
  }

  /// Actualiza un usuario existente en la base de datos
  Future<void> update(UserModel user) async {
    final db = await database; // Espera a que la base de datos esté lista
    await db.update(
      'users',
      user.toMap(),
      where: 'id = ?',
      whereArgs: [user.id],
    );
  }

  /// Elimina un usuario de la base de datos
  Future<void> delete(UserModel user) async {
    final db = await database; // Espera a que la base de datos esté lista
    await db.delete(
      'users',
      where: 'id = ?',
      whereArgs: [user.id],
    );
  }
}
