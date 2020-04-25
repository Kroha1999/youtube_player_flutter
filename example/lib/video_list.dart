/*
* // 
* // video_list.dart
* // 
* // Created by Bohdan Krokhmaliuk on 2020-04-26
* // Copyright (c) 2020 Kroha. All rights reserved.
* // 
*/
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

/// Creates list of video players
class VideoList extends StatefulWidget {
  @override
  _VideoListState createState() => _VideoListState();
}

class _VideoListState extends State<VideoList> {
  final List<YoutubePlayerController> _controllers = [
    'gQDByCdjUXw',
    'iLnmTe5Q2Qw',
    '_WoCV4c6XOE',
    'KmzdUe0RSJo',
    '6jZDSSZZxjQ',
    'p2lYr3vM_1w',
    '7QUtEmBT_-w',
    '34_PXCzGw1M',
  ]
      .map<YoutubePlayerController>(
        (videoId) => YoutubePlayerController(
          initialVideoId: videoId,
          flags: YoutubePlayerFlags(
            autoPlay: false,
            hideThumbnail: true,
            enableCaption: false,
            forceHideAnnotation: true,
          ),
        ),
      )
      .toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Video List Demo'),
      ),
      body: ListView.separated(
        itemBuilder: (context, index) {
          return YoutubePlayer(
            key: ObjectKey(_controllers[index]),
            controller: _controllers[index],
            progressColors: ProgressBarColors(
              progressIndicatorColor: Colors.blue,
              backgroundColor: Colors.red,
              bufferedColor: Colors.green,
              playedColor: Colors.red,
            ),
            width: 100,
            showVideoProgressIndicator: true,
            actionsPadding: EdgeInsets.only(left: 16.0),
            progressIndicatorColor: Colors.red,
            // bottomActions: [
            //   CurrentPosition(),
            //   SizedBox(width: 10.0),
            //   ProgressBar(isExpanded: true),
            //   SizedBox(width: 10.0),
            //   RemainingDuration(),
            //   FullScreenButton(),
            // ],
          );
        },
        itemCount: 1,
        separatorBuilder: (context, _) => SizedBox(height: 10.0),
      ),
    );
  }
}
