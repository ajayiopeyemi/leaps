import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:leaps/core/constants/leaps_dimens.dart';
import 'package:leaps/features/search/data/models/resource.dart';
import 'package:leaps/features/search/presentation/widgets/resource_status.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player/youtube_player.dart' as Youtube;

class VideoPreview extends StatefulWidget {
  final Resource resource;
  final bool isForLessonNote;
  VideoPreview({@required this.resource, @required this.isForLessonNote});

  @override
  _VideoPreviewState createState() => _VideoPreviewState();
}

class _VideoPreviewState extends State<VideoPreview> {
  VideoPlayerController _videoController;
  Youtube.VideoPlayerController _youtubePlayerController;

  @override
  void initState() {
    _videoController = VideoPlayerController.network(widget.resource.filePath
      /*https://www.youtube.com/watch?v=YimuIdEZSNY*/
    );
    super.initState();
  }

  @override
  void dispose() {
    _videoController.dispose();
    _youtubePlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isVideoYoutube() {
      if (widget.resource.filePath.contains('youtube.com') ||
          widget.resource.filePath.contains('youtube.com/watch')) {
        return true;
      } else {
        return false;
      }
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8.0),
            topRight: Radius.circular(8.0),
          ),
          child: isVideoYoutube() == true ?
          Container(
            width: AppDimensions.screenWidth(context),
            child: Youtube.YoutubePlayer(
              context: context,
              quality: Youtube.YoutubeQuality.HD,
              aspectRatio: 3 / 2,
              source: widget.resource.filePath,
              autoPlay: true,
              reactToOrientationChange: true,
              showThumbnail: true,
              startFullScreen: false,
              controlsActiveBackgroundOverlay: true,
              playerMode: Youtube.YoutubePlayerMode.DEFAULT,
              callbackController: (controller) {
                _youtubePlayerController = controller;
              },
            ),
          ):
          Container(
              width: AppDimensions.screenWidth(context),
              child: Chewie(
                controller: ChewieController(
                  videoPlayerController: _videoController,
                  aspectRatio: 3 / 2,
                  autoPlay: true,
                  looping: true,
                ),
              )),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 14.0),
          child: Text(
            widget.resource.title ?? "",
            style: TextStyle(fontWeight: FontWeight.w100),
          ),
        ),
        Divider(),
        Visibility(
          visible: widget.isForLessonNote == true ? false : true,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ResourceStatusWidget(resource: widget.resource),
          ),
        )
      ],
    );
  }
}
