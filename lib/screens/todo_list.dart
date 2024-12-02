import 'package:flutter/material.dart';
import 'package:todo_app/components/custom_text.dart';
import 'package:todo_app/screens/add_todo.dart';
import 'package:todo_app/screens/widgets/todo_card.dart';
import 'package:todo_app/services/api_services.dart';
import 'package:todo_app/utils/alert_helper.dart';
import 'package:todo_app/utils/app_colors.dart';
import 'package:todo_app/utils/util_funtions.dart';

class TodoList extends StatefulWidget {
  const TodoList({super.key});

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  @override
  void initState() {
    super.initState();
    fetchTodoData();
  }

  // get list from provider and declare to the list
  List items = [];
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List'),
        centerTitle: true,
      ),
      body: Visibility(
        visible: isLoading,
        replacement: RefreshIndicator(
          onRefresh: () => fetchTodoData(),
          child: Visibility(
            visible: items.isNotEmpty,
            replacement: Center(
                child: Image.network(
              'https://static.thenounproject.com/png/2655314-200.png',
              width: 100,
              color: const Color.fromARGB(255, 92, 92, 92),
            )),
            child: ListView.builder(
              padding: const EdgeInsets.all(10),
              itemBuilder: (context, index) {
                final item = items[index] as Map;
                return TodoCard(
                  index: index,
                  item: item,
                  navigateEdit: navigateEditPage,
                  deleteById: deleteById,
                );
              },
              itemCount: items.length,
            ),
          ),
        ),
        child: const Center(child: CircularProgressIndicator()),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {
            await UtilFunctions.navigateTo(context, const AddTodo());
            setState(() {
              isLoading = true;
            });
            // ignore: use_build_context_synchronously
            fetchTodoData();
          },
          backgroundColor: const Color.fromARGB(255, 17, 1, 107),
          label: const Row(
            children: [
              Icon(Icons.add, color: AppColors.kWhite, size: 20),
              SizedBox(width: 5),
              CustomText("Add", color: AppColors.kWhite)
            ],
          )),
    );
  }

  //----navigate to edit page
  Future<void> navigateEditPage(Map item) async {
    final route = MaterialPageRoute(
      builder: (context) => AddTodo(
        todo: item,
      ),
    );
    await Navigator.push(context, route);
    setState(() {
      isLoading = true;
    });

    fetchTodoData();
  }

//------get all todos API service
  Future<void> fetchTodoData() async {
    final results = await ApiServices.fetchTodos();

    if (results != null) {
      setState(() {
        items = results;
      });
    } else {
      // ignore: use_build_context_synchronously
      AlertHelper.showErrorMessage(context, message: "Something went wrong");
    }
    setState(() {
      isLoading = false;
    });
  }

  //------delete todo byid API service
  Future<void> deleteById(String id) async {
    final isSuccess = await ApiServices.deleteById(id);

    if (isSuccess) {
      //remove item from the list
      final filtered = items.where((element) => element['_id'] != id).toList();
      setState(() {
        items = filtered;
      });
    } else {
      //print error message
      // ignore: use_build_context_synchronously
      AlertHelper.showErrorMessage(
        context,
        message: "Item Remove Failed",
      );
    }
  }
}
