import 'package:flutter/material.dart';
import 'package:myapp/services/youtube_services.dart';
import 'package:myapp/services/audio_cache_service.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:myapp/core/constatnts/size.dart';
import 'package:myapp/core/icon_fonts/broken_icons.dart';
import 'package:myapp/controller/playercontroller/playerstate.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class SearchResultCard extends StatefulWidget {
  final Video video;

  const SearchResultCard({Key? key, required this.video}) : super(key: key);

  @override
  _SearchResultCardState createState() => _SearchResultCardState();
}

class _SearchResultCardState extends State<SearchResultCard> {
  bool _isLoading = true;
  late final AudioCacheService _audioCacheService;

  @override
  void initState() {
    super.initState();
    _audioCacheService = AudioCacheService(); 
    _precacheAudioUrl();
  }

  Future<void> _precacheAudioUrl() async {
    try {
      await _audioCacheService.prefetchAudioStreams([widget.video]);
    } catch (e) {
      print('Error during audio prefetching: $e');
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  String _truncateText(String text, int limit) {
    return text.length <= limit ? text : '${text.substring(0, limit)}..';
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final containerWidth = screenWidth * 0.9;
    final colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: () async {
        final playerState = Provider.of<PlayerState>(context, listen: false);
        try {
          setState(() {
            _isLoading = true;
          });
          String? audioUrl = await _audioCacheService.getCachedAudioUrl(widget.video.id.value);
          if (audioUrl == null) {
            final youtubeService = YoutubeService();
            final audioStreamInfo = await youtubeService.getAudioStream(widget.video.id.value);
            audioUrl = audioStreamInfo.url.toString();
            await _audioCacheService.cacheAudioStream(widget.video.id.value, audioUrl);
          }
          await playerState.play(
            widget.video.title,
            widget.video.author,
            widget.video.thumbnails.maxResUrl,
            audioUrl,
          );
        } catch (e) {
          print('Error accessing PlayerState: $e');
        } finally {
          if (mounted) {
            setState(() {
              _isLoading = false;
            });
          }
        }
      },
      child: _isLoading
          ? _buildShimmerPlaceholder(containerWidth, colorScheme)
          : Container(
              width: containerWidth,
              height: 75,
              decoration: BoxDecoration(
                color: colorScheme.surface,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 55,
                          height: 55,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              widget.video.thumbnails.maxResUrl,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        alphawidth10,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              _truncateText(widget.video.title, 23),
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'LexendDeca',
                              ),
                            ),
                            Text(
                              _truncateText(widget.video.author, 37),
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'LexendDeca',
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Transform.rotate(
                      angle: 90 * 3.1 / 180,
                      child: GestureDetector(
                        onTap: () {},
                        child: Icon(
                          Broken.more,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildShimmerPlaceholder(double containerWidth, ColorScheme colorScheme) {
    return Shimmer.fromColors(
      baseColor: colorScheme.secondary,
      highlightColor: colorScheme.surface,
      child: Container(
        width: containerWidth,
        height: 75,
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 55,
                    height: 55,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.grey[300],
                    ),
                  ),
                  alphawidth10,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 100,
                        height: 15,
                        color: Colors.grey[300],
                      ),
                      alphaheight10,
                      Container(
                        width: 80,
                        height: 12,
                        color: Colors.grey[300],
                      ),
                    ],
                  ),
                ],
              ),
              Transform.rotate(
                angle: 90 * 3.1 / 180,
                child: Icon(
                  Broken.more,
                  color: Colors.grey[300],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
