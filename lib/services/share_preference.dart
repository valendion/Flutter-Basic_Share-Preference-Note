import 'package:flutter_basic/model/contact.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharePreferenceService {
  Future<List<Contact>> getAll() async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    List<String> fromStorage = storage.getStringList('contacts') ?? [];
    List<Contact> contacts =
        fromStorage.map((e) => Contact.fromJSON(e)).toList();
    return contacts;
  }

  Future<void> add(Contact contact) async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    List<String> fromStorage = storage.getStringList('contacts') ?? [];
    fromStorage.add(contact.toJSON());

    storage.setStringList('contacts', fromStorage);
  }
}
