class CommentModel {
  final int postId, id;
  final String name, email, body;

  CommentModel(
      {required this.postId,
      required this.id,
      required this.name,
      required this.email,
      required this.body});
  factory CommentModel.fromJsObject(dynamic jsobject) {
    return CommentModel(
        postId: int.parse(jsobject["postId"].toString()),
        id: int.parse(jsobject["id"].toString()),
        name: jsobject["name"],
        email: jsobject["email"],
        body: jsobject["body"]);
  }
  Map<String,dynamic> toMap(){
    return {
      "postId":postId,

      "id":id,
      "name":name,
      "body":body,
      "email":email,
    };
  }
}
