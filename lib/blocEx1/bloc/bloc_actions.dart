import 'package:flutter/foundation.dart' show immutable;
import 'package:statemanegement/blocEx1/bloc/person.dart';

const persons1Url = 'http://172.16.0.242:5500/lib/blocEx1/persons1.json';
const persons2Url = 'http://172.16.0.242:5500/lib/blocEx1/persons2.json';

typedef PersonsLoader = Future<Iterable<Person>> Function(String url);

@immutable
abstract class LoadAction {
  const LoadAction();
}

@immutable
class LoadPersonAction implements LoadAction {
  final String url;
  final PersonsLoader loader;
  const LoadPersonAction({required this.url, required this.loader}) : super();
}