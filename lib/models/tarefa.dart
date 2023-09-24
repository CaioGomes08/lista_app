// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Tarefa {
  int? id;
  String? titulo;

  Tarefa({
    this.id,
    this.titulo,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'titulo': titulo,
    };
  }

  factory Tarefa.fromMap(Map<String, dynamic> map) {
    return Tarefa(
      id: map['id'] as int,
      titulo: map['titulo'] as String,
    );
  }
}
