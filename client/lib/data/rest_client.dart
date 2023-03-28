import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:json_annotation/json_annotation.dart';

part 'rest_client.g.dart';

//34.22.71.66
@RestApi(baseUrl: 'http://34.22.71.66')
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  // @GET('/users/{id}')
  // Future<User> getUser({@Path() required int id});

  /// Ping
  @GET('/ping')
  Future<String> pingTest();

  /// Authentication
  @POST('/authentication')
  Future<Data> authentication({@Body() required jsondata});

  @POST('/authentication/refresh')
  Future<String> refreshAuthentication({@Body() required refreshToken});

  /// User
  @PATCH('/user')
  Future<String> updateMyInfo(
      {@Header('Authorization') required token, @Body() required jsondata});

  @GET('/user/my-info')
  Future<User> getMyInfo({@Header('Authorization') required token});

  @GET('/user/my-info')
  Future<String> getMyInfoString({@Header('Authorization') required token});

  @POST('/user/family')
  Future<String> joinFamily(
      {@Header('Authorization') required token, @Body() required jsondata});

  /// Family
  @POST('/family')
  Future<Family> createFamily(
      {@Header('Authorization') required token, @Body() required jsondata});

  @GET('/family/my-family')
  Future<FamilyMember> getMyFamily({@Header('Authorization') required token});

  @GET('/family/my-family')
  Future<String> getMyFamilyString({@Header('Authorization') required token});
}

@JsonSerializable()
class Data {
  Data({
    required this.accessToken,
    required this.refreshToken,
    required this.alreadyRegistered,
  });

  String accessToken;
  String refreshToken;
  bool alreadyRegistered;

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);
  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class User {
  User({
    required this.id,
    required this.email,
    required this.age,
    required this.gender,
    required this.address,
    required this.picture,
    required this.regDate,
    required this.birth,
    required this.familyRole,
    required this.emotion,
  });
  String id;
  String email;
  int age;
  String gender;
  String address;
  String picture;
  String regDate;
  String birth;
  String familyRole;
  String emotion;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}

@JsonSerializable()
class Family {
  Family({
    required this.id,
    required this.name,
    required this.code,
    required this.regDate,
  });

  int id;
  String name;
  String code;
  String regDate;

  factory Family.fromJson(Map<String, dynamic> json) => _$FamilyFromJson(json);
  Map<String, dynamic> toJson() => _$FamilyToJson(this);
}

@JsonSerializable()
class FamilyMember {
  FamilyMember({
    required this.id,
    required this.name,
    required this.code,
    required this.regDate,
    required this.users,
  });

  int id;
  String name;
  String code;
  String regDate;
  List<User> users;

  factory FamilyMember.fromJson(Map<String, dynamic> json) =>
      _$FamilyMemberFromJson(json);
  Map<String, dynamic> toJson() => _$FamilyMemberToJson(this);
}
