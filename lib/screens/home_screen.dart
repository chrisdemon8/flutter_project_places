import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_place/screens/add_place_screen.dart';
import 'package:flutter_application_place/screens/place_screen.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final Query _ref =
      FirebaseDatabase.instance.ref().child("places").orderByChild("name");

  List<String> savedFav = <String>[];
  @override
  void initState() {
    super.initState();
  }

  Widget _buildPlaceItem({required Map place}) {
    bool isSaved = savedFav.contains(place["key"]);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(10),
      color: Colors.white,
      child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PlacePage(place["key"])),
            );
          },
          child: ListTile(
            title: Text(place['name']),
            trailing: IconButton(
              icon: isSaved
                  ? const Icon(Icons.favorite)
                  : const Icon(Icons.favorite_border),
              color: isSaved ? Colors.red : null,
              onPressed: () {
                setState(() {
                  if (isSaved) {
                    savedFav.remove(place['key']);
                  } else {
                    savedFav.add(place['key']);
                  }
                });
              },
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PlacePage(place["key"])),
              );
            },
          )

          /*
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Icon(
              isSaved ? Icons.favorite : Icons.favorite_border,
              color: isSaved ? Colors.red : null,
            ),
              Row(
                children: [
                  Flexible(
                      child: Text(
                    place['name'],
                    style: TextStyle(
                        fontSize: 16,
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w600),
                  )),
                ],
              ),
              Row(
                children: [
                  // overflow: TextOverflow.ellipsis,
                  Flexible(
                      child: Text(
                    place['country'],
                    style: TextStyle(
                        fontSize: 16,
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w600),
                  )),
                ],
              ),

            ],
          ) */
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black12,
        title: Text(widget.title),
      ),
      body: SizedBox(
        height: double.infinity,
        child: FirebaseAnimatedList(
            query: _ref,
            itemBuilder: (BuildContext context, DataSnapshot snapshot,
                Animation<double> animation, int index) {
              Map place = snapshot.value as Map;
              place['key'] = snapshot.key;
              return _buildPlaceItem(place: place);
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CreatePlacePage()),
          );
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.add),
      ),
    );
  }
}
