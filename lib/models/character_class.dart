class CharacterClass {
  CharacterClass({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.type,
    required this.gender,
    this.origin,
    this.location,
    this.image,
    this.episode,
    this.url,
    this.created,
  });

  CharacterClass.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int,
        name = json['name'] as String,
        status = json['status'] as String,
        species = json['species'] as String,
        type = json['type'] as String,
        gender = json['gender'] as String,
        origin = Origin.fromJson(json['origin']) as Origin,
        location = Location.fromJson(json['location']) as Location,
        image = json['image'] as String ?? 'https://via.placeholder.com/150',
        episode = List<String>.from(json['episode'] as List<dynamic>),
        url = json['url'] as String,
        created = json['created'];

  int id;
  String name;
  String status;
  String species;   
  String type;
  String gender;
  Origin? origin;
  Location? location;
  String? image;
  List<String>? episode;
  String? url;
  String? created;
}

class Origin {
  Origin({
    required this.name,
    required this.url,
  });

  Origin.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        url = json['url'];

  String name;
  String url;
}

class Location {
  Location({
    required this.name,
    required this.url,
  });

  Location.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        url = json['url'];

  String name;
  String url;
}
