import 'package:flutter/material.dart';
import 'package:todo_app/components/custom_text.dart';

class TodoCard extends StatefulWidget {
  const TodoCard({
    super.key,
    required this.index,
    required this.item,
    required this.navigateEdit,
    required this.deleteById,
  });
  final int index;
  final Map item;
  final Function(Map) navigateEdit;
  final Function(String) deleteById;
  @override
  State<TodoCard> createState() => _TodoCardState();
}

class _TodoCardState extends State<TodoCard> {
  @override
  Widget build(BuildContext context) {
    final id = widget.item['_id'];
    return Card(
      child: ListTile(
        leading: CircleAvatar(child: CustomText('${widget.index + 1}')),
        title: CustomText(widget.item['title'], fontSize: 16),
        subtitle: CustomText(widget.item['description'], fontSize: 12),
        trailing: PopupMenuButton(
          onSelected: (value) {
            if (value == 'edit') {
              widget.navigateEdit(widget.item);
            } else if (value == 'remove') {
              //delete todo
              widget.deleteById(id);
            }
          },
          itemBuilder: (context) {
            return [
              const PopupMenuItem(
                value: 'edit',
                child: CustomText("Edit"),
              ),
              const PopupMenuItem(
                value: 'remove',
                child: CustomText("Remove"),
              ),
            ];
          },
        ),
      ),
    );
  }
}
