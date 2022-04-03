import 'package:flutter/material.dart';
import 'package:flutter_basic/model/contact.dart';

class FormCreateContact extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();

  Function(Contact) addContact;

  FormCreateContact({Key? key, required this.addContact}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
        key: formKey,
        child: Column(
          children: [
            TextFormField(
              controller: nameController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Nama tidak boleh kosong';
                } else {
                  return null;
                }
              },
              decoration: const InputDecoration(
                  label: Text('Nama'), prefixIcon: Icon(Icons.person)),
            ),
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Telepon tidak boleh kosong';
                } else {
                  return null;
                }
              },
              controller: phoneController,
              decoration: const InputDecoration(
                  label: Text('Telepon'), prefixIcon: Icon(Icons.call)),
              keyboardType: TextInputType.phone,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    addContact(Contact(
                        name: nameController.text,
                        phone: phoneController.text));
                    nameController.clear();
                    phoneController.clear();
                  }
                },
                child: const Text('Simpan'),
              ),
            )
          ],
        ));
  }
}
