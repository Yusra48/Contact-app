import 'dart:convert';
import 'package:flutter_application_1/Model/ContactModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';

class HomeViewModel extends BaseViewModel {
  List<Contact> _contacts = [];

  List<Contact> get contacts => _contacts;

  Future<void> loadContacts() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? contactsString = prefs.getString('contacts');
      if (contactsString != null) {
        final List<dynamic> jsonList = jsonDecode(contactsString);
        _contacts = jsonList.map((json) => Contact.fromJson(json)).toList();
        notifyListeners();
      }
    } catch (e) {
      print('Error loading contacts: $e');
    }
  }

  Future<void> saveContacts() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String contactsString =
          jsonEncode(_contacts.map((contact) => contact.toJson()).toList());
      await prefs.setString('contacts', contactsString);
    } catch (e) {
      print('Error saving contacts: $e');
    }
  }

  void addContact(Contact contact) {
    _contacts.add(contact);
    saveContacts();
    notifyListeners();
  }
}
