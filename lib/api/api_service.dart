// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mypaper/api/api_client.dart';
import 'package:mypaper/main.dart';

class ApiService {
  BuildContext context;
  ApiClient apiClient;
  ApiService()
    : context = navigatorKey.currentState!.context,
      apiClient = ApiClient();

  // Future<PaperMdl>> getPaper({
  //   required String paperCode,
  //   bool isLoader = true,
  // }) async {
  //   var apiServiceMdl = ApiServiceMdl<PaperMdl>();
  //   try {
  //     if (isLoader) dialogLoader(context);
  //     var json = await apiClient.request(
  //       path: ApiEndPoint.inst.getPaper,
  //       method: HttpMethodTypes.post,
  //       payload: {"userId": UtilData.userMdl.id, "testCode": paperCode},
  //     );
  //     if (json.isNotEmpty) {
  //       apiServiceMdl.data = PaperMdl.fromJson(json['Data']);
  //       apiServiceMdl.isSuccess = true;
  //     }
  //   } catch (ex) {
  //     logError('ApiService/paper', msg: ex);
  //   } finally {
  //     if (isLoader) dialogClose(context);
  //   }
  //   return apiServiceMdl;
  // }
}
