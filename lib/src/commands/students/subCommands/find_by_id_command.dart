import 'package:args/command_runner.dart';

import '../../../repositories/student_repository.dart';


class FindByIdCommand extends Command {
  final StudentRepository repository;

  FindByIdCommand(this.repository) {
    argParser.addOption('id', help: "Student id", abbr: "i");
  }

  @override
  String get name => "byId";

  @override
  String get description => "Find student by id";

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
    } catch (e) {
      print("Aluno com o id: $id não encontrado!\n");
    }
    print('--------------------------------------------------------\n');
  }
}

//CMD +D -> duplica a linha
