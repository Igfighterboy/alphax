import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class YoutubeService {
  final YoutubeExplode _youtubeExplode = YoutubeExplode();

  Future<List<Video>> searchSongs(String query) async {
    final searchResults =
        await _youtubeExplode.search.getVideos(query + " music");
    final musicVideos = <Video>[];
    for (var video in searchResults) {
      if (_isMusicVideo(video)) {
        musicVideos.add(video);
      }
    }

    return musicVideos;
  }

  bool _isMusicVideo(Video video) {
    final musicKeywords = [
      'official music video',
      'lyrics',
      'audio',
      'official video',
      'music',
      'song',
      'track'
    ];

    // Check if the title or description contains any of the music-related keywords
    return musicKeywords.any((keyword) =>
        video.title.toLowerCase().contains(keyword.toLowerCase()) ||
        video.description.toLowerCase().contains(keyword.toLowerCase()));
  }

  Future<AudioStreamInfo> getAudioStream(String videoId) async {
    final manifest =
        await _youtubeExplode.videos.streamsClient.getManifest(videoId);
    final audioStreamInfo = manifest.audioOnly.withHighestBitrate();
    return audioStreamInfo;
  }

  Future<List<Map<String, String>>> fetchNewReleases(String query) async {
    final searchResults = await _youtubeExplode.search.search(query);
    return searchResults.map((result) {
      final video = result as Video;
      final thumbnails = video.thumbnails;
      final maxResThumbnail =
          thumbnails.maxResUrl; // Get the highest resolution thumbnail

      return {
        'title': video.title,
        'artist': video.author,
        'image': maxResThumbnail,
        'videoUrl': video.url,
      };
    }).toList();
  }

  Future<List<Video>> fetchRelatedVideos(String title) async {
    final searchResults = await _youtubeExplode.search.search(title);
    return searchResults
        .where((video) => !isSimilarTitle(video.title, title))
        .toList();
  }

  bool isSimilarTitle(String title1, String title2) {
    return title1.toLowerCase() == title2.toLowerCase() ||
        title1.toLowerCase().contains(title2.toLowerCase()) ||
        title2.toLowerCase().contains(title1.toLowerCase());
  }

  Future<List<Video>> fetchNextSongs(String query) async {
    final searchResults = await _youtubeExplode.search.getVideos(query);
    return searchResults;
  }

  void dispose() {
    _youtubeExplode.close();
  }
}