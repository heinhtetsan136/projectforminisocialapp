import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:project/model/photo.dart';
import 'package:project/model/user.dart';
import 'package:project/view/screen/widget/home_screen.dart';
import 'package:project/view/screen/widget/image_section.dart';
import 'package:project/view/screen/widget/not_found_screen.dart';
import 'package:project/view/screen/widget/post_card.dart';
import 'package:project/view/screen/widget/profile_avartor.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final user = ModalRoute.of(context)?.settings.arguments as UserModel;

    if (user == null || user is! UserModel) {
      return NotFoundScreen();
    }
    final coverphoto = user.album[1].photos;
    final List<PhotoModel> featurephoto = user.album.sublist(2).fold(
        [], (previousValue, element) => [...previousValue, ...element.photos]);
    print("this is cover $coverphoto");
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(user.name),
      ),
      body: ListView(
        children: [
          Container(
            color: Colors.white,
            height: 250,
            child: Stack(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.of(context)
                        .pushNamed("/view", arguments: coverphoto);
                  },
                  child: CachedNetworkImage(
                    imageUrl: coverphoto.first.url,
                    fit: BoxFit.cover,
                    width: size.width,
                    height: 200,
                  ),
                ),
                Positioned(
                    left: 5,
                    bottom: 20,
                    child: ProfileAvator(
                      name: user.name[0],
                      radius: 60,
                    )),
              ],
            ),
          ),
          Container(
            color: Colors.white,
            height: 100,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  child: Text(
                    user.name.toString(),
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w900,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                  padding: EdgeInsets.only(
                    left: 10,
                    bottom: 10,
                    right: 10,
                  ),
                ),
                Row(
                  children: [
                    StaticCard(
                        width: 100,
                        icon: Icons.article,
                        label: "${user.posts.length} post"),
                    StaticCard(
                        width: 120,
                        icon: Icons.article,
                        label: "${user.album.length} album"),
                  ],
                ),
              ],
            ),
          ),
          ImageSection(
            photos: featurephoto,
            showCircleAvartor: false,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Divider(),
          ),
          for (int i = 0; i < user.posts.length; i++)
            PostCard(
              onTap: null,
              post: user.posts[i],
            ),
          TheEnd(),
        ],
      ),
    );
  }
}

class StaticCard extends StatelessWidget {
  final double width;
  final IconData icon;
  final String label;
  StaticCard(
      {super.key,
      required this.width,
      required this.icon,
      required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Color.fromRGBO(225, 225, 225, 0.8),
      ),
      margin: EdgeInsets.symmetric(horizontal: 10),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: Theme.of(context).primaryColor,
          ),
          SizedBox(
            width: 5,
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
