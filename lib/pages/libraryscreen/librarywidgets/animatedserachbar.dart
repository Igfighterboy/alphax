import 'package:flutter/material.dart';
import 'package:myapp/core/constatnts/size.dart';
import 'package:myapp/core/icon_fonts/broken_icons.dart';

class AnimatedSearch extends StatefulWidget {
  const AnimatedSearch({super.key});

  @override
  State<AnimatedSearch> createState() => _AnimatedSearchState();
}

class _AnimatedSearchState extends State<AnimatedSearch>
    with TickerProviderStateMixin {
  late AnimationController _searchAnimationController;
  bool _isExpanded = false;

  @override
  void initState() {
    _searchAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 400,
      ),
    );
    super.initState();
  }

  @override
  void dispose() {
    _searchAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      width: _isExpanded ? 200 : 45,
      height: 38,
      decoration: BoxDecoration(
        color: _isExpanded ? colorScheme.surface : Colors.transparent,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: InkWell(
              onTap: () {
                setState(() {
                  _isExpanded = !_isExpanded;
                  if (_isExpanded) {
                    _searchAnimationController.forward();
                  } else {
                    _searchAnimationController.reverse();
                  }
                });
              },
              child: Icon(
                Broken.search_normal,
                size: 25,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
          alphawidth10,
          Expanded(
            child: AnimatedOpacity(
              opacity: _isExpanded ? 1 : 0,
              duration: const Duration(milliseconds: 200),
              child: TextField(
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'LexendDeca',
                ),
                decoration: InputDecoration(
                  hintText: 'Playlist Or Artist ',
                  contentPadding: const EdgeInsets.only(top: -7),
                  hintStyle: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'LexendDeca',
                  ),
                  border: InputBorder.none,
                ),
                autofocus: false,
              ),
            ),
          )
        ],
      ),
    );
  }
}