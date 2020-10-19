class Orphanage {
  final num id;
  final String name;
  final num latitude;
  final num longitude;
  final String about;
  final String instructions;
  final String openingHours;
  final bool openOnWeekends;
  final List<String> images;

  const Orphanage({
    this.id,
    this.name,
    this.latitude,
    this.longitude,
    this.about,
    this.instructions,
    this.openingHours,
    this.openOnWeekends,
    this.images,
  });

  Orphanage.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        latitude = num.parse(json['latitude']),
        longitude = num.parse(json['longitude']),
        about = json['about'],
        instructions = json['instructions'],
        openingHours = json['opening_hours'],
        openOnWeekends = json['open_on_weekends'],
        images = (json['images'] as List<dynamic>)
            .map((object) => object.toString())
            .toList();
}
