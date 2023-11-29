import 'dart:convert';

import 'package:http/http.dart';

import '../models/models.dart';
import '../utils/constants.dart';

class StudentRepository {
  Future<List<Student>> findAll() async {
    final result = await get(Uri.parse("$pathToUtl/students"));
    if (result.statusCode != 200) {
      throw Exception();
    }

    final list = jsonDecode(result.body);
    return list.map<Student>((map) => Student.fromMap(map)).toList();
  }

  Future<Student> findById(int id) async {
    final result = await get(Uri.parse("$pathToUtl/students/$id"));
    if (result.statusCode != 200) {
      throw Exception();
    }

    final responseData = jsonDecode(result.body);
    if (responseData == '{}') {
      throw Exception("Estudante não encontrado!!");
    }
    return Student.fromMap(responseData);
  }

  Future<void> insert(Student student) async {
    final result = await post(Uri.parse("$pathToUtl/students"),
        body: student.toJson(), headers: {'content-type': 'application/json'});

    if (result.statusCode != 200) {
      throw Exception();
    }
  }

  Future<void> udpate(Student student) async {
    final result = await put(Uri.parse("$pathToUtl/students/${student.id}"),
        body: student.toJson(), headers: {'content-type': 'application/json'});

    if (result.statusCode != 200) {
      throw Exception();
    }
  }

  Future<void> deletById(Student student) async {
    final result = await delete(Uri.parse("$pathToUtl/students/${student.id}"),
        body: student.toJson(), headers: {'content-type': 'application/json'});

    if (result.statusCode != 200) {
      throw Exception();
    }
  }
}

void main(List<String> args) async {
  final rep = StudentRepository();
  final student = await rep.findById(1);
  print(student);
  //print(rep.buscarTodos().runtimeType);
  //for(final student in await rep.buscarTodos()){
  //print(student.name);
  //}
}
