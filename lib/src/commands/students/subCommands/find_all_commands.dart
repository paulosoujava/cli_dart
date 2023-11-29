import 'package:args/command_runner.dart';
import 'dart:io';

import '../../../repositories/student_repository.dart';

class FindAllCommnads extends Command {
  final StudentRepository studentRepository;

  FindAllCommnads(this.studentRepository);

  @override
  String get name => "findAll";

  @override
  String get description => "Find All Students";

  @override
  Future<void> run() async {
    print("Aguarde buscando alunos...\n");
    final result = await studentRepository.findAll();
    print("Apresentar também os cursos? [S ou N]");
    final answer = stdin.readLineSync();
    print('--------------------------------------------------------\n');
    print("ALUNOS\n");
    print('--------------------------------------------------------\n');
    for (final student in result) {
      if (answer == "S" || answer == "s") {
        print("${student.id} - ${student.name}\n\t Cursos: ${student.courses.where((element) => element.isStudent).map((e) => e.name).toList()}");
      } else {
        print("${student.id} - ${student.name}\n");
      }
    }
    print('--------------------------------------------------------\n');
  }
}
