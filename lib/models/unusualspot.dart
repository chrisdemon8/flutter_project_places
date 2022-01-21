class UnusualSpot {
  String _id;
  String _name;
  String _description;
  List<Object?> _images;
  String _country;
  dynamic _rating;


  UnusualSpot(this._id, this._name , this._description,
      this._images, this._country, this._rating);

  factory UnusualSpot.fromJson(Map<String, dynamic> json) {
    return UnusualSpot(
          json['id'],
         json['name'],
          json['description'],
          json['images'],
          json['country'],
         json['rating']);
  }

  dynamic get rating => _rating;

  String get country => _country;

  List<Object?> get images => _images;

  String get description => _description;

  String get name => _name;

  String get id => _id;

  set rating(dynamic value) {
    _rating = value;
  }

  set country(String value) {
    _country = value;
  }

  set images(List<Object?> value) {
    _images = value;
  }

  set description(String value) {
    _description = value;
  }

  set name(String value) {
    _name = value;
  }

  set id(String value) {
    _id = value;
  }
}
