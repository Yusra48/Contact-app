import 'dart:convert';
import 'package:flutter_application_1/Model/ContactModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';

class ContactInfoModel extends BaseViewModel {
  late Contact _contact;
  List<Map<String, String>> callHistory = [
    {
      'date': 'Apr 27, 14:16',
      'number': '+998901234567',
      'status': 'Didn\'t connect'
    },
    {
      'date': 'Apr 20, 10:35',
      'number': '+998901234567',
      'status': 'Rang 5 times'
    },
    {
      'date': 'Mar 05, 19:23',
      'number': '+998901234567',
      'status': 'Outgoing 15 min 12 sec'
    },
    {
      'date': 'Feb 12, 08:03',
      'number': '+998901234567',
      'status': 'Incoming 30 sec',
    },
  ];

  Contact get contact => _contact;

  void init(Contact contact) {
    _contact = contact;
    notifyListeners();
  }

  Future<void> loadContacts() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? contactsString = prefs.getString('contacts');
      if (contactsString != null) {
        final List<dynamic> jsonList = jsonDecode(contactsString);
        List<Contact> loadedContacts =
            jsonList.map((json) => Contact.fromJson(json)).toList();
        _contact = loadedContacts.firstWhere(
          (c) => c.name == _contact.name && c.username == _contact.username,
          orElse: () => _contact,
        );
        notifyListeners();
      }
    } catch (e) {
      print('Error loading contacts: $e');
    }
  }

  Future<void> saveContacts(List<Contact> contacts) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String contactsString =
          jsonEncode(contacts.map((contact) => contact.toJson()).toList());
      await prefs.setString('contacts', contactsString);
    } catch (e) {
      print('Error saving contacts: $e');
    }
  }

  bool editContact(Contact updatedContact) {
    _contact = updatedContact;
    saveContacts([_contact]);
    notifyListeners();
    return true;
  }

  Future<bool> deleteContact() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? contactsString = prefs.getString('contacts');
      if (contactsString != null) {
        List<Contact> loadedContacts =
            (jsonDecode(contactsString) as List<dynamic>)
                .map((json) => Contact.fromJson(json))
                .toList();
        notifyListeners();

        loadedContacts.removeWhere((element) =>
            element.name == _contact.name &&
            element.username == _contact.username);
        notifyListeners();

        final updatedContactsString = jsonEncode(
            loadedContacts.map((contact) => contact.toJson()).toList());
        notifyListeners();

        await prefs.setString('contacts', updatedContactsString);
        notifyListeners();
        return true;
      } else {
        print('No contacts found in SharedPreferences.');
        return false;
      }
    } catch (e) {
      print('Error deleting contact: $e');
      return false;
    }
  }
}
