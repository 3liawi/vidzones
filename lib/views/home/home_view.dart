import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:vidzones/controllers/playlist_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../playlist_details/playlist_details_view.dart';

class HomeView extends StatelessWidget {
  final playlistController = Get.put(PlaylistController());

  HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Center(
            child: Text("VidZones", style: TextStyle(color: Colors.black))),
      ),
      body: Column(
        children: [
          Obx(
            () => playlistController.isLoading.value
                ? Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                        height: 150,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                : Expanded(
                    child: ListView.builder(
                      itemCount: playlistController.playlists.length,
                      itemBuilder: (context, index) {
                        final playlist = playlistController.playlists[index];
                        return Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: GestureDetector(
                            onTap: () {
                              Get.to(() => PlaylistDetailsView(),
                                  arguments: playlist.id);
                            },
                            child: Container(
                              height: 150,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.15),
                                    spreadRadius: 0.5,
                                    blurRadius: 15,
                                    offset: const Offset(0, 5),
                                  ),
                                ],
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Colors.black.withOpacity(0.6),
                                    Colors.black.withOpacity(0.9)
                                  ],
                                ),
                                image: DecorationImage(
                                  image: CachedNetworkImageProvider(
                                      playlist.imagePath),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  playlist.name,
                                  style: const TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      //stroke
                                      shadows: [
                                        Shadow(
                                          color: Colors.black,
                                          offset: Offset(0, 0),
                                          blurRadius: 1,
                                        ),
                                      ]),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
