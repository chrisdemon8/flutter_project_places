class UnusualSpot {
  String? id;
  String? name;
  String? cityName;
  String? description;
  List<Object>? images;
  String? country;
  dynamic rating;

  UnusualSpot(
      {this.id,
      this.name,
      this.description,
      this.images,
      this.country,
      this.rating});

  factory UnusualSpot.fromJson(Map<String, dynamic> json) {
    return UnusualSpot(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        images: json['images'],
        country: json['country'],
        rating: json['rating']);
  }
}