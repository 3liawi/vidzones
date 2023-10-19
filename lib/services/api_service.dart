import 'package:dio/dio.dart';
import 'package:vidzones/models/playlist.dart';
import 'package:vidzones/models/video.dart';

class ApiService {
  static const _baseUrl = 'http://192.168.2.126:8000/api';
  static final Dio _dio = Dio();

  static Future<List<Playlist>> getPlaylists() async {
    try {
      final response = await _dio.get('$_baseUrl/playlists');
      Iterable list = response.data;
      return list.map((model) => Playlist.fromJson(model)).toList();
    } catch (e) {
      throw Exception('Failed to load playlists');
    }
  }

  static Future<List<Video>> getVideosForPlaylist(int playlistId) async {
    try {
      final response = await _dio.get('$_baseUrl/playlists/$playlistId/videos');
      Iterable list = response.data;
      return list.map((model) => Video.fromJson(model)).toList();
    } catch (e) {
      throw Exception('Failed to load videos');
    }
  }

  static Future<int> like(int videoId) async {
    try {
      final response = await _dio.post('$_baseUrl/video/$videoId/like');
      if (response.statusCode == 200 && response.data.containsKey('likes')) {
        return response.data['likes'];
      } else {
        throw Exception('Failed to like video');
      }
    } catch (e) {
      throw Exception('Failed to like video');
    }
  }

  static Future<int> dislike(int videoId) async {
    try {
      final response = await _dio.post('$_baseUrl/video/$videoId/dislike');
      if (response.statusCode == 200 && response.data.containsKey('dislikes')) {
        return response.data['dislikes'];
      } else {
        throw Exception('Failed to dislike video');
      }
    } catch (e) {
      throw Exception('Failed to dislike video');
    }
  }

static Future<bool> updateVideoLikes(int videoId, int likes) async {
  try {
    final response = await _dio.post('$_baseUrl/video/$videoId/likes', data: {'likes': likes});
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  } catch (e) {
    throw Exception('Failed to update likes for video $videoId');
  }
}

static Future<bool> updateVideoDislikes(int videoId, int dislikes) async {
  try {
    final response = await _dio.post('$_baseUrl/video/$videoId/dislikes', data: {'dislikes': dislikes});
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  } catch (e) {
    throw Exception('Failed to update dislikes for video $videoId');
  }
}
}
