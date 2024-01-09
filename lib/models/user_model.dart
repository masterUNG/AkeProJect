import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserModel {
  final String username;
  final String citizenid;
  final String email;
  final String phoneNumber;
  final String preName;
  final String firstName;
  final String lastName;
  final String token;
  final String expiration;
  final String? password;
  final String? pincode;
  UserModel({
    required this.username,
    required this.citizenid,
    required this.email,
    required this.phoneNumber,
    required this.preName,
    required this.firstName,
    required this.lastName,
    required this.token,
    required this.expiration,
    this.password,
    this.pincode,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'username': username,
      'citizenid': citizenid,
      'email': email,
      'phoneNumber': phoneNumber,
      'preName': preName,
      'firstName': firstName,
      'lastName': lastName,
      'token': token,
      'expiration': expiration,
      'password': password,
      'pincode': pincode,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      username: (map['username'] ?? '') as String,
      citizenid: (map['citizenid'] ?? '') as String,
      email: (map['email'] ?? '') as String,
      phoneNumber: (map['phoneNumber'] ?? '') as String,
      preName: (map['preName'] ?? '') as String,
      firstName: (map['firstName'] ?? '') as String,
      lastName: (map['lastName'] ?? '') as String,
      token: (map['token'] ?? '') as String,
      expiration: (map['expiration'] ?? '') as String,
      password: map['password'] ?? '',
      pincode: map['pincode'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
