import 'dart:io';

import 'package:flutter/material.dart';
import 'package:movieapp/database/UserDao.dart';
import 'package:movieapp/model/user_model.dart';
import 'package:backdrop_modal_route/backdrop_modal_route.dart';

class Main extends StatefulWidget {
  const Main({super.key});

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  ///se necesita un controlador para la caja de texto
  final TextEditingController _controllerInsertarUsuario =
      TextEditingController();
  //se hace una instancia a la clase de user
  final UserDao _userDao = UserDao();
  //se crea una lista, para poder almacenar los usuarios
  List<UserModel> _usuarios = [];

  @override
  void initState() {
    super.initState();
    _loadUsuarios();

    ///carga los usuarios de una sola vez
  }

  /// se guarda dentro de una lista gracias al metodo
  Future<void> _loadUsuarios() async {
    final usuarios = await _userDao.readAll();
    setState(() {
      _usuarios = usuarios;
    });
  }

  ///agregar usuarios
  Future<void> _addUsuario() async {
    final nombre = _controllerInsertarUsuario.text;
    final imagen = '';
    if (nombre.isNotEmpty) {
      final user = UserModel(name: nombre, imagen: imagen);
      await _userDao.insert(user);
      _controllerInsertarUsuario.clear();
      _loadUsuarios(); // Actualiza la lista de usuarios
    }
  }

  Future<void> _deleteUser(id) async {
    print(id);
    final user = UserModel.delete(id: id);
    await _userDao.delete(user);
    _loadUsuarios();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Usando SQLite'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(
                      label: Text('Ingrese usuario'),
                    ),
                    controller: _controllerInsertarUsuario,
                  ),
                ),
                IconButton(
                  onPressed: _addUsuario,
                  icon: const Icon(Icons.add),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              'Lista de elementos:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _usuarios.length,
                itemBuilder: (context, index) {
                  final usuario = _usuarios[index];
                  return ListTile(
                    title: Text(usuario.name),
                    onTap: () {
                      Navigator.push(
                        context,
                        BackdropModalRoute<void>(
                          backgroundColor: Color.fromARGB(255, 0, 0, 0),
                          overlayContentBuilder: (context) {
                            return Container(
                              height:
                                  MediaQuery.of(context).size.height - 100.0,
                              alignment: Alignment.center,
                              padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text('Infomracion personal'),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextField(
                                      // controller: _controllerCorreo,
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText: 'ingresa correo',
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextField(
                                      // controller: _controllerName,
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText: 'ingresa nombre',
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextField(
                                      // controller: _controllerGitHub,
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText:
                                            'ingresa Link De Perfil GitHub',
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextField(
                                      // controller: _controllerTelNumber,
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText: 'Numero de Telefono',
                                      ),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      ElevatedButton(
                                        onPressed: () {
                                          setState(() {
                                            // correo = _controllerCorreo.text;
                                            // nombreUsuario = _controllerName.text;
                                            // Github =
                                            //     Uri.parse(_controllerGitHub.text);
                                            // numeroTel = _controllerTelNumber.text;
                                          });
                                          Navigator.pop(context);
                                        },
                                        child: Text('Guardar Cambios'),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text('Cancelar'),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      );
                    },
                    // leading: Image.file(
                    //   File(
                    //       'usuario.imagen'), // Mostrar imagen desde archivo local
                    //   width: 50, // Ajusta el tamaño de la imagen
                    //   height: 50,
                    //   fit:
                    //       BoxFit.cover, // Ajusta el tamaño y forma de la imagen
                    // ),
                    trailing: IconButton(
                        onPressed: () {
                          _deleteUser(usuario.id);
                        },
                        icon: Icon(Icons.delete)),
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
