class Video {
  int id;
  String title;
  String description;
  String filePath;
  int likes;
  int dislikes;

  Video({
    required this.id,
    required this.title,
    required this.description,
    required this.filePath,
    required this.likes,
    required this.dislikes,
  });


  factory Video.fromJson(Map<String, dynamic> json) {
    return Video(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      filePath: json['file_path'],
      likes: json['likes'],
      dislikes: json['dislikes'],
    );
  }
}
