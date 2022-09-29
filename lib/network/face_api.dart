import 'package:flutter/foundation.dart';
import 'package:flutter_face_identification/model/face_identify_model.dart';
import 'package:flutter_face_identification/model/face_result_model.dart';
import 'package:flutter_face_identification/network/http_base.dart';
import 'dart:io';

class FaceApi {
  static const String _faceGetClientUrl =
      'https://api.shmedia.tech/open-cloud-service/api/authorization/external/request';

  static Future<ServerResponse> requestFaceClient({
    required String mobile,
    String? iosClientId,
    String? androidClientId,
  }) async {
    Map<String, dynamic> params = {};
    params['mobile'] = mobile;
    params['authMode'] = 'face_sdk';
    params['clientId'] = Platform.isIOS ? iosClientId : androidClientId;
    return await HttpBase().post(_faceGetClientUrl, params: params);
  }

  static Future<ServerResponse> requestResultVerify({
    FaceResultModel? resultModel,
    FaceIdentifyModel? identifyModel,
  }) async {
    String urlPath =
        '${identifyModel?.sdkCallbackUri}?code=${resultModel?.code}&state=${resultModel?.state}';
    if (kDebugMode) {
      print('认证确认请求path = $urlPath');
    }
    return await HttpBase().post(urlPath);
  }
}
