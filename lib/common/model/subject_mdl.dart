class SubjectMdl {
  int id;
  String name;
  String folder;
  List<SetMdl> sets;

  SubjectMdl({
    required this.id,
    required this.name,
    required this.folder,
    required this.sets,
  });

  factory SubjectMdl.fromJson(Map<String, dynamic> json) => SubjectMdl(
    id: json['id'],
    name: json["name"],
    folder: json["folder"],
    sets: (json['sets'] as List<dynamic>)
        .map((e) => SetMdl.fromJson(e))
        .toList(),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "folder": folder,
    "sets": sets,
  };
}

class SetMdl {
  int id;
  String name;
  String file;

  SetMdl({required this.id, required this.name, required this.file});
  factory SetMdl.fromJson(Map<String, dynamic> json) =>
      SetMdl(id: json["id"], name: json["name"], file: json["file"]);
  Map<String, dynamic> toJson() => {"id": id, "name": name, "file": file};
}
