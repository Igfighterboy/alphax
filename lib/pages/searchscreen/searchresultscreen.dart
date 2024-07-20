import 'package:flutter/material.dart';
import 'package:myapp/core/constatnts/size.dart';
import 'package:myapp/core/icon_fonts/broken_icons.dart';
import 'package:myapp/pages/searchscreen/searchwidget/searchresultcard.dart';
import 'package:myapp/services/youtube_services.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class SearchResultScreen extends StatefulWidget {
  const SearchResultScreen({super.key});

  @override
  _SearchResultScreenState createState() => _SearchResultScreenState();
}

class _SearchResultScreenState extends State<SearchResultScreen> {
  final YoutubeService _youtubeService = YoutubeService();
  List<Video> _searchResults = [];

  void _search(String query) async {
    final results = await _youtubeService.searchSongs(query);
    setState(() {
      _searchResults = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: SizedBox(
          height: 40,
          child: TextField(
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: 15,
              fontWeight: FontWeight.w400,
              fontFamily: 'LexendDeca',
            ),
            decoration: InputDecoration(
              hintText: 'What do you want to hear?',
              contentPadding: const EdgeInsets.only(top: 8),
              hintStyle: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 15,
                fontWeight: FontWeight.w400,
                fontFamily: 'LexendDeca',
              ),
              border: InputBorder.none,
              filled: true,
              fillColor: colorScheme.surface,
              prefixIcon: IconButton(
                icon: Icon(
                  Broken.arrow_left_1,
                  color: Theme.of(context).primaryColor,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(13),
                borderSide: BorderSide(color: Colors.transparent),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(13),
                borderSide: BorderSide(color: Colors.transparent),
              ),
            ),
            autofocus: true,
            onSubmitted: _search,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: ListView.separated(
          itemCount: _searchResults.length,
          separatorBuilder: (context, index) => alphaheight10,
          itemBuilder: (context, index) {
            final video = _searchResults[index];
            return SearchResultCard(video: video);
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _youtubeService.dispose();
    super.dispose();
  }
}
