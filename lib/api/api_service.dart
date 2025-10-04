// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api
import 'package:flutter/material.dart';
import 'package:mypaper/api/api_client.dart';
import 'package:mypaper/common/dialog/dialog_close.dart';
import 'package:mypaper/common/dialog/dialog_loader.dart';
import 'package:mypaper/common/enum/http_method_types.dart';
import 'package:mypaper/common/model/ques_mdl.dart';
import 'package:mypaper/common/model/subject_mdl.dart';
import 'package:mypaper/main.dart';
import 'package:mypaper/other/msg.dart';

class ApiService {
  BuildContext context;
  ApiClient apiClient;
  ApiService()
    : context = navigatorKey.currentState!.context,
      apiClient = ApiClient();

  Future<List<SubjectMdl>> subjects({bool isLoader = true}) async {
    try {
      if (isLoader) dialogLoader(context);
      var json = await apiClient.request(
        file: 'subject.json',
        method: HttpMethodTypes.get,
      );
      if (json.isNotEmpty) {
        var data = (json['subjects'] as List<dynamic>)
            .map((e) => SubjectMdl.fromJson(e))
            .toList();
        return data;
      }
    } catch (ex) {
      logError('ApiService/subjects', msg: ex);
      snackBarMsg(context, 'Error Api Service\nModel Mapping');
    } finally {
      if (isLoader) dialogClose(context);
    }
    return [];
  }

  Future<List<QuesMdl>> questions({
    required String file,
    bool isLoader = true,
  }) async {
    try {
      if (isLoader) dialogLoader(context);
      var json = await apiClient.request(
        file: file,
        method: HttpMethodTypes.get,
      );
      if (json.isNotEmpty) {
        var data = (json['set'] as List<dynamic>).map((e) {
          e['path'] = file;
          return QuesMdl.fromJson(e);
        }).toList();
        return data;
      }
    } catch (ex) {
      logError('ApiService/questions', msg: ex);
      snackBarMsg(context, 'Model Mapping Issue');
    } finally {
      if (isLoader) dialogClose(context);
    }
    return [];
  }
}
