import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class Task {
  String title;

  Task(this.title);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tarefas App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        hintColor: Colors.green,
        scaffoldBackgroundColor:
            Colors.blueGrey[50], // Alteração da cor de fundo
      ),
      home: TaskListScreen(),
    );
  }
}

class TaskListScreen extends StatefulWidget {
  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  List<Task> tasks = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Tarefas'),
      ),
      body: tasks.isEmpty
          ? Center(
              child: Text(
                'Nenhuma tarefa adicionada',
                style: TextStyle(fontSize: 18.0),
              ),
            )
          : ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                return Dismissible(
                  key: Key(tasks[index].title),
                  onDismissed: (direction) {
                    setState(() {
                      tasks.removeAt(index);
                    });
                  },
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Icon(Icons.delete, color: Colors.white),
                  ),
                  child: ListTile(
                    title: Text(
                      tasks[index].title,
                      style: TextStyle(fontSize: 18.0),
                    ),
                    leading: Icon(Icons.check_circle,
                        color: Theme.of(context).colorScheme.secondary),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AddTaskScreen(addTaskCallback: _addTask)),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _addTask(String title) {
    setState(() {
      tasks.add(Task(title));
    });
  }
}

class AddTaskScreen extends StatelessWidget {
  final Function(String) addTaskCallback;

  AddTaskScreen({required this.addTaskCallback});

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adicionar Tarefa'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Título da Tarefa',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                if (_controller.text.isNotEmpty) {
                  addTaskCallback(_controller.text);
                  Navigator.pop(context);
                }
              },
              child: Text('Adicionar'),
            ),
          ],
        ),
      ),
    );
  }
}
