
abstract class ErrorMessages {
  static const emptyPlaylist = "No playlists available.";
  static const fetchError = "Failed to fetch playlists. Please try again.";
}

abstract class Urls {
  static const baseStorageUrl = "http://192.168.2.126:8000/storage/";

  static String videoStream(int index) =>
      "http://192.168.2.126:8000/api/stream/$index";
}
