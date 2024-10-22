import 'package:flutter/material.dart';

import '../models/item.dart';

class ItemProvider with ChangeNotifier {
  final FocusNode focusItemName = FocusNode();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey();
  final ScrollController scrollController = ScrollController();
  final List<Item> _items = [];
  final List<GlobalKey> _keys = [];
  bool editItemBool = false;
   int editItemIndex = 0;

  List<Item> get items => _items;

  List<GlobalKey> get keys => _keys;

  void addItem() {
    _items.add(Item(
        name: nameController.text, description: descriptionController.text));
    _keys.add(GlobalKey());
    clearController();
    notifyListeners();
  }

  void editItem() {
    _items[editItemIndex] = Item(
        name: nameController.text, description: descriptionController.text);
    clearController();
    notifyListeners();
  }

  void removeItem(int index) {
    _items.removeAt(index);
    notifyListeners();
  }

  void changeEditMode(bool editItemMode) {
    editItemBool = editItemMode;
    notifyListeners();
  }

  void setEditItemIndex(int itemIndex) {
    editItemIndex = itemIndex;
  }

  void clearController() {
    nameController.clear();
    descriptionController.clear();
    notifyListeners();
  }
}
