import 'package:flutter/services.dart';
import 'package:flutter_face_identification/network/face_api.dart';
import 'package:flutter_face_identification/network/http_base.dart';
import 'package:flutter_face_identification/cache/sdk_data_cache.dart';

import 'model/face_identify_model.dart';
import 'model/face_result_model.dart';

class FlutterFaceIdentification {
  static const MethodChannel _methodChannel =
      MethodChannel('flutter_face_identification');

  static Future<bool> initSdk({
    required String iosClientId,
    required String androidClientId,

    ///ios 的 appUrlScheme
    required String iosAppUrlScheme,
  }) async {
    SDKDataCache().iosClientId = iosClientId;
    SDKDataCache().androidClientId = androidClientId;
    SDKDataCache().iosAppUrlScheme = iosAppUrlScheme;
    return true;
  }

  ///开始实名认证
  static Future<bool> faceIdentify({required String mobile}) async {
    ServerResponse response = await FaceApi.requestFaceClient(
      mobile: mobile,
      iosClientId: SDKDataCache().iosClientId,
      androidClientId: SDKDataCache().androidClientId,
    );
    if (response.isSuccess()) {
      Map<String, dynamic> result = response.data;
      FaceIdentifyModel model = FaceIdentifyModel.fromMap(result);
      return await _openSdk(model);
    } else {
      return Future.error(response.message ?? '网络请求异常,请稍后操作');
    }
  }

  static Future<bool> _openSdk(FaceIdentifyModel model) async {
    try {
      Map<dynamic, dynamic> result = await _methodChannel.invokeMethod(
          'realNameAuth', {
        'actionUrl': model.actionUrl,
        'iosAppUrlScheme': SDKDataCache().iosAppUrlScheme
      });
      Map<String, dynamic> params = Map.from(result);
      FaceResultModel resultModel = FaceResultModel.fromMap(params);
      return await _resultVerify(
          resultModel: resultModel, identifyModel: model);
    } on PlatformException catch (error) {
      return Future.error(error.message ?? '');
    }
  }

  static Future<bool> _resultVerify({
    FaceResultModel? resultModel,
    FaceIdentifyModel? identifyModel,
  }) async {
    ServerResponse response = await FaceApi.requestResultVerify(
        resultModel: resultModel, identifyModel: identifyModel);
    if (response.isSuccess()) {
      return true;
    } else {
      return Future.error(response.message ?? '网络请求异常,请稍后操作');
    }
  }
}
