class PostModel {
  String? postText;
  String? postImageUrl;
  String? userName;
  String? userImage;
  String? postId;
  String? postTime;

// Constructor
  PostModel({
    this.postText,
    this.postImageUrl,
    this.userName,
    this.userImage,
    this.postId,
    this.postTime,
  });

  // named Constructor

  PostModel.fromJson(Map<String, dynamic> json) {
    postText = json['postText'];
    postImageUrl = json['postImageUrl'];
    userName = json['userName'];
    userImage = json['userImage'];
    postId = json['postId'];
    postTime = json['postTime'];
  }

  Map<String, dynamic> toMap() {
    return {
      'postText': postText,
      'postImageUrl': postImageUrl,
      'userName': userName,
      'userImage': userImage,
      'postId': postId,
      'postTime': postTime,
    };
  }
}
