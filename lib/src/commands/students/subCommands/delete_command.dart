import 'package:args/command_runner.dart';
import 'dart:io';
import '../../../repositories/student_repository.dart';

class DeleteCommand extends Command {
  final StudentRepository repository;

  DeleteCommand(this.repository) {
    argParser.addOption('id', help: "Id of the student", abbr: "i");
  }

  @override
  String get name => "delete";

  @override
  String get description => "Delete Student";

  @override
  Future<void> run() async {
    if (argResults?['id'] == null) {
      print("Por favor envie o id do aluno com o comando --id=0 ou -i 0");
      return;
    }
    final id = int.tryParse(argResults?['id']);

    print('--------------------------------------------------------\n');
    print("ALUNO\n");
    try {
      final result = await repository.findById(id ?? 0);
      print("""
      id: ${result.id}
      Nome: ${result.name}
      Cursos: ${result.courses.map((e) => e.name)}
      Endereço: ${result.address.street}  num: ${result.address.number}  Cep: ${result.address.zipCode} Cidade: ${result.address.city} \n
      """);

      print("Deseja deletar este aluno? [S ou N]");
        final answer = stdin.readLineSync();
        if (answer == "S" || answer == "s") {
          repository.deletById(result);
          print("\nDELETATO COM SUCESSO!\n");
      } else {
        print("Operação cancelada com sucesso!");
      }
    } catch (e) {
      print("Aluno com o id: $id não encontrado!\n");
    }
    print('--------------------------------------------------------\n');
  }
}
