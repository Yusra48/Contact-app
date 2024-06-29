import 'package:flutter/material.dart';
import 'package:flutter_application_1/Model/ContactModel.dart';
import 'package:flutter_application_1/ui/Screens/AddToContacts.dart';
import 'package:flutter_application_1/ui/Category/ContactInfo.dart';
import 'package:flutter_application_1/ui/home/Group/GroupPage.dart';
import 'package:flutter_application_1/ui/home/Recent/RecentPage.dart';
import 'package:stacked/stacked.dart';
import 'HomeViewModel.dart';

class HomeView extends StatelessWidget {
  HomeView({Key? key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
        viewModelBuilder: () => HomeViewModel(),
        onModelReady: (model) => model.loadContacts(),
        builder: (context, model, child) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.grey[50],
              title: const Text(
                'Contacts',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  letterSpacing: 1,
                ),
              ),
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.search),
                      color: Colors.black,
                      onPressed: () {},
                    ),
                    const SizedBox(width: 16),
                    IconButton(
                      icon: const Icon(Icons.more_vert),
                      color: Colors.black,
                      onPressed: () {},
                    )
                  ],
                )
              ],
            ),
            body: model.contacts.isEmpty
                ? Center(
                    child: Image.asset(
                      'assets/Contact.png',
                      width: 300,
                      height: 300,
                    ),
                  )
                : ListView.builder(
                    itemCount: model.contacts.length,
                    itemBuilder: (context, index) {
                      final contact = model.contacts[index];
                      return Column(
                        children: <Widget>[
                          ListTile(
                            title: Row(
                              children: [
                                Text(
                                  contact.name,
                                  style: const TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(width: 5),
                                Text(
                                  contact.username,
                                  style: const TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                            subtitle: Text(
                              contact.phone,
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.normal,
                                color: Colors.grey[700],
                              ),
                            ),
                            leading: CircleAvatar(
                              backgroundColor: Colors.grey[600],
                              child: const Icon(
                                Icons.person,
                                color: Colors.white,
                                size: 30,
                              ),
                            ),
                            trailing: Icon(
                              Icons.call,
                              color: Colors.green,
                            ),
                            tileColor: Colors.white,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ContactInfo(
                                    contactIndex: index,
                                    contact: contact,
                                  ),
                                ),
                              );
                            },
                          ),
                          const Divider(),
                        ],
                      );
                    },
                  ),
            floatingActionButton: FloatingActionButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              backgroundColor: Colors.blue,
              onPressed: () async {
                final newContact = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddToContacts()),
                );

                if (newContact != null && newContact is Contact) {
                  model.addContact(newContact);
                }
              },
              child: const Icon(Icons.add, color: Colors.white),
            ),
            bottomNavigationBar: BottomNavigationBar(
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.history),
                  label: 'Recents',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.contacts),
                  label: 'Contacts',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.group),
                  label: 'Groups',
                ),
              ],
              currentIndex: 1,
              selectedItemColor: Colors.blue[600],
              unselectedItemColor: Colors.grey,
              onTap: (int index) {
                switch (index) {
                  case 0:
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const RecentPage()));
                    break;
                  case 1:
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomeView()));
                    break;
                  case 2:
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const GroupsView()));
                    break;
                }
              },
            ),
          );
        });
  }
}
