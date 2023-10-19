import 'package:get/get.dart';
import 'package:vidzones/models/video.dart';
import 'package:vidzones/services/api_service.dart';
import 'package:vidzones/utils/constants.dart';

class VideoController extends GetxController {
  final int playlistId;

  final isLoading = true.obs;
  final videos = <Video>[].obs;

  VideoController({required this.playlistId});

  @override
  void onInit() {
    super.onInit();
    _fetchVideosForPlaylist();
  }

  void _fetchVideosForPlaylist() async {
    try {
      isLoading(true);
      final fetchedVideos = await ApiService.getVideosForPlaylist(playlistId);
      videos.assignAll(fetchedVideos);
    } catch (e) {
      print('Error fetching videos: $e');
    } finally {
      isLoading(false);
    }
  }

  Future<void> likeVideo(Video video) async {
    try {
      await ApiService.updateVideoLikes(video.id, video.likes + 1);
      video.likes++;
      update();
    } catch (e) {
      print('Error liking the video: $e');
    }
  }

  Future<void> dislikeVideo(Video video) async {
    try {
      await ApiService.updateVideoDislikes(video.id, video.dislikes + 1);
      video.dislikes++;
      update();
    } catch (e) {
      print('Error disliking the video: $e');
    }
  }

  String videoLink(int index) {
    return Urls.videoStream(index);

  }
}
