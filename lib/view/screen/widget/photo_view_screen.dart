import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:project/view/screen/widget/not_found_screen.dart';

import '../../../model/photo.dart';

class PhotoView extends StatefulWidget {
  const PhotoView({super.key});

  @override
  State<PhotoView> createState() => _PhotoViewState();
}

class _PhotoViewState extends State<PhotoView> {

  @override
  Widget build(BuildContext context) {
    final  photo=ModalRoute.of(context)?.settings.arguments ;
    if(photo==null||photo is! List<PhotoModel>){
      return NotFoundScreen();
    }
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: Stack(
          children: [
            PageView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: photo.length,
              itemBuilder: (_, i) {
                return CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl: photo[i].url,
                  placeholder: (_, __) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                  errorWidget: (_, __, a) {
                    return Center(child: Icon(Icons.error));
                  },
                );
              },
            ),
            Positioned(
              top: MediaQuery.viewPaddingOf(context).top+5,
                child: TextButton.icon(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(Icons.arrow_back),
                    label: Text("Back"))),
          ],
        ),
      ),
    );
  }
}
