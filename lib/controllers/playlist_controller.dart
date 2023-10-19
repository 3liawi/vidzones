import 'package:get/get.dart';
import 'package:vidzones/models/playlist.dart';
import 'package:vidzones/services/api_service.dart';
import 'package:vidzones/utils/constants.dart';

class PlaylistController extends GetxController {
  final isLoading = true.obs;
  final playlists = <Playlist>[].obs;
  final fetchError = RxString("");

  @override
  void onInit() {
    super.onInit();
    _fetchPlaylists();
  }

  void _fetchPlaylists() async {
    try {
      isLoading(true);
      final fetchedPlaylists = await ApiService.getPlaylists();

      if (fetchedPlaylists.isEmpty) {
        fetchError.value = ErrorMessages.emptyPlaylist;
      } else {
        playlists.assignAll(fetchedPlaylists);
      }
    } catch (e) {
      fetchError.value = ErrorMessages.fetchError;
    } finally {
      isLoading(false);
    }
  }
}
