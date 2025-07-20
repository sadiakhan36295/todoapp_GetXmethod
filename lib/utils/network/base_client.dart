import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:practice_todoapp/services/local_storage.dart';


class BaseClient {
  static var noInternetMessage = "Please check your connection!";

  static getRequest({required String api, params}) async {
    debugPrint("\nYou hit: $api");
    debugPrint("Request Params: $params");

    /// get x storage
    final StorageService storageService = Get.put(StorageService());
    String? accessToken = storageService.read<String>('accessToken');

    var headers = {
      'Content-type': 'application/json',
      "Authorization": "Bearer $accessToken",
    };
    debugPrint("statusCode: id: ");

    http.Response response = await http.get(
      Uri.parse(api).replace(queryParameters: params),
      headers: headers,
    );
    return response;
  }

  static postRequest({required String api, body}) async {
    debugPrint('\nYou hit: $api');
    debugPrint('Request Body: ${jsonEncode(body)}');

    /// get x storage
    final StorageService storageService = Get.put(StorageService());
    String? accessToken = storageService.read<String>('accessToken');

    var headers = {
      'Accept': 'application/json',
      "Authorization": "Bearer $accessToken",
    };

    http.Response response = await http.post(
      Uri.parse(api),
      body: body,
      headers: headers,
      encoding: Encoding.getByName("utf-8"),
    );
    return response;
  }

  static deleteRequest({required String api, body}) async {
    debugPrint('\nYou hit: $api');
    debugPrint('Request Body: ${jsonEncode(body)}');

    /// get x storage
    final StorageService _storageService = Get.put(StorageService());
    String? accessToken = _storageService.read<String>('accessToken');

    var headers = {
      'Accept': 'application/json',
      "Authorization": "Bearer $accessToken",
    };

    http.Response response = await http.delete(
      Uri.parse(api),
      body: body,
      headers: headers,
    );
    return response;
  }

  // Add PATCH method here
  static patchRequest({
    required String api,
    required Map<String, dynamic> body,
  }) async {
    debugPrint('\nYou hit: $api');
    debugPrint('Request Body: ${jsonEncode(body)}');

    /// get x storage
    final StorageService storageService = Get.put(StorageService());
    String? accessToken = storageService.read<String>('accessToken');

    var headers = {
      'Content-type': 'application/json',
      "Authorization": "Bearer $accessToken",
    };

    try {
      http.Response response = await http.patch(
        Uri.parse(api),
        body: jsonEncode(body),
        headers: headers,
      );
      return response;
    } on SocketException {
      throw noInternetMessage;
    } catch (e) {
      throw e.toString();
    }
  }


  /// multipart request make
  static Future<dynamic> multipartAddRequest({
    required String api,
    required Map<String, String> body,
    File? file, // Optional File
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



  /// for handle the response

  static handleResponse(http.Response response) async {
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
    } on SocketException catch (_) {
      throw noInternetMessage;
    } on FormatException catch (_) {
      throw "Bad response format";
    } catch (e) {
      throw e.toString();
    }
  }
}