import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:todo_app/services/api_services.dart';

class TodoProvider extends ChangeNotifier {
  //title controller
  final _title = TextEditingController();
  //get title controller
  TextEditingController get title => _title;
  //set title
  set setTitle(dynamic value) {
    _title.text = value;
  }

  //description controller
  final _description = TextEditingController();
  //get description controller
  TextEditingController get description => _description;
  //set desc
  set setDesc(dynamic value) {
    _description.text = value;
  }

  //-start add a todo
  Future<void> addTodo(BuildContext context) async {
    try {
      await ApiServices.addTodo(title.text, description.text, context)
          .then((value) {
        _title.clear();
        _description.clear();
      });
    } catch (e) {
      Logger().e(e);
    }
  }
}
