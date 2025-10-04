import 'package:mypaper/common/enum/set_status.dart';

class SetMdl {
  int id;
  int subId;
  String name;
  String file;
  bool isImp;
  SetStatus setStatus;
  SetMdl({
    required this.id,
    required this.subId,
    required this.name,
    required this.file,
    required this.isImp,
    required this.setStatus,
  });
  factory SetMdl.fromJson(Map<String, dynamic> json) => SetMdl(
    id: json["id"],
    subId: (json["subId"] ?? 0) + 96,
    name: json["name"],
    file: json["file"],
    isImp: (json["isImp"] ?? 0) == 1,
    setStatus: (json["status"] ?? 0) == 0
        ? SetStatus.pending
        : SetStatus.completed,
  );
  Map<String, dynamic> toJson() => {
    "id": id,
    "subId": subId - 96,
    "name": name,
    "file": file,
    "isImp": isImp ? 1 : 0,
    "status": setStatus == SetStatus.pending ? 0 : 1,
  };
}
