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

  /// Authentication with name, email, picture
  @POST('/authentication')
  Future<Data> authentication({@Body() required jsondata});

  @POST('/authentication/refresh')
  Future<String> refreshAuthentication({@Body() required refreshToken});

  // @GET('/user/my-info')
  // Future<User> getMyInfo();

  /// Family
  @POST('/family')
  Future<Family> createFamily(
      {@Header('Authorization') required token, @Body() required jsondata});
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
