class FaceIdentifyModel {
  String? actionUrl;
  String? sdkCallbackUri;

  static FaceIdentifyModel fromMap(Map<String, dynamic> map) {
    FaceIdentifyModel faceIdentifyModelBean = FaceIdentifyModel();
    faceIdentifyModelBean.actionUrl = map['actionUrl'] as String?;
    faceIdentifyModelBean.sdkCallbackUri = map['sdkCallbackUri'] as String?;
    return faceIdentifyModelBean;
  }

  Map toJson() => {
        "actionUrl": actionUrl,
        "sdkCallbackUri": sdkCallbackUri,
      };
}
