import 'package:stacked/stacked.dart';

class Recentpageviewmodel extends BaseViewModel {
  List<Contact> get contacts => _contacts;
  List<Contact> _contacts = [
    Contact(name: "Nick Jonas", time: "2 min ago", type: ContactType.missed),
    Contact(
        name: "+92 4398434242", time: "10 min ago", type: ContactType.outgoing),
    Contact(name: "Sana Khan", time: "56 min ago", type: ContactType.incoming),
    Contact(
        name: "Sitarama Aman", time: "1 hr ago", type: ContactType.outgoing),
    Contact(name: "Zuhaib Khan", time: "3 hrs ago", type: ContactType.incoming),
    Contact(
        name: "Daniel Radicliff", time: "10 hrs ago", type: ContactType.none),
    Contact(
        name: "Tyrion Lannister",
        time: "18 hrs ago",
        type: ContactType.outgoing),
    Contact(
        name: "+92 956000002", time: "2 days ago", type: ContactType.incoming),
    Contact(
        name: "Aamir waseem", time: "Yesterday", type: ContactType.incoming),
  ];

  void deleteContact(int index) {
    _contacts.removeAt(index);
    notifyListeners();
  }
}

enum ContactType { incoming, outgoing, missed, none }

class Contact {
  final String name;
  final String time;
  final ContactType type;

  Contact({required this.name, required this.time, required this.type});
}
