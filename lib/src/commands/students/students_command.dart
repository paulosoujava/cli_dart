import 'package:args/command_runner.dart';

import '../../repositories/student_repository.dart';
import 'subCommands/find_all_commands.dart';

class StudentsCommand extends Command {
  @override
  String get name => "students";

  @override
  String get description => "Students Operations"; 

  StudentsCommand() {
    final studentRepository = StudentRepository();
    addSubcommand(FindAllCommnads(studentRepository));
  }
}
