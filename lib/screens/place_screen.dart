import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_place/models/unusualspot.dart';

class PlacePage extends StatefulWidget {
  const PlacePage(this.placeId, {Key? key}) : super(key: key);

  final String placeId;
  @override
  State<PlacePage> createState() => _PlacePageState();
}

class _PlacePageState extends State<PlacePage> {
  _readPlace() async {
    DatabaseReference _testRef =
        FirebaseDatabase.instance.ref().child("places");

    DatabaseEvent event = await _testRef.child(widget.placeId).once();

    DataSnapshot snapshot = event.snapshot;
    Map place = snapshot.value as Map;

    UnusualSpot placeObject = UnusualSpot(
        id: place["key"],
        name: place["name"],
        description: place["description"],
        images: [],
        country: place["country"],
        rating: "");

    print(placeObject.name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.placeId),
      ),
      body: const SingleChildScrollView(
        child: Center(
          child: Text("Test"),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _readPlace();
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.add),
      ),
    );
  }
}
