import 'package:flutter/material.dart';
import 'package:myapp/services/youtube_services.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:myapp/core/constatnts/size.dart';
import 'package:myapp/core/icon_fonts/broken_icons.dart';
import 'package:myapp/controller/playercontroller/playerstate.dart';
import 'package:provider/provider.dart';
import 'package:palette_generator/palette_generator.dart';
class SearchResultCard extends StatelessWidget {
  final Video video;

  SearchResultCard({Key? key, required this.video}) : super(key: key);

  String _truncateText(String text, int limit) {
    if (text.length <= limit) {
      return text;
    } else {
      return '${text.substring(0, limit)}..';
    }
  }

  Future<Color> _getDominantColor(String imageUrl) async {
    final PaletteGenerator paletteGenerator = await PaletteGenerator.fromImageProvider(
      NetworkImage(imageUrl),
    );
    return paletteGenerator.dominantColor?.color ?? Colors.grey[900]!;
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final youtubeService = YoutubeService();
    return GestureDetector(
      onTap: () async {
        try {
          final dominantColor = await _getDominantColor(video.thumbnails.standardResUrl);
          final audioStreamInfo = await youtubeService.getAudioStream(video.id.value);
          final audioUrl = audioStreamInfo.url.toString();
          final playerState = Provider.of<PlayerState>(context, listen: false);
          playerState.play(
            video.title,
            video.author,
            video.thumbnails.standardResUrl,
            dominantColor,
            audioUrl,
          );
        } catch (e) {
          print('Error accessing PlayerState: $e');
        }
      },
      child: Container(
        width: double.infinity,
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
                        video.thumbnails.standardResUrl,
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
                        _truncateText(video.title, 25),
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'LexendDeca',
                        ),
                      ),
                      Text(
                        _truncateText(video.author, 37),
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
              Icon(
                Broken.slider_vertical,
                color: Theme.of(context).primaryColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}