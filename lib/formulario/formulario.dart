import 'package:flutter/material.dart';
import 'package:lista_app/helpers/task_helpers.dart';
import 'package:lista_app/models/tarefa.dart';

class Formulario extends StatefulWidget {
  final bool isEditMode;
  final Tarefa? tarefa;

  const Formulario({
    super.key,
    this.isEditMode = false,
    this.tarefa,
  });

  @override
  State<Formulario> createState() => _FormularioState();
}

class _FormularioState extends State<Formulario> {
  TextEditingController atividadeController = TextEditingController();
  final TaskHelper helper = TaskHelper();

  Tarefa _currentTask = Tarefa(id: 0, titulo: "");
  @override
  void initState() {
    super.initState();

    // Verifica se foi enviado alguma tarefa para edição
    // Caso queira editar, copia-se essa tarefa
    if (widget.tarefa != null) {
      _currentTask = Tarefa.fromMap(widget.tarefa!.toMap());
    }

    atividadeController.text = _currentTask.titulo ?? '';
  }

  @override
  void dispose() {
    atividadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.isEditMode ? 'Alteração Atividade' : 'Cadastro Atividade',
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blue[600],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Form(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: [
                  TextField(
                    controller: atividadeController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Atividade',
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                if (widget.isEditMode && widget.tarefa != null) {
                  widget.tarefa!.titulo = atividadeController.text;
                  helper.update(widget.tarefa!);
                } else {
                  helper.save(Tarefa(titulo: atividadeController.text));
                }

                atividadeController.clear();
                Navigator.pop(context);
              },
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(
                  Colors.blue[600],
                ),
              ),
              child: Text(
                widget.isEditMode ? 'Atualizar Tarefa' : 'Salvar Atividade',
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
