import 'package:flutter/material.dart';
import 'package:myapp/core/constatnts/size.dart';

class PopularAlbumsCurrent extends StatelessWidget {
  final String albumName;
  final String artistName;
  final String imageUrl;
  const PopularAlbumsCurrent({
    super.key,
    required this.albumName,
    required this.artistName,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final screenWidth = MediaQuery.of(context).size.width;
    final containerWidth = screenWidth * 0.9;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            alphaheight20,
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: ListView.separated(
                itemBuilder: (context, index) {
                  
                },
                separatorBuilder: (context, index) => alphaheight20,
                itemCount: 10,
              ),
            )
          ],
        ),
      ),
    );
    // return Scaffold(
    //   body: SingleChildScrollView(
    //     child: Column(
    //       children: [
    //         Padding(
    //           padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
    //           child: Row(
    //             children: [
    //               Container(
    //                 width: 110,
    //                 height: 110,
    //                 decoration: BoxDecoration(
    //                   color: colorScheme.surface.withOpacity(0.66),
    //                   borderRadius: BorderRadius.circular(10),
    //                   border: Border.all(color: colorScheme.surface, width: 3),
    //                 ),
    //                 child: ClipRRect(
    //                   borderRadius: BorderRadius.circular(10),
    //                   child: Image.network(
    //                     imageUrl,
    //                     fit: BoxFit.cover,
    //                   ),
    //                 ),
    //               ),
    //               alphawidth10,
    //               Column(
    //                 crossAxisAlignment: CrossAxisAlignment.start,
    //                 mainAxisAlignment: MainAxisAlignment.start,
    //                 children: [
    //                   Text(
    //                     albumName,
    //                     style: TextStyle(
    //                         fontSize: 20,
    //                         fontWeight: FontWeight.w500,
    //                         color: Theme.of(context).primaryColor,
    //                         fontFamily: 'LexendDeca'),
    //                   ),
    //                   Text(
    //                     artistName,
    //                     style: TextStyle(
    //                         fontSize: 15,
    //                         fontWeight: FontWeight.w400,
    //                         color: Theme.of(context).primaryColor,
    //                         fontFamily: 'LexendDeca'),
    //                   ),
    //                 ],
    //               )
    //             ],
    //           ),
    //         ),

    //       ],
    //     ),
    //   ),
    // );
  }
}
