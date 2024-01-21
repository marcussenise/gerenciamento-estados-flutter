import 'package:flutter/material.dart';
import 'package:statemanegement/contact.dart';

class ContactBook extends ValueNotifier<List<Contact>>{
  ContactBook._sharedInstance() : super([]);
  static final ContactBook _shared = ContactBook._sharedInstance();
  factory ContactBook() => _shared;

  int get length => value.length;

  void add({required Contact contact}){
    value.add(contact);
    notifyListeners();
  }

  void remove({required Contact contact}){
    if(value.contains(contact)){
      value.remove(contact);
      notifyListeners();
    }
  }

  Contact? contact({required atIndex}) => value.length > atIndex ? value[atIndex] : null;
}