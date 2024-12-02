import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/components/custom_button.dart';
import 'package:todo_app/components/custom_text_field.dart';
import 'package:todo_app/provider/todo_provider.dart';
import 'package:todo_app/services/api_services.dart';
import 'package:todo_app/utils/alert_helper.dart';
import 'package:todo_app/utils/size_config.dart';

class AddTodo extends StatefulWidget {
  const AddTodo({
    super.key,
    this.todo,
  });

  final Map? todo;

  @override
  State<AddTodo> createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  final controller = TextEditingController();
  bool isEdit = false;

  @override
  void initState() {
    super.initState();
    final todo = widget.todo;
    final provider = Provider.of<TodoProvider>(context, listen: false);
    if (todo != null) {
      isEdit = true;
      final title = todo['title'];
      final description = todo['description'];
      if (isEdit == true) {
        provider.setTitle = title;
        provider.setDesc = description;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TodoProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? "Edit Todo" : "Add Todo"),
        centerTitle: true,
      ),
      body: Container(
        width: SizeConfig.w(context),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(children: [
          const SizedBox(height: 50),
          CustomTextField(
            controller: provider.title,
            hintTxt: "Title",
          ),
          const SizedBox(height: 30),
          CustomTextField(
            controller: provider.description,
            hintTxt: "Description",
            minLines: 2,
            maxLines: 8,
          ),
          const SizedBox(height: 100),
          CustomButton(
            text: isEdit ? "Update" : "Add Todo",
            onTap: () {
              isEdit ? updateTodoData() : provider.addTodo(context);
            },
            color: const Color.fromARGB(255, 0, 9, 133),
          )
        ]),
      ),
    );
  }

  Future<void> updateTodoData() async {
    final todo = widget.todo;
    final provider = Provider.of<TodoProvider>(context, listen: false);
    if (todo == null) {
      print('You can not call update without todo data');
      return;
    }
    final id = todo['_id'];
    Map<String, dynamic> body = {
      "title": provider.title.text,
      "description": provider.description.text,
      "is_completed": false,
    };
    final isSuccess = await ApiServices.updateTodo(id, body);

    if (isSuccess) {
      // ignore: use_build_context_synchronously
      AlertHelper.showSuccessMessage(context,
          message: 'Todo Updation Successfully');
    } else {
      // ignore: use_build_context_synchronously
      AlertHelper.showErrorMessage(context, message: 'Todo Updating Failed');
    }
  }
}
