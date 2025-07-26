import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:practice_todoapp/services/local_storage.dart';

class BaseClient {
  static var noInternetMessage = "Please check your connection!";

  /// GET Request
  static Future<http.Response> getRequest({required String api, Map<String, String>? params}) async {
    debugPrint("\nYou hit: $api");
    debugPrint("Request Params: $params");

    final StorageService storageService = Get.put(StorageService());
    String? accessToken = storageService.read<String>('accessToken');

    var headers = {
      'Content-Type': 'application/json',
      if (accessToken != null) "Authorization": "Bearer $accessToken",
    };

    final uri = Uri.parse(api).replace(queryParameters: params);
    try {
      http.Response response = await http.get(uri, headers: headers);
      return response;
    } on SocketException {
      throw noInternetMessage;
    }
  }

  /// PUT Request with Multipart data
static Future<dynamic> putMultipart(
  String api,
  Map<String, String> fields,
  Map<String, File> files,
) async {
  debugPrint("\nYou hit: $api");
  debugPrint("Fields: $fields");

  final StorageService storageService = Get.put(StorageService());
  String? accessToken = storageService.read<String>('accessToken');

  var headers = {
    'Accept': 'application/json',
    if (accessToken != null) 'Authorization': 'Bearer $accessToken',
  };

  var request = http.MultipartRequest('PUT', Uri.parse(api))
    ..fields.addAll(fields)
    ..headers.addAll(headers);

  for (var entry in files.entries) {
    request.files.add(await http.MultipartFile.fromPath(entry.key, entry.value.path));
  }

  try {
    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);
    return handleResponse(response); // Reuse your existing response handler
  } catch (e) {
    throw "PUT upload failed: ${e.toString()}";
  }
}


  /// POST Request with token and JSON encoding
  static Future<dynamic> postRequest({
    required String api,
    required Map<String, dynamic> body,
  }) async {
    debugPrint('\nYou hit: $api');
    debugPrint('Request Body: ${jsonEncode(body)}');

    final StorageService storageService = Get.put(StorageService());
    String? accessToken = storageService.read<String>('accessToken');

    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      if (accessToken != null) "Authorization": "Bearer $accessToken",
    };

    try {
      http.Response response = await http.post(
        Uri.parse(api),
        body: jsonEncode(body),
        headers: headers,
      );

      return handleResponse(response);
    } on SocketException {
      throw noInternetMessage;
    } on FormatException {
      throw "Bad response format";
    } catch (e) {
      throw "POST Error: ${e.toString()}";
    }
  }

  /// DELETE Request
  static Future<http.Response> deleteRequest({required String api, Map<String, dynamic>? body}) async {
    debugPrint('\nYou hit: $api');
    debugPrint('Request Body: ${jsonEncode(body)}');

    final StorageService storageService = Get.put(StorageService());
    String? accessToken = storageService.read<String>('accessToken');

    var headers = {
      'Accept': 'application/json',
      if (accessToken != null) "Authorization": "Bearer $accessToken",
    };

    try {
      http.Response response = await http.delete(
        Uri.parse(api),
        body: body != null ? jsonEncode(body) : null,
        headers: headers,
      );
      return response;
    } on SocketException {
      throw noInternetMessage;
    }
  }

  /// PATCH Request
  static Future<dynamic> patchMultipart(
  String api,
  Map<String, String> fields,
  Map<String, File> files,
) async {
  debugPrint("\nPATCH: $api");
  debugPrint("Fields: $fields");

  final StorageService storageService = Get.put(StorageService());
  String? accessToken = storageService.read<String>('accessToken');

  var headers = {
    'Accept': 'application/json',
    if (accessToken != null) 'Authorization': 'Bearer $accessToken',
  };

  var request = http.MultipartRequest('PATCH', Uri.parse(api))
    ..fields.addAll(fields)
    ..headers.addAll(headers);

  for (var entry in files.entries) {
    request.files.add(await http.MultipartFile.fromPath(entry.key, entry.value.path));
  }

  try {
    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);
    return handleResponse(response);
  } catch (e) {
    throw "PATCH upload failed: ${e.toString()}";
  }
}


  /// Multipart POST Request
  static Future<dynamic> multipartAddRequest({
    required String api,
    required Map<String, String> body,
    File? file,
  }) async {
    debugPrint("\nYou hit: $api");
    debugPrint("Request body: $body");

    final StorageService storageService = Get.put(StorageService());
    String? accessToken = storageService.read<String>('accessToken');

    var headers = {
      'Accept': 'application/json',
      if (accessToken != null) 'Authorization': 'Bearer $accessToken',
    };

    var request = http.MultipartRequest('POST', Uri.parse(api))
      ..fields.addAll(body)
      ..headers.addAll(headers);

    if (file != null) {
      request.files.add(
        await http.MultipartFile.fromPath('file', file.path),
      );
    }

    try {
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);
      return handleResponse(response);
    } catch (e) {
      throw "Upload failed: ${e.toString()}";
    }
  }

  /// Unified Response Handler
  static dynamic handleResponse(http.Response response) {
    try {
      if (response.statusCode >= 200 && response.statusCode <= 210) {
        debugPrint('SuccessCode: ${response.statusCode}');
        debugPrint('SuccessResponse: ${response.body}');

        if (response.body.isNotEmpty) {
          return json.decode(response.body);
        } else {
          return response.body;
        }
      } else if (response.statusCode == 500) {
        debugPrint("Server Error: 500");
        throw "Server Error";
      } else {
        debugPrint('ErrorCode: ${response.statusCode}');
        debugPrint('ErrorResponse: ${response.body}');

        String msg = "Something went wrong";
        if (response.body.isNotEmpty) {
          var decoded = jsonDecode(response.body);
          var data = decoded['errors'];

          if (data == null) {
            msg = decoded['message'] ?? msg;
          } else if (data is String) {
            msg = data;
          } else if (data is Map && data.containsKey('email')) {
            msg = data['email'][0];
          }
        }

        throw msg;
      }
    } on SocketException {
      throw noInternetMessage;
    } on FormatException {
      throw "Bad response format";
    } catch (e) {
      throw e.toString();
    }
  }

  /// Extra POST Request with Optional Headers
  static Future<dynamic> postRequestWithHeaders({
    required String api,
    required Map<String, dynamic> body,
    Map<String, String>? headers,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(api),
        headers: headers ?? {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(body),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return jsonDecode(response.body);
      } else {
        throw Exception(
            'Failed POST: ${response.statusCode} ${response.body}');
      }
    } on SocketException {
      throw noInternetMessage;
    } on FormatException {
      throw "Invalid response format.";
    } catch (e) {
      throw "POST Error: ${e.toString()}";
    }
  }
}
