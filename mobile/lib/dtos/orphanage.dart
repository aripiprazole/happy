import 'dart:io';

class OrphanageCreateData {
  final String name;
  final num latitude;
  final num longitude;
  final String about;
  final String instructions;
  final String openingHours;
  final bool openOnWeekends;
  final List<File> images;

  const OrphanageCreateData({
    this.name,
    this.latitude,
    this.longitude,
    this.about,
    this.instructions,
    this.openingHours,
    this.openOnWeekends,
    this.images,
  });
}
