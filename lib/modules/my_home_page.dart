import 'package:flutter/material.dart';
import 'package:hive_basic/data/person.dart';
import 'package:hive_basic/modules/boxes.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Initialize controllers
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 13, 31, 37),
      appBar: AppBar(title: const Text('Flutter HIVE')),
      body: Column(
        children: [
          const SizedBox(height: 20.0), //for spacing
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    TextField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'name',
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    TextField(
                      controller: ageController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'age',
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          //set state to UI update
                          boxPersons.put(
                            // Add a new person
                            'key_${nameController.text}', //name as a key
                            Person(
                              //person object creation
                              name: nameController.text,
                              age: int.parse(ageController.text),
                            ),
                          );
                          // Clear text fields after submitting
                          nameController.clear();
                          ageController.clear();
                        });
                      },
                      child: const Text('ADD',
                      style: TextStyle(color: Colors.white),
                      ),
                      style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.blue) ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ListView.builder(
                    itemCount: boxPersons.length,
                    itemBuilder: (context, index) {
                      var key = boxPersons.keyAt(index);
                      Person person = boxPersons.get(key) as Person; // Null assertion op
                      return ListTile(
                        leading: IconButton(
                          onPressed: () {
                            setState(() {
                              //set state to UI update
                              boxPersons.delete(key);
                            });
                          },
                          icon: const Icon(
                            Icons.remove,
                          ),
                        ),
                        title: Text(person.name),
                        subtitle: Text(person.age.toString()),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
