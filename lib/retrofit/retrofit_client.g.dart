// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'retrofit_client.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _RestClient implements RestClient {
  _RestClient(
    this._dio, {
    this.baseUrl,
  }) {
    baseUrl ??= 'https://www.dhlottery.co.kr';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<Loto> getTasks(
    key,
    tab,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'method': key,
      r'drwNo': tab,
    };
    final _headers = <String, dynamic>{
      r'Content-Type': 'application/json',
      r'Accept': 'application/json',
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result =
        await _dio.fetch<String>(_setStreamType<Loto>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
      contentType: 'application/json',
    )
            .compose(
              _dio.options,
              '/common.do',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    var decodeData = jsonDecode(_result.data!);
    final value = Loto.fromJson(decodeData);
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}
