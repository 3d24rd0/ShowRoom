import 'machine_type.dart';

class Machine {
  Machine({
    required this.type,
    required this.id,
    required this.name,
  });

  final MachineType type;
  final String id;
  final String name;
}
