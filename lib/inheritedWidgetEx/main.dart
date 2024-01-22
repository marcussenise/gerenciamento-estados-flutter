import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Inherited Widget',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ApiProvider(
        api: Api(),
        child: const MyHomePage()
        ),
    );
  }
}


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {
  ValueKey _textKey = const ValueKey<String?>(null);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(ApiProvider.of(context).api.dateAndTime ?? ''),
      ),
      body: GestureDetector(
          onTap: () async {
            final dateAndTime = await ApiProvider.of(context).api.getDateAndTime();
            setState(() {
              _textKey = ValueKey(dateAndTime);
            });
          },
          child: SizedBox.expand(
            child: Container(
              color: Colors.white,
              child: DateTimeWidget(key: _textKey,),
            ),
          ),
        ),
    );
  }
}

class DateTimeWidget extends StatelessWidget{
  const DateTimeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final api = ApiProvider.of(context).api;
    return Text(api.dateAndTime ?? 'Clique na tela para pegar data e tempo.');
  }

}

class ApiProvider extends InheritedWidget{
  final Api api;
  final String uuid;
  
  ApiProvider({
    Key? key,
    required this.api,
    required Widget child,
  }) : uuid = const Uuid().v4(), super(key: key, child: child);

 
  @override
  bool updateShouldNotify(covariant ApiProvider oldWidget) {
   return uuid != oldWidget.uuid;
  }

  static ApiProvider of(BuildContext context){
    return context.dependOnInheritedWidgetOfExactType<ApiProvider>()!;
  }
}

class Api{
  String? dateAndTime;

  Future<String> getDateAndTime(){
    return Future.delayed(const Duration(seconds: 1), (){
      return DateTime.now().toIso8601String();
    }).then((value) {
      dateAndTime = value;
      return value;
    });
  }
} 