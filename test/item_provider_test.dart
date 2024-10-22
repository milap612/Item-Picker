import 'package:flutter_test/flutter_test.dart';
import 'package:item_tracker/item_provider.dart';


void main() {
  test('Add item to the list', () {
    final provider = ItemProvider();

    provider.nameController.text = 'Test Item';
    provider.descriptionController.text = 'Test Description';

    provider.addItem();
    expect(provider.items.length, 1);
    expect(provider.items[0].name, 'Test Item');
  });
  test('Edit item to the list', () {
    final provider = ItemProvider();

    provider.nameController.text = 'Test Item';
    provider.descriptionController.text = 'Test Description';

    provider.addItem();

    expect(provider.items.length, 1);
    expect(provider.items[0].name, 'Test Item');

    provider.nameController.text = 'Edit Item';
    provider.descriptionController.text = 'Edit Description';
    provider.editItemIndex = 0;
    provider.editItem();

    expect(provider.items.length, 1);
    expect(provider.items[0].name, 'Edit Item');
  });

  test('Delete item to the list', () {
    final provider = ItemProvider();

    provider.nameController.text = 'Deleted Item';
    provider.descriptionController.text = 'Deleted Description';

    provider.addItem();

    expect(provider.items.length, 1);
    expect(provider.items[0].name, 'Deleted Item');

    provider.removeItem(provider.editItemIndex);

    expect(provider.items.length, 0);
  });
}
