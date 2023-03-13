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
  Future<String> authenticationTest({@Body() required email});

  @POST('/authentication/refresh')
  Future<String> refreshAuthentication({@Body() required refreshToken});

  // /// User
  // @PATCH('/user')
  // Future<User> updateUser({@Body() required User user});

  // @GET('/user/{id}')
  // Future<User> getUser({@Path() required int id});

  // @GET('/user/my-info')
  // Future<User> getMyInfo();

  // @POST('/user/emotion')
  // Future<String> updateEmotion({@Body() required String emotion});

  // @POST('/user/family')
  // Future<String> updateFamily({@Body() required String familyCode});

  // /// Family
  // @POST('/family')
  // Future<String> createFamily({@Body() required String familyName});

  // @GET('/family/my-family')
  // Future<String> getMyFamily();

  /// Photo

  /// Question
  /// Answer
  /// Comment
  /// Recomme
}

@JsonSerializable()
class User {
  User({
    required this.data,
  });

  Data data;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}

@JsonSerializable()
class Data {
  Data({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.avatar,
  });

  int id;
  String email;
  @JsonKey(name: 'first_name')
  String firstName;
  @JsonKey(name: 'last_name')
  String lastName;
  String avatar;

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);
  Map<String, dynamic> toJson() => _$DataToJson(this);
}
