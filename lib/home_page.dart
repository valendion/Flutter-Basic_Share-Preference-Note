import 'package:flutter/material.dart';
import 'package:flutter_basic/model/contact.dart';
import 'package:flutter_basic/widget/form_create_contact.dart';

import 'services/share_preference.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final contactServices = SharePreferenceService();
  late Future<List<Contact>> contacts;

  @override
  void initState() {
    contacts = contactServices.getAll();
    super.initState();
  }

  void addContact(BuildContext context, Contact contact) async {
    await contactServices.add(contact);
    setState(() {
      contacts = contactServices.getAll();
    });
    Navigator.of(context, rootNavigator: true).pop();
  }

  void showAddContactForm(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              title: const Text('Tambah Data'),
              content: FormCreateContact(
                addContact: (Contact contact) {
                  addContact(context, contact);
                },
              ));
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PhoneBookApp'),
        actions: [
          Builder(builder: (context) {
            return IconButton(
                onPressed: () {
                  showAddContactForm(context);
                },
                icon: const Icon(Icons.add));
          })
        ],
      ),
      body: FutureBuilder(
          future: contacts,
          builder: (context, AsyncSnapshot<List<Contact>> snapshot) {
            List<Contact> contactFromFuture = snapshot.data ?? [];

            return ListView.builder(
              itemBuilder: (context, index) {
                Contact contact = contactFromFuture[index];
                return ListTile(
                  title: Text(contact.name),
                  subtitle: Text(contact.phone),
                );
              },
              itemCount: snapshot.data?.length ?? 0,
            );
          }),
    );
  }
}
