class MassageModel {
  String? senderId;
  String? receiverId;
  String? text;
  String? dateTime;

  MassageModel({
    this.dateTime,
    this.senderId,
    this.receiverId,
    this.text,
  });

  MassageModel.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    senderId = json['senderId'];
    receiverId = json['receiverId'];
    dateTime = json['dateTime'];
  }

  Map<String, dynamic> toMap() {
    return {
      'text': text,
      'senderId': senderId,
      'receiverId': receiverId,
      'dateTime': dateTime,
    };
  }
}
