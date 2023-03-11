import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:json_annotation/json_annotation.dart';

import 'data.dart';

part 'rest_client.g.dart';

@RestApi(baseUrl: '34.22.71.66')
@JsonSerializable()
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  // @GET('/users/{id}')
  // Future<User> getUser({@Path() required int id});
  @GET('/ping')
  Future<String> ping_test();
}
