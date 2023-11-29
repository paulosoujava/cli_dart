import 'dart:io';

import 'package:args/command_runner.dart';

import '../../../models/models.dart';
import '../../../repositories/product_repository.dart';
import '../../../repositories/student_repository.dart';

class InsertCommand extends Command {
  final StudentRepository repository;
  final ProductRepository repositoryProduct;

  InsertCommand(this.repository) : repositoryProduct = ProductRepository() {
    argParser.addOption('file', help: "Path of the csv file", abbr: "f");
  }

  @override
  String get name => "insert";

  @override
  String get description => "Insert Student";

  @override
  Future<void> run() async {
    final filePath = argResults?['file'];
    final students = File(filePath).readAsStringSync();

    print("--------------------------------------------------------\n");

    for (final student in students.split("\n")) {
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

      repository.insert(studentModel);
    }
    print('---------------------------------------------------------\n');
    print('Aluno inserido com sucesso!\n');
  }
}
