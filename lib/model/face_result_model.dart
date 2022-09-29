class FaceResultModel {
  String? code;
  String? state;

  static FaceResultModel fromMap(Map<String, dynamic> map) {
    FaceResultModel faceResultModelBean = FaceResultModel();
    faceResultModelBean.code = map['code'] as String?;
    faceResultModelBean.state = map['state'] as String?;
    return faceResultModelBean;
  }

  Map toJson() => {
        "code": code,
        "state": state,
      };
}
