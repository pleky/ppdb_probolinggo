class LoginResponse {
  String uid;
  String token;

  LoginResponse({this.uid = '', this.token = ''});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      uid: json['uid'],
      token: json['token'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'token': token,
    };
  }
}
