import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:todo_app/utils/alert_helper.dart';

//---------------All todo api services call will be here---------------------

class ApiServices {
  //--------------------------delete api------------------------------
  static Future<bool> deleteById(String id) async {
    //-delete the item
    final url = 'https://api.nstack.in/v1/todos/$id';
    final uri = Uri.parse(url);
    var response = await http.delete(uri);
    return response.statusCode == 200;
  }

  //--------------------------fetch api------------------------------
  static Future<List?> fetchTodos() async {
    //retrieve data from the server
    const url = 'https://api.nstack.in/v1/todos?page=1&limit=10';
    final uri = Uri.parse(url);
    var response = await http.get(uri);

    Logger().wtf(response.body);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as Map;
      final result = json['items'] as List;
      return result;
    } else {
      return null;
    }
  }

  //--------------------------update api------------------------------
  static Future<bool> updateTodo(String id, Map body) async {
    //send updated data to the server
    final url = 'https://api.nstack.in/v1/todos/$id';
    final uri = Uri.parse(url);
    var response = await http.put(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );
    return response.statusCode == 200;
  }

  //--------------------------add api------------------------------

  static Future<void> addTodo(
      String title, String description, BuildContext context) async {
    try {
      Map<String, dynamic> body = {
        "title": title,
        "description": description,
        "is_completed": false,
      };

      //submit data to the server
      const url = 'https://api.nstack.in/v1/todos';
      final uri = Uri.parse(url);
      var response = await http.post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );

      if (response.statusCode == 201) {
        Logger().v(response.body);
        // ignore: use_build_context_synchronously
        AlertHelper.showSuccessMessage(context,
            message: 'Todo Added Successfully');
      } else {
        Logger().e(response.body);
        // ignore: use_build_context_synchronously
        AlertHelper.showErrorMessage(context, message: 'Todo Adding Failed');
      }

      // return json.decode(response.body);
    } catch (e) {
      Logger().e(e);
      throw Exception(e.toString());
    }
  }
}
