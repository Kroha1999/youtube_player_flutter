// Copyright 2020 Sarbagya Dhaubanjar. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';

import '../player/youtube_player.dart';
import '../utils/youtube_meta_data.dart';
import '../utils/youtube_player_controller.dart';
import '../widgets/widgets.dart';

/// Shows [YoutubePlayer] in fullScreen landscape mode.
Future<void> showFullScreenYoutubePlayer({
  @required BuildContext context,
  @required YoutubePlayerController controller,
  EdgeInsetsGeometry actionsPadding,
  List<Widget> topActions,
  List<Widget> bottomActions,
  Widget bufferIndicator,
  Duration controlsTimeOut,
  VoidCallback onReady,
  void Function(YoutubeMetaData) onEnded,
  ProgressBarColors progressColors,
  String thumbnailUrl,
}) async =>
    await Navigator.push(
      context,
      _YoutubePageRoute(
        builder: (context) => _FullScreenYoutubePlayer(
          onReady: onReady,
          onEnded: onEnded,
          topActions: topActions,
          controller: controller,
          thumbnailUrl: thumbnailUrl,
          bottomActions: bottomActions,
          progressColors: progressColors,
          actionsPadding: actionsPadding,
          controlsTimeOut: controlsTimeOut,
          bufferIndicator: bufferIndicator,
        ),
      ),
    );

class _FullScreenYoutubePlayer extends StatefulWidget {
  /// {@macro youtube_player_flutter.controller}
  final YoutubePlayerController controller;

  /// {@macro youtube_player_flutter.controlsTimeOut}
  final Duration controlsTimeOut;

  /// {@macro youtube_player_flutter.bufferIndicator}
  final Widget bufferIndicator;

  /// {@macro youtube_player_flutter.progressColors}
  final ProgressBarColors progressColors;

  /// {@macro youtube_player_flutter.onReady}
  final VoidCallback onReady;

  /// {@macro youtube_player_flutter.onEnded}
  final void Function(YoutubeMetaData) onEnded;

  /// {@macro youtube_player_flutter.topActions}
  final List<Widget> topActions;

  /// {@macro youtube_player_flutter.bottomActions}
  final List<Widget> bottomActions;

  /// {@macro youtube_player_flutter.actionsPadding}
  final EdgeInsetsGeometry actionsPadding;

  /// {@macro youtube_player_flutter.thumbnailUrl}
  final String thumbnailUrl;

  _FullScreenYoutubePlayer({
    Key key,
    @required this.controller,
    this.bufferIndicator,
    this.progressColors,
    this.onReady,
    this.onEnded,
    this.topActions,
    this.bottomActions,
    this.controlsTimeOut = const Duration(seconds: 3),
    this.actionsPadding = const EdgeInsets.all(8.0),
    this.thumbnailUrl,
  }) : super(key: key);

  @override
  _FullScreenYoutubePlayerState createState() => _FullScreenYoutubePlayerState();
}

class _FullScreenYoutubePlayerState extends State<_FullScreenYoutubePlayer> {
  @override
  Widget build(BuildContext context) => YoutubePlayer(
        controller: widget.controller,
        showVideoProgressIndicator: false,
        actionsPadding: widget.actionsPadding,
        bottomActions: widget.bottomActions,
        bufferIndicator: widget.bufferIndicator,
        controlsTimeOut: widget.controlsTimeOut,
        onReady: widget.onReady,
        onEnded: widget.onEnded,
        progressColors: widget.progressColors,
        thumbnailUrl: widget.thumbnailUrl,
        topActions: widget.topActions,
      );

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback(
      (_) => widget.controller.updateValue(widget.controller.value.copyWith(
        isFullScreen: true,
      )),
    );

    SystemChrome.setEnabledSystemUIOverlays([]);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    // TODO cache orientations and return proper values
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    SchedulerBinding.instance.addPostFrameCallback(
      (_) => widget.controller.updateValue(
        widget.controller.value.copyWith(isFullScreen: false),
      ),
    );
    super.dispose();
  }
}

class _YoutubePageRoute<T> extends MaterialPageRoute<T> {
  _YoutubePageRoute({
    @required WidgetBuilder builder,
  }) : super(builder: builder);

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) =>
      child;
}
