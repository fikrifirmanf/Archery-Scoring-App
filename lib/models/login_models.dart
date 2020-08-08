// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(String str) =>
    LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  String token;
  String tokenType;
  int expiresIn;

  LoginModel({
    this.token,
    this.tokenType,
    this.expiresIn,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        token: json["token"],
        tokenType: json["token_type"],
        expiresIn: json["expires_in"],
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "token_type": tokenType,
        "expires_in": expiresIn,
      };
}

class LoginError {
  String message;

  LoginError({this.message});

  LoginError.fromJson(Map<String, dynamic> json) {
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    return data;
  }
}
