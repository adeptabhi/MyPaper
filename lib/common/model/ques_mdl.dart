class QuesMdl {
  int id;
  int topicId;
  String topic;
  String question;
  List<String> options;
  int answer;
  int userAnswer;

  QuesMdl({
    required this.id,
    required this.topicId,
    required this.topic,
    required this.question,
    required this.options,
    required this.answer,
    required this.userAnswer,
  });

  factory QuesMdl.fromJson(Map<String, dynamic> json) => QuesMdl(
    id: json["id"],
    topicId: json["topicId"],
    topic: json["topic"],
    question: json["question"],
    options: List<String>.from(json["options"].map((x) => x)),
    answer: json["answer"],
    userAnswer: -1,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "topicId": topicId,
    "topic": topic,
    "question": question,
    "options": List<dynamic>.from(options.map((x) => x)),
    "answer": answer,
  };

  bool get isAns => userAnswer >= 0;
  bool get isNotAns => userAnswer < 0;
  bool get isRightAns => userAnswer == answer;
}
