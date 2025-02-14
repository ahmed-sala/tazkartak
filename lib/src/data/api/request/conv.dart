import 'dart:convert';

import 'package:dio/dio.dart';

class StripeJsonConverter implements Converter {
  const StripeJsonConverter();

  RequestOptions convertRequest(RequestOptions options) => options;

  Response<T> convertResponse<T>(Response response) {
    return Response<T>(
      data: response.data as T,
      headers: response.headers,
      requestOptions: response.requestOptions,
      statusCode: response.statusCode,
      statusMessage: response.statusMessage,
    );
  }

  @override
  Stream bind(Stream stream) {
    // TODO: implement bind
    throw UnimplementedError();
  }

  @override
  Converter<RS, RT> cast<RS, RT>() {
    // TODO: implement cast
    throw UnimplementedError();
  }

  @override
  convert(input) {
    // TODO: implement convert
    throw UnimplementedError();
  }

  @override
  Converter<dynamic, TT> fuse<TT>(Converter<dynamic, TT> other) {
    // TODO: implement fuse
    throw UnimplementedError();
  }

  @override
  Sink startChunkedConversion(Sink sink) {
    // TODO: implement startChunkedConversion
    throw UnimplementedError();
  }
}
