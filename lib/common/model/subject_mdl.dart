class SubjectMdl {
  int id;
  String name;
  String file;

  SubjectMdl({required this.id, required this.name, required this.file});

  factory SubjectMdl.fromJson(Map<String, dynamic> json) =>
      SubjectMdl(id: json['id'], name: json["name"], file: json["file"]);

  Map<String, dynamic> toJson() => {"id": id, "name": name, "file": file};
}
