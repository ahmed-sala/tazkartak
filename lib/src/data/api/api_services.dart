import 'package:dio/dio.dart' hide DioMediaType;
import 'package:injectable/injectable.dart';
import 'package:retrofit/http.dart';

import 'api_constants.dart';

part 'api_services.g.dart';

@singleton
@injectable
@RestApi(baseUrl: ApiConstants.baseUrl)
abstract interface class ApiServices {
  @factoryMethod
  factory ApiServices(Dio dio) = _ApiServices;
}
