import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class YoutubeService {
  final YoutubeExplode _youtubeExplode = YoutubeExplode();

  Future<List<Video>> searchSongs(String query) async {
    final searchResults = await _youtubeExplode.search.getVideos(query);
    final musicKeywords = [
      'official music video',
      'lyrics',
      'audio',
      'official video',
      'music'
    ];

    final musicVideos = <Video>[];
    for (var video in searchResults) {
      if (musicKeywords.any((keyword) =>
          video.title.toLowerCase().contains(keyword.toLowerCase()))) {
        musicVideos.add(video);
      }
    }

    return musicVideos;
  }

  Future<AudioStreamInfo> getAudioStream(String videoId) async {
    final manifest = await _youtubeExplode.videos.streamsClient.getManifest(videoId);
    final audioStreamInfo = manifest.audioOnly.withHighestBitrate();
    return audioStreamInfo;
  }

  Future<List<Map<String, String>>> fetchNewReleases(String query) async {
    final searchResults = await _youtubeExplode.search.search(query);
    return searchResults.map((result) {
      final video = result as Video;
      return {
        'title': video.title,
        'artist': video.author,
        'image': video.thumbnails.standardResUrl,
        'videoUrl': video.url,
      };
    }).toList();
  }

  void dispose() {
    _youtubeExplode.close();
  }
}
