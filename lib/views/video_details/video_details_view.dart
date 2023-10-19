import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:vidzones/models/video.dart';
import '../../controllers/video_controller.dart';
import 'package:shimmer/shimmer.dart';

class VideoDetailsView extends StatefulWidget {
  final int videoId;
  final String playlistImage;

  const VideoDetailsView({
    required this.videoId,
    required this.playlistImage,
    Key? key,
  }) : super(key: key);

  @override
  _VideoDetailsViewState createState() => _VideoDetailsViewState();
}

class _VideoDetailsViewState extends State<VideoDetailsView> {
  late VideoPlayerController _controller;
  final VideoController videoController = Get.find<VideoController>();

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.network(
      videoController.videoLink(widget.videoId),
    );
    _controller.initialize().then((_) => setState(() {}));
    _controller.play();
  }

  @override
  Widget build(BuildContext context) {
    Video? currentVideo;
    for (var video in videoController.videos) {
      if (video.id == widget.videoId) {
        currentVideo = video;
        break;
      }
    }

    if (currentVideo == null) {
      return const Scaffold(body: Center(child: Text('Video not found.')));
    }

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            // expandedHeight: 250.0,
            floating: true,
            pinned: true,
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back,
                  color: Color.fromARGB(255, 0, 0, 0)),
              onPressed: () => Get.back(),
            ),
            flexibleSpace: const FlexibleSpaceBar(),
          ),
          SliverPadding(
            padding: const EdgeInsets.only(top: 16.0),
            sliver: SliverList(
              delegate: SliverChildListDelegate(
                [
                  AspectRatio(
                    aspectRatio: 16 / 9,
                    child: _controller.value.isInitialized
                        ? VideoPlayer(_controller)
                        : Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[100]!,
                            child: Container(color: Colors.white),
                          ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      currentVideo.description,
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 16,
                        height: 1.5,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _iconWithTextAction(
                          Icons.thumb_up,
                          currentVideo.likes.toString(),
                          () => videoController.likeVideo(currentVideo!),
                        ),
                        _iconWithTextAction(
                          Icons.thumb_down,
                          currentVideo.dislikes.toString(),
                          () => videoController.dislikeVideo(currentVideo!),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _iconWithTextAction(IconData icon, String text, Function onPressed) {
    return InkWell(
      onTap: onPressed as void Function()?,
      child: Row(
        children: [
          Icon(icon, color: Colors.blue[700]),
          const SizedBox(width: 5),
          Text(
            text,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.grey[800],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
