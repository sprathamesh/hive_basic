import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_basic/data/person.dart';
import 'package:hive_basic/modules/boxes.dart';

Future<void> initHive() async {
  await Hive.initFlutter(); // Initialize Hive
  Hive.registerAdapter(PersonAdapter()); // Register Adapter
  boxPersons = await Hive.openBox<Person>('personBox'); // Open the Hive box
}
