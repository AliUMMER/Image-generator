import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart';

import 'api_exception.dart';

class ApiClient {
  Future<Response> invokeAPI(String path, String method, Object? body) async {
    Map<String, String> headerParams = {};
    Response response;

    String url = path;
    print(url);

    final nullableHeaderParams = (headerParams.isEmpty) ? null : headerParams;
    print(body);
    switch (method) {
      case "POST":
        response = await post(
          Uri.parse(url),
          headers: {
            'Content-Type': 'application/json', // Correct header
            'X-RapidAPI-Key':
                '041be7ffc5msh55d5ca316ebcc05p136a60jsn6b028dbc972a',
            'X-RapidAPI-Host': 'ai-image-generator14.p.rapidapi.com',
          },
          body: jsonEncode(body), // Ensure body is encoded to JSON string
        );
        break;
      case "PUT":
        response = await put(
          Uri.parse(url),
          headers: {
            // 'Content-Type': 'application/json', // Correct header
            // 'X-RapidAPI-Key':
            //     'a3c2b37721mshb0fc7447dae012dp121961jsn7e1fa8577e8a',
            // 'X-RapidAPI-Host': 'ai-image-generator14.p.rapidapi.com',
            // 'Accept': 'application/json',
          },
          body: jsonEncode(body), // Ensure body is encoded to JSON string
        );
        break;
      case "DELETE":
        response = await delete(Uri.parse(url), headers: {}, body: body);
        break;
      case "POST_":
        response = await post(
          Uri.parse(url),
          headers: {
            // 'Content-Type': 'application/json', // Correct header
            // 'X-RapidAPI-Key':
            //     'a3c2b37721mshb0fc7447dae012dp121961jsn7e1fa8577e8a',
            // 'X-RapidAPI-Host': 'ai-image-generator14.p.rapidapi.com',
            // 'Accept': 'application/json',
          },
          body: jsonEncode(body), // Ensure body is encoded to JSON string
        );
        break;
      case "GET_":
        response = await post(
          Uri.parse(url),
          headers: {},
          body: body,
        );
        break;
      case "GET":
        response = await get(
          Uri.parse(url),
          headers: {
            // 'X-RapidAPI-Key':
            //     'aefacc1a2dmsh9a0a1059b2dd456p1bd82ejsna6371ca3290b',
            // 'X-RapidAPI-Host': 'imdb-top-100-movies.p.rapidapi.com',
            // 'Accept': 'application/json',
            // 'Content-Type': 'application/json'
          },
        );
        break;
      case "PATCH":
        response = await patch(
          Uri.parse(url),
          headers: {'Content-Type': 'application/json'},
          body: body,
        );
        break;
      case "PATCH1":
        response = await patch(
          Uri.parse(url),
          headers: {},
          body: body,
        );
        break;
      default:
        response = await get(Uri.parse(url), headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json'
        });
    }

    print('status of $path =>' + (response.statusCode).toString());
    print(response.body);
    if (response.statusCode >= 400) {
      log(path +
          ' : ' +
          response.statusCode.toString() +
          ' : ' +
          response.body);

      throw ApiException(_decodeBodyBytes(response), response.statusCode);
    }
    return response;
  }

  String _decodeBodyBytes(Response response) {
    var contentType = response.headers['content-type'];
    if (contentType != null && contentType.contains("application/json")) {
      return jsonDecode(response.body)['message'];
    } else {
      return response.body;
    }
  }
}
