import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:myapp/core/constatnts/size.dart';
import 'package:myapp/core/icon_fonts/broken_icons.dart';
import 'package:myapp/pages/searchscreen/searchwidget/searchresultcard.dart';
import 'package:myapp/services/youtube_services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class SearchResultScreen extends StatefulWidget {
  const SearchResultScreen({super.key});

  @override
  _SearchResultScreenState createState() => _SearchResultScreenState();
}

class _SearchResultScreenState extends State<SearchResultScreen> {
  final TextEditingController _searchController = TextEditingController();
  final YoutubeService _youtubeService = YoutubeService();
  List<Video> _searchResults = [];
  List<String> _recentSearches = [];
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
    _loadRecentSearches();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _debounce?.cancel();
    _youtubeService.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      _search(_searchController.text);
    });
  }

  void _search(String query) async {
    if (query.isEmpty) {
      setState(() {
        _searchResults = [];
      });
      return;
    }

    final results = await _youtubeService.searchSongs(query);
    setState(() {
      _searchResults = results;
      if (results.isNotEmpty) {
        _saveRecentSearch(query);
      }
    });
  }

  Future<void> _loadRecentSearches() async {
    final prefs = await SharedPreferences.getInstance();
    final recentSearchesJson = prefs.getString('recentSearches');
    if (recentSearchesJson != null) {
      final List<String> recentSearches = List<String>.from(json.decode(recentSearchesJson));
      setState(() {
        _recentSearches = recentSearches;
      });
    }
  }

  Future<void> _saveRecentSearch(String query) async {
    _recentSearches.remove(query);
    _recentSearches.insert(0, query);
    if (_recentSearches.length > 10) {
      _recentSearches = _recentSearches.sublist(0, 10);
    }
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('recentSearches', json.encode(_recentSearches));
  }

  Future<void> _removeRecentSearch(String query) async {
    setState(() {
      _recentSearches.remove(query);
    });
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('recentSearches', json.encode(_recentSearches));
  }

  String _truncateText(String text, int limit) {
    if (text.length <= limit) {
      return text;
    } else {
      return '${text.substring(0, limit)}..';
    }
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
            controller: _searchController,
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
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: _searchController.text.isEmpty
            ? _recentSearches.isEmpty
                ? Center(
                    child: Text(
                      'Start typing to search for songs',
                      style: TextStyle(
                        color: colorScheme.onSurface,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  )
                : ListView.separated(
                    itemCount: _recentSearches.length,
                    separatorBuilder: (context, index) => alphaheight20,
                    itemBuilder: (context, index) {
                      final recentSearch = _recentSearches[index];
                      return Row(
                        children: [
                          Icon(
                            Broken.clock,
                            size: 23,
                            color: Theme.of(context).primaryColor,
                          ),
                          alphawidth10,
                          Expanded(
                            child: Text(
                              _truncateText(recentSearch, 26),
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'lexenddeca',
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ),
                          Transform.rotate(
                            angle: 60 * 2.35 / 180,
                            child: GestureDetector(
                                onTap: () {
                                  _removeRecentSearch(recentSearch);
                                },
                                child: Icon(
                                  Broken.add,
                                  size: 27,
                                  color: Theme.of(context).primaryColor,
                                )),
                          ),
                          alphawidth10,
                          Transform.rotate(
                            angle: 60 * 2.35 / 180,
                            child: GestureDetector(
                                onTap: () {
                                  _searchController.text = recentSearch;
                                  _search(recentSearch);
                                },
                                child: Icon(
                                  Broken.arrow_left_1,
                                  size: 21,
                                  color: Theme.of(context).primaryColor,
                                )),
                          ),
                        ],
                      );
                    },
                  )
            : ListView.separated(
                itemCount: _searchResults.length,
                separatorBuilder: (context, index) => alphaheight10,
                itemBuilder: (context, index) {
                  final video = _searchResults[index];
                  return SearchResultCard(
                    video: video,
                  );
                },
              ),
      ),
    );
  }
}
