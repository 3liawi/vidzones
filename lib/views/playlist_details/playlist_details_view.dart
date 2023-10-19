import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:vidzones/controllers/video_controller.dart';
import 'package:vidzones/controllers/playlist_controller.dart';


import '../video_details/video_details_view.dart';

class PlaylistDetailsView extends StatelessWidget {
  final int playlistId = Get.arguments;

  PlaylistDetailsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final videoController = Get.put(VideoController(playlistId: playlistId));
    final playlistController = Get.find<PlaylistController>();
    final playlist =
        playlistController.playlists.firstWhere((p) => p.id == playlistId);

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 200.0,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text('Playlist Details'),
              background: CachedNetworkImage(
                imageUrl: playlist.imagePath,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverFillRemaining(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
              child: Obx(() {
                if (videoController.isLoading.value) {
                  return ListView.builder(
                    itemCount: 3, // Number of shimmer items
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Card(
                          elevation: 2,
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(16.0),
                            title: Container(
                              width: double.infinity,
                              height: 16.0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                } else {
                  return ListView.builder(
                    itemCount: videoController.videos.length,
                    itemBuilder: (context, index) {
                      return Card(
                        margin: const EdgeInsets.only(bottom: 8.0),
                        elevation: 2,
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(16.0),
                          title: Text(videoController.videos[index].title,
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600)),
                          onTap: () {
                            Get.to(
                                () => VideoDetailsView(
                                    videoId: videoController.videos[index].id, playlistImage: playlist.imagePath,),
                                arguments: videoController.videos[index].id);
                          },
                          trailing: Icon(Icons.arrow_forward_ios,
                              size: 16.0, color: Colors.grey[600]),
                        ),
                      );
                    },
                  );
                }
              }),
            ),
          ),
        ],
      ),
    );
  }
}
