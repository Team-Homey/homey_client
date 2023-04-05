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
  Future<String?> joinFamily(
      {@Header('Authorization') required token, @Body() required jsondata});

  /// Family
  @POST('/family')
  Future<Family> createFamily(
      {@Header('Authorization') required token, @Body() required jsondata});

  @GET('/family/my-family')
  Future<FamilyInfo> getMyFamily({@Header('Authorization') required token});

  /// Photo
  @GET('/photo/family')
  Future<List<Photo>> getFamilyPhoto({@Header('Authorization') required token});

  @POST('/photo/content')
  Future<Photo> uploadPhotoTitle(
      {@Header('Authorization') required token, @Body() required jsondata});

  @POST('/photo/{id}')
  Future<String?> uploadPhoto(
      {@Header('Authorization') required token,
      @Path() required int id,
      @Body() required jsondata});
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
    required this.name,
    required this.age,
    required this.gender,
    required this.address,
    required this.picture,
    required this.regDate,
    required this.birth,
    required this.familyRole,
  });
  int? id;
  String email;
  String? name;
  int? age;
  String? gender;
  String? address;
  String? picture;
  String? regDate;
  String? birth;
  String? familyRole;
  String? emotion;

  // factory with null safety
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
class FamilyInfo {
  FamilyInfo({
    required this.id,
    required this.name,
    required this.code,
    required this.regDate,
    required this.point,
    required this.users,
  });

  int id;
  String name;
  String code;
  String regDate;
  int point;
  List<User> users;

  factory FamilyInfo.fromJson(Map<String, dynamic> json) =>
      _$FamilyInfoFromJson(json);
  Map<String, dynamic> toJson() => _$FamilyInfoToJson(this);
}

class Photo {
  Photo({
    required this.id,
    required this.image,
    required this.title,
    required this.regDate,
  });

  int id;
  String? image;
  String title;
  String regDate;

  factory Photo.fromJson(Map<String, dynamic> json) => Photo(
        id: json['id'],
        image: json['iamge'],
        title: json['title'],
        regDate: json['regDate'],
      );
}
