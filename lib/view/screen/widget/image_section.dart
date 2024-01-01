import 'package:flutter/material.dart';
import 'package:project/controller/feed_controller.dart';
import 'package:project/model/album.dart';
import 'package:project/model/photo.dart';
import 'package:project/view/screen/widget/my_day_card.dart';

class ImageSection extends StatelessWidget {
  final List<PhotoModel> photos;

  bool showCircleAvartor;
  ImageSection({
    super.key,
    this.showCircleAvartor = true,
    this.photos = const [],
  });

  @override
  Widget build(BuildContext context) {
    print("i sec $photos");
    final size = MediaQuery.of(context).size;
    return Container(
      color: Colors.white,
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.symmetric(vertical: 8),
      height: 150,
      width: size.width,
      child: ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: 10),
          scrollDirection: Axis.horizontal,
          itemCount: photos.length,
          itemBuilder: (_, i) {
            final photo = photos[i];
            final album = FeedController.users.fold(
                <AlbumModel>[],
                (previousValue, element) =>
                    [...previousValue, ...element.album]);
            final albumindex =
                album.indexWhere((element) => element.id == photo.albumId);
            final copied = album[albumindex].copy();
            copied.photos.removeWhere((element) => element.id == photo.albumId);
            copied.photos.insert(0, photo);
            print("my day $photo");
            return MyDayCard(
              photo: photo,
              album: copied,
              showCircleAvartor: showCircleAvartor,
            );
          }),
    );
  }
}
