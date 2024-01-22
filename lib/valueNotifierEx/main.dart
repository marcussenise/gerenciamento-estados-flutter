import 'package:flutter/material.dart';
import 'package:statemanegement/valueNotifierEx/contact.dart';
import 'package:statemanegement/valueNotifierEx/contactbook.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Exercícios',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/new-contact': (context) => const NewContactView(),
      },
      home: const MyHomePage(title: 'HomePage'),
      // routes: {
      //'StateBasic': (context) => OffSetExercicio(),
      // },
    );
  }
}


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ValueListenableBuilder(
        valueListenable: ContactBook(),
        builder: ((context, value, child) {
          final contacts = value;
          return ListView.builder(
            itemCount: contacts.length,
            itemBuilder: ((context, index) {
              final contact = contacts[index];
              return Dismissible(
                onDismissed: (_) => ContactBook().remove(contact: contact),
                key: ValueKey(contact.id),
                child: Material(
                  color: Colors.white,
                  elevation: 6.0,
                  child: ListTile(
                    title: Text(contact.name),
                  ), 
                ),
              );
            })
          );
        }
      )),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add), 
        onPressed: () async {
          await Navigator.of(context).pushNamed('/new-contact');
        }
      ),
     
    );
  }
}

class NewContactView extends StatefulWidget {
  const NewContactView({super.key});

  @override
  State<NewContactView> createState() => _NewContactViewState();
}

class _NewContactViewState extends State<NewContactView> {
  late final TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose(); 
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add a new contact'),),
      body: Column(
        children: [
          TextField(
            controller: _controller,
            decoration: const InputDecoration(
              hintText: 'Enter a new contact name here'
            ),
          ),
          TextButton(
            onPressed: (){
              final contact = Contact(name: _controller.text);
              ContactBook().add(contact: contact);
              Navigator.of(context).pop();
            },
            child: const Text('Add content'))
        ],
      ),
    );
  }
}
