import 'dart:convert';

class QuesMdl {
  int id;
  String question;
  List<String> options;
  int answer;
  int userAnswer;
  String path;
  bool isBookmark;
  bool isValid;
  bool ansIsVisible = false;

  QuesMdl({
    required this.id,
    required this.question,
    required this.options,
    required this.answer,
    required this.userAnswer,
    required this.path,
    required this.isBookmark,
    required this.isValid,
  });

  factory QuesMdl.fromJson(Map<String, dynamic> json) => QuesMdl(
    id: json["id"],
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
    isBookmark: (json['isBookmark'] ?? 0) == 1 ? true : false,
    isValid: (json['isValid'] ?? 1) == 1 ? true : false,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "question": question,
    "options": jsonEncode(List<dynamic>.from(options.map((x) => x))),
    "answer": answer,
    "userAnswer": userAnswer,
    "path": path,
    "isBookmark": isBookmark ? 1 : 0,
    "isValid": isValid ? 1 : 0,
  };

  @override
  String toString() {
    return "Question: $question\n Option:$options";
  }

  bool get isAns => userAnswer >= 0;
  bool get isNotAns => userAnswer < 0;
  bool get isRightAns => userAnswer == answer;
}
