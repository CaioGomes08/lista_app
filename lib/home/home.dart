import 'package:flutter/material.dart';
import 'package:lista_app/formulario/formulario.dart';
import 'package:lista_app/helpers/task_helpers.dart';
import 'package:lista_app/models/tarefa.dart';

class Home extends StatefulWidget {
  final String titulo;
  const Home({
    super.key,
    required this.titulo,
  });

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Tarefa> tarefas = [];

  TaskHelper helper = TaskHelper();

  bool loading = true;

  @override
  void initState() {
    super.initState();
  }

  Future<void> getTarefas() async {
    helper.getAll().then((list) {
      setState(() {
        tarefas = list;
        loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    getTarefas();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.titulo,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blue[600],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const Formulario(),
            ),
          );
        },
        backgroundColor: Colors.blue[600],
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: Visibility(
        visible: tarefas.isNotEmpty && !loading,
        replacement: Visibility(
          visible: !loading && tarefas.isEmpty,
          replacement: const Center(
            child: CircularProgressIndicator(),
          ),
          child: const Center(
            child: Text(
              'Sem tarefas',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        child: ListView.builder(
          itemCount: tarefas.length,
          itemBuilder: ((context, index) {
            Tarefa tarefa = tarefas[index];
            return Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              tarefa.titulo!,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Formulario(
                                    tarefa: tarefa,
                                    isEditMode: true,
                                  ),
                                ),
                              );
                            },
                            icon: Icon(
                              Icons.edit,
                              color: Colors.blue[600],
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              print(tarefa.id);
                              helper.delete(tarefa.id!);
                              getTarefas();
                            },
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
