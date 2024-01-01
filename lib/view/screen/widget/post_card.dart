import 'package:flutter/material.dart';
import 'package:project/model/post.dart';
import 'package:project/repositories/like_respositories.dart';
import 'package:project/view/screen/widget/post_action_button.dart';
import 'package:project/view/screen/widget/profile_avartor.dart';

class PostCard extends StatelessWidget {
  final PostModel post;
  void Function()? onTap;

  PostCard({super.key, this.onTap, required this.post});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(top: 5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
      ),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: onTap,
              child: Row(
                children: [
                  ProfileAvator(
                    name: post.user.name[0].toString(),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    post.user.name,
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 5),
              child: Text("${post.title}"),
            ),
            Text("${post.body}"),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                LikeButton(post: post),
                PostActionButton(
                    icon: Icons.comment,
                    label: "Comment ${post.comments.length}",
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (_) {
                          return Container(
                              width: MediaQuery.of(context).size.width * 0.8,

                              // decoration: BoxDecoration(
                              //   borderRadius: BorderRadius.circular(20),
                              // ),
                              padding:
                                  EdgeInsets.only(top: 5, left: 10, right: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 100,
                                    height: 10,
                                    decoration: BoxDecoration(
                                      color: Color.fromRGBO(188, 188, 188, 0.4),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    margin: EdgeInsets.only(bottom: 10),
                                  ),
                                  Expanded(
                                    child: ListView.separated(
                                      padding:
                                          EdgeInsets.only(left: 10, right: 10),
                                      separatorBuilder: (_, i) => Divider(),
                                      itemCount: post.comments.length,
                                      itemBuilder: (_, i) {
                                        final comment = post.comments[i];

                                        return Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  ProfileAvator(
                                                    name: comment.name[0],
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(comment.email),
                                                ],
                                              ),
                                              Text(comment.body),
                                            ]);
                                      },
                                    ),
                                  ),
                                ],
                              ));
                        },
                      );
                    }),
                PostActionButton(
                  icon: Icons.share,
                  label: "Share",
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class LikeButton extends StatefulWidget {
  final PostModel post;
  const LikeButton({super.key, required this.post});

  @override
  State<LikeButton> createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton> {
  @override
  Widget build(BuildContext context) {
    return PostActionButton(
      color:
          LikeRespositories.get(widget.post.id.toString()) ? Colors.red : null,
      icon: LikeRespositories.get(widget.post.id.toString())
          ? Icons.favorite
          : Icons.favorite_border,
      label: "Saved",
      onTap: () {
        LikeRespositories.action(widget.post.id.toString());
        setState(() {});
      },
    );
  }
}
