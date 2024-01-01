import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:localstore/localstore.dart';
import 'package:project/controller/album_controller.dart';
import 'package:project/controller/feed_controller.dart';
import 'package:project/controller/post_controller.dart';
import 'package:project/controller/user_controller.dart';
import 'package:project/model/photo.dart';
import 'package:project/model/post.dart';
import 'package:project/model/user.dart';
import 'package:project/repositories/api.dart';
import 'package:project/repositories/cache_respositories.dart';
import 'package:project/view/screen/widget/image_section.dart';
import 'package:project/view/screen/widget/post_card.dart';
import 'package:project/view/screen/widget/search.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final CacheRepostories cahe = CacheRepostories(Localstore.instance);

  late final FeedController controller;

  bool isloading = true;
  final List<UserModel> user = [];

  @override
  void initState() {
    super.initState();
    final ApiRepositories apiRepositories =
        ApiRepositories(dio: Dio(), cacheRepostories: cahe);
    controller = FeedController(
        cacheRepostories: cahe,
        userController: UserController(api: apiRepositories),
        postController: PostController(apiRepositories),
        albumController: AlbumController(apiRepositories));
    controller.getUser().then((value) {
      user.addAll(value);
      print("init user $user");
      isloading = false;
      setState(() {});
    });

    // TODO: implement initState
  }

  @override
  Widget build(BuildContext context) {
    print("user $user");
    var image = user.map((e) => e.album).fold(
      <PhotoModel>[],
      (previousValue, element) => [
        ...previousValue,
        ...element[2].photos.fold(<PhotoModel>[],
            (previousValue, element) => [...previousValue, element])
      ],
    )..shuffle();
    print("imag $image");

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Mini Social",
          style: TextStyle(color: Colors.black),
        ),
        leading: Icon(
          Icons.facebook,
          color: Colors.black,
        ),
        actions: [
          IconButton(
              onPressed: () {
                showSearch(context: context, delegate: SearchScreen());
              },
              icon: Icon(
                Icons.search,
                color: Colors.black,
              )),
        ],
      ),
      body: isloading
          ? Center(child: const CircularProgressIndicator())
          : ListView(
              padding: EdgeInsets.only(bottom: 10),
              children: [
                ImageSection(
                  photos: image,
                ),
                for (var post
                    in user.map((e) => e.posts).fold(
                        <PostModel>[],
                        (previousValue, element) =>
                            [...previousValue, ...element])
                      ..shuffle())
                  PostCard(
                    post: post,
                    onTap: () {
                      Navigator.of(context).pushNamed("/details",
                          arguments: user.firstWhere(
                              (element) => element.id == post.userId));
                    },
                  ),
                TheEnd(),
              ],
            ),
    );
  }
}

class TheEnd extends StatefulWidget {
  const TheEnd({super.key});

  @override
  State<TheEnd> createState() => _TheEndState();
}

class _TheEndState extends State<TheEnd> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 5, left: 10, right: 10),
      child: Row(
        children: [
          Expanded(
              child: Divider(
            color: Colors.white,
            height: 1,
          )),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                "The End",
                textAlign: TextAlign.center,
              )),
          Expanded(
              child: Divider(
            color: Colors.white,
            height: 1,
          )),
        ],
      ),
    );
  }
}
