import 'package:flutter/material.dart';

class UserModel {
  final int? id; // El ID puede ser nullable
  final String name;
  final String?
      imagen; // `imagen` es nullable, lo que significa que puede ser null

  // Constructor principal
  UserModel({this.id, required this.name, this.imagen});

  // Constructor alternativo para "delete", donde solo el ID es necesario
  UserModel.delete({this.id})
      : name = '', // Asignar un valor por defecto para `name`
        imagen = null; // `imagen` puede ser null, no se asigna una cadena vacía

  // Método para copiar el objeto con valores opcionales
  UserModel Agregar({int? id, String? name, String? imagen}) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      imagen: imagen ?? this.imagen, // Validar correctamente imagen nullable
    );
  }

  // Constructor de fábrica para crear una instancia de UserModel desde un Map
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] as int?,
      name: map['name'] as String,
      imagen: map['imagen']
          as String?, // `imagen` puede ser nullable, cambiar a String?
    );
  }

  // Método para convertir UserModel a un Map
  Map<String, dynamic> toMap() {
    return {
      'id': id, // `id` es nullable
      'name': name,
      'imagen':
          imagen, // No hace falta inicializar si es null, ya está manejado
    };
  }
}
