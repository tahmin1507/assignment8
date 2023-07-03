import 'package:flutter/material.dart';

class TaskManagement extends StatefulWidget {
  const TaskManagement({Key? key}) : super(key: key);

  @override
  State<TaskManagement> createState() => _TaskManagement();
}

class _TaskManagement extends State<TaskManagement> {
  final TextEditingController _titleTEController = TextEditingController();
  final TextEditingController _descriptionTEController = TextEditingController();
  final TextEditingController _daysTEController = TextEditingController();

  List<ToDo> todos = [];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.9),
      appBar: AppBar(
        title: Center(child: Text(" Task Management")),

      ),
      body: ListView.builder(
        itemCount: todos.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              onLongPress: () {
                Scaffold.of(context).showBottomSheet((BuildContext context){
                  return Container(
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3)
                      )]
                    ),
                    height: 300,
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Task Details",style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),textAlign: TextAlign.left,textDirection: TextDirection.ltr,),
                          Text("Title: ${todos[index].title}",style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),textAlign: TextAlign.left,textDirection: TextDirection.ltr,),
                          Text("Description: ${todos[index].description}",style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400

                          ),textAlign: TextAlign.left,textDirection: TextDirection.ltr,),
                          Text("Required Days: ${todos[index].days}",style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400
                          ),textAlign: TextAlign.left, textDirection: TextDirection.ltr,),
                          ElevatedButton(onPressed: () {
                            todos.removeAt(index);
                            Navigator.pop(context);
                            if (mounted) {
                              setState(() {});
                            }
                          },child: const Text("Delete")),

                        ],
                      ),
                    ),
                  );
                });
                if (mounted) {
                  setState(() {});
                }
              },
              title: Text(
                todos[index].title,
                style:
                const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              subtitle: Text(
                todos[index].description,
              ),

            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addNewTask(context);
          if (mounted) {
            setState(() {});
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }


  addNewTask(context) {
    return showDialog(context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Add New Task"),
            content: Container(
              height: 250,
              width: 350,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 50,
                    child: TextField(
                      controller: _titleTEController,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.all(10),
                        enabledBorder: OutlineInputBorder(),
                        hintText: "Title",
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),

                  SizedBox(
                    height: 125,
                    child: TextField(
                      maxLines: null,
                      expands: true,
                      controller: _descriptionTEController,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.all(10),
                        enabledBorder: OutlineInputBorder(),
                        hintText: "Description",
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),

                  SizedBox(
                    height: 50,
                    child: TextField(
                      controller: _daysTEController,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.all(10),
                        enabledBorder: OutlineInputBorder(),
                        hintText: "Days Required",
                      ),
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  if (_titleTEController.text
                      .trim()
                      .isNotEmpty &&
                      _descriptionTEController.text
                          .trim()
                          .isNotEmpty) {
                    todos.add(ToDo(_titleTEController.text,
                        _descriptionTEController.text, _daysTEController.text));
                    Navigator.pop(context);
                    _titleTEController.clear();
                    _descriptionTEController.clear();
                    _daysTEController.clear();
                    if (mounted) {
                      setState(() {});
                    }
                  }
                },
                child: const Text("save"),
              ),
            ],
          );
        });
  }
}


class ToDo {
  String title, description,days;

  ToDo(this.title, this.description, this.days);
}


