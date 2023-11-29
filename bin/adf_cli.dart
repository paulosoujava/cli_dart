import 'package:adf_cli/src/commands/students/subCommands/delete_command.dart';
import 'package:adf_cli/src/commands/students/subCommands/find_all_commands.dart';
import 'package:adf_cli/src/commands/students/subCommands/find_by_id_command.dart';
import 'package:adf_cli/src/commands/students/subCommands/insert_command.dart';
import 'package:adf_cli/src/commands/students/subCommands/update_command.dart';
import 'package:adf_cli/src/repositories/student_repository.dart';
import 'package:args/command_runner.dart';

void main(List<String> args) {
  final repositoryStudent = StudentRepository();
  CommandRunner('ADF CLI', "Descripition")
    ..addCommand(FindAllCommnads(repositoryStudent))
    ..addCommand(FindByIdCommand(repositoryStudent))
    ..addCommand(InsertCommand(repositoryStudent))
    ..addCommand(UpdateCommand(repositoryStudent))
    ..addCommand(DeleteCommand(repositoryStudent))
    ..run(args);
}
