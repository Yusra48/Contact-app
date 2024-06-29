import 'package:flutter/material.dart';
import 'package:flutter_application_1/Model/ContactModel.dart';
import 'package:flutter_application_1/ui/Category/ContactInfoModel.dart';
import 'package:stacked/stacked.dart';

class ContactInfo extends StatelessWidget {
  final Contact contact;

  ContactInfo({
    required this.contact,
    required int contactIndex,
  });

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ContactInfoModel>.reactive(
      viewModelBuilder: () => ContactInfoModel(),
      onModelReady: (viewModel) => viewModel.init(contact),
      builder: (context, viewModel, child) => Scaffold(
        appBar: AppBar(
          title: Text(
            'Contact Info',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              letterSpacing: 1,
            ),
          ),
          actions: [
            IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.black,
              ),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(
                Icons.more_vert,
                color: Colors.black,
              ),
              onPressed: () {},
            ),
          ],
        ),
        body: Column(
          children: [
            _buildProfileSection(context, viewModel),
            Divider(),
            _buildCallHistorySection(viewModel),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileSection(
      BuildContext context, ContactInfoModel viewModel) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Center(
            child: CircleAvatar(
              backgroundColor: Colors.grey[600],
              radius: 40,
              child: Icon(
                Icons.person,
                size: 45,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(height: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                viewModel.contact.name,
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 7),
              Text(
                viewModel.contact.username,
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    viewModel.contact.phone,
                    style: TextStyle(fontSize: 20, color: Colors.grey[700]),
                  ),
                  SizedBox(width: 100),
                  IconButton(
                    icon: Icon(Icons.call, color: Colors.green),
                    onPressed: () {},
                  ),
                  SizedBox(width: 10),
                  IconButton(
                    icon: Icon(Icons.message, color: Colors.orange),
                    onPressed: () {},
                  ),
                  SizedBox(width: 10),
                  IconButton(
                    icon: Icon(Icons.edit, color: Colors.blue),
                    onPressed: () => _editContact(context, viewModel),
                  ),
                  SizedBox(width: 10),
                  IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () => _confirmDelete(context, viewModel),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _editContact(BuildContext context, ContactInfoModel viewModel) {
    final TextEditingController nameController =
        TextEditingController(text: viewModel.contact.name);
    final TextEditingController usernameController =
        TextEditingController(text: viewModel.contact.username);
    final TextEditingController phoneController =
        TextEditingController(text: viewModel.contact.phone);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Contact'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: usernameController,
                decoration: InputDecoration(labelText: 'Username'),
              ),
              TextField(
                controller: phoneController,
                decoration: InputDecoration(labelText: 'Phone'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                final updatedContact = Contact(
                  name: nameController.text,
                  username: usernameController.text,
                  phone: phoneController.text,
                );
                bool success = viewModel.editContact(updatedContact);
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(success
                        ? 'Contact updated successfully'
                        : 'Failed to update contact'),
                  ),
                );
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _confirmDelete(BuildContext context, ContactInfoModel viewModel) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Delete Contact'),
          content: Text('Are you sure you want to delete this contact?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                bool success = await viewModel.deleteContact();
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(success
                        ? 'Contact deleted successfully'
                        : 'Failed to delete contact'),
                  ),
                );
              },
              child: Text(
                'Delete',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildCallHistorySection(ContactInfoModel viewModel) {
    return Expanded(
      child: ListView.builder(
        itemCount: viewModel.callHistory.length,
        itemBuilder: (context, index) {
          final status = viewModel.callHistory[index]['status']!;
          return ListTile(
            title: Text(
              viewModel.callHistory[index]['date']!,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            subtitle: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  viewModel.callHistory[index]['number']!,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                    color: Colors.grey[700],
                  ),
                ),
                SizedBox(width: 4),
                Icon(
                  getIcon(status),
                  color: getIconColor(status),
                ),
              ],
            ),
            trailing: Text(
              status,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.normal,
                color: Colors.grey[700],
              ),
            ),
          );
        },
      ),
    );
  }

  IconData getIcon(String status) {
    if (status.contains("Outgoing")) {
      return Icons.call_made;
    } else if (status.contains("Incoming")) {
      return Icons.call_received;
    } else if (status.contains("Rang")) {
      return Icons.call;
    } else {
      return Icons.call_end;
    }
  }

  Color getIconColor(String status) {
    if (status.contains("Outgoing")) {
      return Colors.green;
    } else if (status.contains("Incoming")) {
      return Colors.blue;
    } else if (status.contains("Rang")) {
      return Colors.orange;
    } else {
      return Colors.red;
    }
  }
}
