import 'dart:io';

import 'package:args/command_runner.dart';

import '../../../models/models.dart';
import '../../../repositories/product_repository.dart';
import '../../../repositories/student_repository.dart';

class UpdateCommand extends Command {
  final StudentRepository repository;
  final ProductRepository repositoryProduct;

  UpdateCommand(this.repository) : repositoryProduct = ProductRepository() {
    argParser.addOption('id', help: "Id of the student", abbr: "i");
    argParser.addOption('file', help: "Path of the csv file", abbr: "f");
  }

  @override
  String get name => "update";

  @override
  String get description => "Update Student";

  @override
  Future<void> run() async {
    final filePath = argResults?['file'];
    final id = argResults?['id'];

    if (filePath == null || id == null) {
      print(
          "Por favor, informe o caminho do arquivo e o id do aluno. --id=0 ou -i 0\n");
      return;
    }
  final students = File(filePath).readAsLinesSync();    

    print("--------------------------------------------------------\n");

    if (students.length > 1) {
      print("Por favor, informe somente um aluno por vez no $filePath\n");
      return;
    } else if (students.isEmpty) {
      print("Por favor, informe pelo menos um aluno no $filePath\n");
      return;
    }
    var student = students.first;
    
    final studentData = student.split(";");
    final courseCsv = studentData[1].split(",").map((e) => e.trim()).toList();
    final courseFuture = courseCsv.map((e) async {
      //print(e);
      final course = await repositoryProduct.findByName(e);
      course.isStudent = true;
      return course;
    }).toList();

    final courses = await Future.wait(courseFuture);

    final studentModel = Student(
        id: int.parse(id),
        name: studentData[0],
        nameCourses: courseCsv,
        courses: courses,
        address: Address(
          street: studentData[2],
          number: int.parse(studentData[3]),
          zipCode: studentData[4],
          city: City(id: 1, name: studentData[5]),
          phone: Phone(ddd: int.parse(studentData[6]), phone: studentData[7]),
        ));

    repository.udpate(studentModel);

    print('---------------------------------------------------------\n');
    print('Aluno atualizado com sucesso!\n');
  }
}
