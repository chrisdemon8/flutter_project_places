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
  UnusualSpot _placeObject = UnusualSpot(
      id: "",
      name: "",
      description: "",
      images: [],
      country: "",
      rating: "");

  _readPlace() async {
    DatabaseReference _testRef =
        FirebaseDatabase.instance.ref().child("places");

    DatabaseEvent event = await _testRef.child(widget.placeId).once();

    DataSnapshot snapshot = event.snapshot;
    Map place = snapshot.value as Map;

    UnusualSpot _placeObject = UnusualSpot(
        id: place["key"],
        name: place["name"],
        description: place["description"],
        images: ["https://img.ev.mu/images/articles/600x/986627.jpg","https://upload.wikimedia.org/wikipedia/commons/5/55/Rotheneuf.jpg"],
        country: place["country"],
        rating: "");

    return _placeObject;
  }

  @override
  void initState() {
    super.initState();
    _readPlace().then((result) {
      setState(() {
        _placeObject = result ;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.black12,
      ),
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: <Widget>[
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Image(
                    image: NetworkImage('https://cdn.generationvoyage.fr/2019/10/rochers-sculptes-abbe-fourre-bretagne.jpg'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left : 12.0, right : 12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          _placeObject.name,
                          style: const TextStyle(
                            fontFamily: 'Avenir',
                            fontSize: 56,
                            fontWeight: FontWeight.w900,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        Divider(color: Colors.black38),
                        SizedBox(height: 32),
                        Text(
                          _placeObject.description ?? '',
                          style: const TextStyle(
                            fontFamily: 'Avenir',
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 32),
                        const Divider(color: Colors.black38),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 32.0),
                    child: Text(
                      'Gallery',
                      style: TextStyle(
                        fontFamily: 'Avenir',
                        fontSize: 25,
                        color: Color(0xff47455f),
                        fontWeight: FontWeight.w300,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Container(
                    height: 250,
                    child:
                    ListView.builder(
                        itemCount: _placeObject.images?.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Card(
                            clipBehavior: Clip.antiAlias,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: AspectRatio(
                                aspectRatio: 1,
                                child: Image.network(
                                  _placeObject.images![index],
                                  fit: BoxFit.cover,
                                )),
                          );
                        }),
                  ),
                ],
              ),

            ),
          ],
        ),
      ),
    );
  }
}
