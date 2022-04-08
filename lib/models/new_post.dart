class NewPostModel {
  String? postText;
  String? postDate;
  String? postImage;
  String? postTag;
  String? postId;

  NewPostModel({
    this.postDate,
    this.postText,
    this.postImage,
    this.postTag,
    this.postId,
  });

  NewPostModel.fromJosn(Map<String, dynamic> json) {
    postDate = json['postDate'];
    postText = json['postText'];
    postImage = json['postImage'];
    postTag = json['postTag'];
    postId = json['postId'];
  }

  Map<String, dynamic> toMap() {
    return {
      'postDate': postDate,
      'postText': postText,
      'postImage': postImage,
      'postTag': postTag,
      'postId': postId,
    };
  }
}
