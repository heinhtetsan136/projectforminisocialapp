import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:project/model/album.dart';
import 'package:project/model/photo.dart';
import 'package:project/view/screen/widget/profile_avartor.dart';

class MyDayCard extends StatelessWidget {
  final AlbumModel album;
  final PhotoModel photo;
  bool showCircleAvartor;
  MyDayCard(
      {super.key,
      this.showCircleAvartor = true,
      required this.photo,
      required this.album});

  @override
  Widget build(BuildContext context) {

    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed("/view", arguments: album.photos);
      },
      child: SizedBox(
        width: 100,
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          child: CachedNetworkImage(
            imageUrl: photo.url,
            imageBuilder: (context, imageProvider) => Container(
              padding: EdgeInsets.only(left: 8, bottom: 12, right: 8, top: 8),
              child: Column(
                mainAxisAlignment: showCircleAvartor
                    ? MainAxisAlignment.spaceBetween
                    : MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (showCircleAvartor)
                    ProfileAvator(
                      name: photo.user.name[0],
                    ),
                  Text(
                    photo.user.name.toString(),
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        overflow: TextOverflow.ellipsis),
                    maxLines: 2,
                  ),
                ],
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                    // colorFilter:
                    //     ColorFilter.mode(Colors.red, BlendMode.colorBurn)),
                  )),
            ),
            placeholder: (context, url) =>
                Center(child: CircularProgressIndicator()),
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
        ),
      ),
    );
    ;
  }
}
