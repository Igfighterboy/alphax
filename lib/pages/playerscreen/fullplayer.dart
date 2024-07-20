import 'package:flutter/material.dart';
import 'package:myapp/controller/playercontroller/playerstate.dart';
import 'package:provider/provider.dart';


class FullScreenPlayer extends StatelessWidget {
  final VoidCallback onCollapse;

  FullScreenPlayer({required this.onCollapse});

  @override
  Widget build(BuildContext context) {
    final playerState = Provider.of<PlayerState>(context);

    return GestureDetector(
      onTap: onCollapse,
      child: Container(
        color: Colors.black.withOpacity(0.8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Placeholder for album artwork
            Container(
              width: 200.0,
              height: 200.0,
              color: Colors.grey,
            ),
            SizedBox(height: 20.0),
            Text(
              playerState.title.isNotEmpty ? playerState.title : 'No Song Playing',
              style: TextStyle(color: Colors.white, fontSize: 24.0),
            ),
            Text(
              playerState.artist.isNotEmpty ? playerState.artist : '',
              style: TextStyle(color: Colors.white70, fontSize: 18.0),
            ),
            // Add playback controls here
          ],
        ),
      ),
    );
  }
}