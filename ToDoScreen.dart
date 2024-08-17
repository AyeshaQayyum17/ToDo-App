import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';


class ToDoscreen extends StatefulWidget {
  @override
  _ToDoscreenState createState() => _ToDoscreenState();
}

class _ToDoscreenState extends State<ToDoscreen> {
  final _todoItems = <TodoItem>[];
  final _textController = TextEditingController();
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();

  TextEditingController titleController=TextEditingController();
  TextEditingController descController=TextEditingController();
  addData(String title,String desc)async{
    if(title=="" && desc==""){
      log("Enter Required Fields");
    }
    else{
      FirebaseFirestore.instance.collection("users").doc(title).set({
        "Title":title,
        "Description":desc
      }
      ).then((value)
      {
        log("Data Inserted");
      }
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: Center(child: Text('Todo App')),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                  hintText: "enter title"
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: descController,
              decoration: InputDecoration(
                  hintText: "enter Descrption"
              ),
            ),
            ElevatedButton(
              onPressed: (){
                addData(titleController.text.toString(), descController.text.toString());
              },
              child: Text("save data"),

            ),
            TextField(
              controller: _textController,
              decoration: InputDecoration(
                labelText: 'Enter new todo item',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addTodoItem,
              child: Text('Add Todo Item'),
            ),
            SizedBox(height: 20),

            Expanded(
              child: ListView.builder(
                itemCount: _todoItems.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_todoItems[index].title),
                    subtitle: Text(_todoItems[index].date.toString()),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            _editTodoItem(index);
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            _deleteTodoItem(index);
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 60),

            // TableCalendar(
            //   firstDay: DateTime(1990),
            //   lastDay: DateTime(2050),
            //   focusedDay: _focusedDay,
            //   calendarFormat: _calendarFormat,
            //   selectedDayPredicate: (day) {
            //     return isSameDay(_selectedDay, day);
            //   },
            //   onDaySelected: (selectedDay, focusedDay) {
            //     setState(() {
            //       _focusedDay = focusedDay;
            //       _selectedDay = selectedDay;
            //     });
            //   },
            // ),


          ],
        ),
      ),
    );
  }

  void _addTodoItem() {
    final todoItem = _textController.text;
    if (todoItem.isNotEmpty) {
      setState(() {
        _todoItems.add(TodoItem(title: todoItem, date: _selectedDay));
        _textController.clear();
      });
      Notifications().scheduleNotification(todoItem, _selectedDay);
    }
  }

  void _editTodoItem(int index) {
    final todoItem = _todoItems[index];
    final _editController = TextEditingController(text: todoItem.title);
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Todo Item'),
          content: TextField(
            controller: _editController,
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _todoItems[index] = TodoItem(title: _editController.text, date: todoItem.date);
                });
                Navigator.pop(context);
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _deleteTodoItem(int index) {
    setState(() {
      _todoItems.removeAt(index);
    });
  }
}

class TodoItem {
  final String title;
  final DateTime date;

  TodoItem({required this.title, required this.date});
}

class Notifications {
  void scheduleNotification(String title, DateTime date) {
    // implement notification scheduling logic here
  }
}