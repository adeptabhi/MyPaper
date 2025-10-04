import 'package:mypaper/common/model/set_mdl.dart';

class SubjectMdl {
  int id;
  String section;
  String name;
  String path;
  List<SetMdl> sets;

  SubjectMdl({
    required this.id,
    required this.section,
    required this.name,
    required this.path,
    required this.sets,
  });

  factory SubjectMdl.fromJson(Map<String, dynamic> json) => SubjectMdl(
    id: json['id'],
    section: json['section'],
    name: json["name"],
    path: json["path"],
    sets: (json['sets'] as List<dynamic>)
        .map((e) => SetMdl.fromJson(e))
        .toList(),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "folder": path,
    "sets": sets,
  };
}
