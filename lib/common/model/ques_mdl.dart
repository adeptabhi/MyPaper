import 'dart:convert';

class QuesMdl {
  int id;
  String topic;
  String question;
  List<String> options;
  int answer;
  int userAnswer;
  String path;
  bool ansIsVisible = false;
  QuesMdl({
    required this.id,
    required this.topic,
    required this.question,
    required this.options,
    required this.answer,
    required this.userAnswer,
    required this.path,
  });

  factory QuesMdl.fromJson(Map<String, dynamic> json) => QuesMdl(
    id: json["id"],
    topic: json["topic"],
    question: json["question"],
    options: List<String>.from(
      (json["options"] is String
              ? jsonDecode(json["options"])
              : json["options"])
          .map((x) => x),
    ),
    answer: json["answer"],
    userAnswer: json["userAnswer"] ?? -1,
    path: json['path'],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "topic": topic,
    "question": question,
    "options": jsonEncode(List<dynamic>.from(options.map((x) => x))),
    "answer": answer,
    "userAnswer": userAnswer,
    "path": path,
  };

  bool get isAns => userAnswer >= 0;
  bool get isNotAns => userAnswer < 0;
  bool get isRightAns => userAnswer == answer;
}
