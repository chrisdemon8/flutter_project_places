import 'dart:math';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_place/models/unusualspot.dart';

class CreatePlacePage extends StatefulWidget {
  const CreatePlacePage({Key? key}) : super(key: key);

  @override
  State<CreatePlacePage> createState() => _CreatePlacePageState();
}

class _CreatePlacePageState extends State<CreatePlacePage> {
  int _counter = 0;

  //final place = new UnusualSpot();
  final _controllerDescription = TextEditingController();
  final _controllerName = TextEditingController();
  final _controllerCountry = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _incrementCounter() {
    DatabaseReference _testRef = FirebaseDatabase.instance.ref().child("test");
    _testRef.set("Hello wold ${Random().nextInt(100)}");
    setState(() {
      _counter++;
    });
  }

  void _savePlace() {
    String name = _controllerName.text;
    String description = _controllerDescription.text;
    String country = _controllerCountry.text;

    Map<String, String> place = {
      'name': name,
      'country': country,
      'description': description
    };

    DatabaseReference _testRef =
        FirebaseDatabase.instance.ref().child("places");
    _testRef.push().set(place).then((value) => null);
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _controllerDescription.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("test"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child: TextFormField(
                    controller: _controllerName,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Nom du lieux insolite',
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child: TextFormField(
                    controller: _controllerCountry,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Pays du lieux insolite',
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child: TextFormField(
                    controller: _controllerDescription,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Description du lieux insolite',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: ElevatedButton(
                    onPressed: () {
                      // Validate returns true if the form is valid, or false otherwise.
                      if (_formKey.currentState!.validate()) {
                        // If the form is valid, display a snackbar. In the real world,
                        // you'd often call a server or save the information in a database.
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text("Lieu ajouté avec succès")),
                        );
                        _savePlace();
                        Navigator.pop(context);
                      }
                    },
                    child: const Text('Submit'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.*/
    );
  }
}