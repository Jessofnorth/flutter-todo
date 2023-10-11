import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ToDo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const ToDoPage(title: 'ToDo'),
    );
  }
}

//Create state for app
class ToDoPage extends StatefulWidget {
  const ToDoPage({super.key, required this.title});

  final String title;

  @override
  State<ToDoPage> createState() => _ToDoPageState();
}

//main class for todos
class _ToDoPageState extends State<ToDoPage> {
  //controller for the input field
  TextEditingController inputController = TextEditingController();
  //error variable for the input field
  bool showError = false;

  //starter list of todos to display
  List<String> todos = [
    'Learn Flutter',
    'Learn Dart',
    'Build a Flutter app',
  ];

//variable for the input field
  String input = "";

//function for adding todo to the list from the input field if there is content in input field
  void addTodo() {
    //show error if no content in input field
    if (inputController.text.isEmpty) {
      setState(() {
        showError = true;
      });
      return;
    }
    //if content add todo to list and clear input field and error message
    setState(() {
      todos.add(input);
      inputController.clear();
      input = "";
      showError = false;
    });
  }

//function to remove todo when clicked and adding the text to the input field
  removeTodo(int index) {
    setState(() {
      input = todos[index];
      inputController.text = todos[index];
      todos.removeAt(index);
    });
  }

//Layout of the app
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
          child: Padding(
        //padding for the app
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // textfield with add button
          children: <Widget>[
            TextField(
              controller: inputController,
              onChanged: (value) {
                input = value;
              },
              decoration: InputDecoration(
                errorText: showError ? 'Please enter a ToDo' : null,
                border: const OutlineInputBorder(),
                labelText: 'Add ToDo',
              ),
            ),
            const SizedBox(height: 20),
            // button to add todo
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green[100],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              onPressed: addTodo,
              child: const Text('Add ToDo'),
            ),
            const SizedBox(height: 20),
            //list of todos with separated listview
            //on tap deletes todo from list with index and adds the text to the input field
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.all(8),
                itemCount: todos.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(todos[index]),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        removeTodo(index);
                      },
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
