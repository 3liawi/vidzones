
import 'package:vidzones/utils/constants.dart';

class Playlist {
  final int id;
  final String name;
  final String imagePath;

  Playlist({required this.id, required this.name, required this.imagePath});

  factory Playlist.fromJson(Map<String, dynamic> json) {
    return Playlist(
      id: json['id'] as int,
      name: json['name'] as String,
      imagePath: Urls.baseStorageUrl + (json['image_path'] as String),
    );
  }
}