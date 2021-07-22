import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

void main() => runApp(VideoPlayerApp());

// ignore: use_key_in_widget_constructors
class VideoPlayerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Video Player',
      debugShowCheckedModeBanner: false,
      home: VideoPlayerScreen(),
    );
  }
}

// ignore: use_key_in_widget_constructors
class VideoPlayerScreen extends StatefulWidget {
  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  final List<String> _clips = [
    "https://api.ijeeni.com/post/21-07-04-15-42-41.mp4",
    "https://api.ijeeni.com/post/1625465047356.mp4",
    "https://api.ijeeni.com/post/startups.mp4",
    "https://api.ijeeni.com/post/21-07-04-15-42-41.mp4",
    "https://api.ijeeni.com/post/1625465047356.mp4",
    "https://api.ijeeni.com/post/startups.mp4",
    "https://api.ijeeni.com/post/21-07-04-15-42-41.mp4",
    "https://api.ijeeni.com/post/1625465047356.mp4",
    "https://api.ijeeni.com/post/startups.mp4"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Video Player'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListView.separated(
                shrinkWrap: true,
                cacheExtent: 1000,
                physics: const NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                addAutomaticKeepAlives: true,
                itemCount: _clips.isEmpty ? 0 : _clips.length,
                itemBuilder: (BuildContext context, int index) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: double.infinity,
                    height: 250,
                    alignment: Alignment.center,
                    child: VideoWidget(
                      url: _clips.elementAt(index),
                    ),
                  ),
                ),
                separatorBuilder: (context, index) {
                  return const Divider();
                },
              ),
            ],
          ),
        ));
  }
}

class VideoWidget extends StatefulWidget {
  final String url;

  // ignore: use_key_in_widget_constructors
  const VideoWidget({required this.url});

  @override
  _VideoWidgetState createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> {
  late VideoPlayerController videoPlayerController;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();
    videoPlayerController = VideoPlayerController.network(widget.url);

    _initializeVideoPlayerFuture = videoPlayerController.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initializeVideoPlayerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Chewie(
            controller: ChewieController(
              videoPlayerController: videoPlayerController,
              aspectRatio: 3 / 2,
              autoInitialize: true,
              looping: false,
              autoPlay: false,
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
