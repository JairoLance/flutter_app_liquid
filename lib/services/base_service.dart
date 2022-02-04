import 'dart:convert';

import 'package:flutter_app_liquid/helpers/shared_preferences_helper.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class BaseService extends http.BaseClient {
  String tokens;
  Map<String, String> _defaultHeaders;

  http.Client _httpClient = http.Client();

  /*Base de inicializacion del encabezado*/
  void initHeadersState() async {
    SessionManager SessionM = SessionManager();
    var authToken = await SessionM.getAuthToken();
    this._defaultHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${authToken.toString()}'
    };
  }

  @override
  Future<Response> createPost(String url, {Map body}) async {
    return await http.post(url,
        body: body,
        headers: {"Authorization": "Bearer"}).then((http.Response response) {
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error while fetching data");
      }
      return json.decode(response.body);
    });
  }
  // BaseService(this._defaultHeaders);

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    return _httpClient.send(request);
  }

  @override
  Future<Response> get(url, {Map<String, String> headers}) {
    return _httpClient.get(url, headers: _mergedHeaders(headers));
  }

  @override
  Future<Response> post(url,
      {Map<String, String> headers, dynamic body, Encoding encoding}) async {
    await initHeadersState();
    //print("Este es lo que espero ---> " + _mergedHeaders(headers).toString());
    return _httpClient.post(url,
        headers: _mergedHeaders(headers), body: body, encoding: encoding);
  }

  @override
  Future<Response> patch(url,
      {Map<String, String> headers, dynamic body, Encoding encoding}) {
    return _httpClient.patch(url,
        headers: _mergedHeaders(headers), body: body, encoding: encoding);
  }

  @override
  Future<Response> put(url,
      {Map<String, String> headers, dynamic body, Encoding encoding}) {
    return _httpClient.put(url,
        headers: _mergedHeaders(headers), body: body, encoding: encoding);
  }

  @override
  Future<Response> head(url, {Map<String, String> headers}) {
    return _httpClient.head(url, headers: _mergedHeaders(headers));
  }

  @override
  Future<Response> delete(url, {Map<String, String> headers}) {
    return _httpClient.delete(url, headers: _mergedHeaders(headers));
  }

  Map<String, String> _mergedHeaders(Map<String, String> headers) =>
      {...?_defaultHeaders, ...?headers};
}
