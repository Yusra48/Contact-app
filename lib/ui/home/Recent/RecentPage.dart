import 'package:flutter/material.dart';
import 'package:flutter_application_1/ui/home/Recent/RecentPageViewModel.dart';
import 'package:stacked/stacked.dart';

class RecentPage extends StatelessWidget {
  const RecentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<Recentpageviewmodel>.reactive(
        viewModelBuilder: () => Recentpageviewmodel(),
        builder: (context, viewModel, child) {
          return DefaultTabController(
            length: 2,
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.grey[50],
                title: Text(
                  'Recents',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      letterSpacing: 1),
                ),
                bottom: TabBar(
                  tabs: [
                    Tab(text: 'All'),
                    Tab(text: 'Missed'),
                  ],
                ),
              ),
              body: TabBarView(
                children: [
                  _buildContactList(viewModel),
                  _buildMissedContactList(viewModel),
                ],
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {},
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Icon(
                  Icons.dialpad,
                  color: Colors.white,
                ),
              ),
            ),
          );
        });
  }

  Widget _buildContactList(Recentpageviewmodel viewModel) {
    return ListView.builder(
      itemCount: viewModel.contacts.length,
      itemBuilder: (context, index) {
        final contact = viewModel.contacts[index];
        return ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.grey[600],
            child: Text(
              contact.name[0],
              style: TextStyle(color: Colors.white),
            ),
          ),
          title: Text(contact.name),
          subtitle: Text(contact.time),
          trailing: _buildTrailingIcon(contact.type, () {
            viewModel.deleteContact(index);
          }),
          tileColor: Colors.grey[50],
          onTap: () {
            _showDeleteConfirmationDialog(
              context,
              viewModel.contacts.indexOf(contact),
              viewModel,
            );
          },
        );
      },
    );
  }

  Widget _buildMissedContactList(Recentpageviewmodel viewModel) {
    final missedContacts =
        viewModel.contacts.where((c) => c.type == ContactType.missed).toList();
    return ListView.builder(
      itemCount: missedContacts.length,
      itemBuilder: (context, index) {
        final contact = missedContacts[index];
        return ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.grey[600],
            child: Text(
              contact.name[0],
              style: TextStyle(color: Colors.white),
            ),
          ),
          title: Text(contact.name),
          subtitle: Text(contact.time),
          trailing: _buildTrailingIcon(contact.type, () {
            viewModel.deleteContact(viewModel.contacts.indexOf(contact));
          }),
          tileColor: Colors.grey[50],
          onTap: () {
            _showDeleteConfirmationDialog(
              context,
              viewModel.contacts.indexOf(contact),
              viewModel,
            );
          },
        );
      },
    );
  }

  Widget _buildTrailingIcon(ContactType type, VoidCallback onDelete) {
    switch (type) {
      case ContactType.incoming:
        return Icon(Icons.check_circle, color: Colors.green);
      case ContactType.outgoing:
        return Icon(Icons.call_made, color: Colors.red);
      case ContactType.missed:
        return Icon(Icons.call_missed, color: Colors.red);
      case ContactType.none:
      default:
        return TextButton(
          onPressed: onDelete,
          child: Text('Delete'),
        );
    }
  }

  void _showDeleteConfirmationDialog(
      BuildContext context, int index, Recentpageviewmodel viewModel) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Delete Call'),
          content: Text('Would you like to delete this call?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                viewModel.deleteContact(index);
                Navigator.of(context).pop();
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}
