import 'package:flutter/material.dart';
import 'package:flutter_application_1/Model/ContactModel.dart';
import 'package:flutter_application_1/ui/home/HomeViewModel.dart';
import 'package:stacked/stacked.dart';

class AddToContacts extends StatelessWidget {
  final Contact? contact;
  final int? index;

  AddToContacts({super.key, this.contact, this.index});

  final TextEditingController nameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (contact != null) {
      nameController.text = contact!.name;
      usernameController.text = contact!.username;
      phoneController.text = contact!.phone;
    }

    return ViewModelBuilder<HomeViewModel>.nonReactive(
      viewModelBuilder: () => HomeViewModel(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey[50],
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            color: Colors.black,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: const Text(
            'Add To Contacts',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.check),
              color: Colors.black,
              onPressed: () {
                Contact newContact = Contact(
                  name: nameController.text.trim(),
                  username: usernameController.text.trim(),
                  phone: phoneController.text.trim(),
                );
                model.addContact(newContact);
                Navigator.pop(context, newContact);
              },
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Name',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  labelStyle: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    letterSpacing: 1,
                  ),
                  hintText: 'Enter Name',
                  hintStyle: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.normal,
                    color: Colors.grey,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Username',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: usernameController,
                decoration: InputDecoration(
                  labelStyle: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    letterSpacing: 1,
                  ),
                  hintText: 'Enter Username',
                  hintStyle: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.normal,
                    color: Colors.grey,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Phone No',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: phoneController,
                decoration: InputDecoration(
                  labelStyle: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    letterSpacing: 1,
                  ),
                  hintText: '+92 _ _ _ _ _ _ _ _ _ _',
                  hintStyle: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.normal,
                    color: Colors.grey,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
