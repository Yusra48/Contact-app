import 'package:stacked/stacked.dart';

class GroupsViewModel extends BaseViewModel {
  List<Group> _groups = [];
  List<Favourite> _favourites = [];

  List<Group> get groups => _groups;
  List<Favourite> get favourites => _favourites;

  void loadGroups() {
    _groups = [
      Group(name: "Family", members: 16),
      Group(name: "Friends", members: 24),
    ];

    _favourites = [
      Favourite(name: "Sitara Aman", label: "Office"),
      Favourite(name: "Zuhaib Khan", label: "Home"),
    ];

    notifyListeners();
  }
}

class Group {
  final String name;
  final int members;

  Group({required this.name, required this.members});
}

class Favourite {
  final String name;
  final String label;

  Favourite({required this.name, required this.label});
}
