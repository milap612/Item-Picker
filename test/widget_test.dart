import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:item_tracker/providers/item_provider.dart';
import 'package:item_tracker/screen/item_tracker_screen.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets('Add item test', (WidgetTester tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (context) => ItemProvider(),
        child: MaterialApp(home: ItemTrackerScreen()),
      ),
    );

    final nameField = find.byType(TextField).first;
    final descriptionField = find.byType(TextField).at(1);
    final addButton = find.text('Add Item');

    await tester.enterText(nameField, 'Test Item');
    await tester.enterText(descriptionField, 'Test Description');
    await tester.tap(addButton);
    await tester.pump();
    expect(find.text('Test Item'), findsOneWidget);
    expect(find.text('Test Description'), findsOneWidget);
  });

  testWidgets('Edit item test', (WidgetTester tester) async {
    final provider = ItemProvider();
    provider.nameController.text = 'Test Item';
    provider.descriptionController.text = 'Test Description';
    provider.addItem();

    await tester.pumpWidget(
      ChangeNotifierProvider.value(
        value: provider,
        child: MaterialApp(home: ItemTrackerScreen()),
      ),
    );

    expect(find.text('Test Item'), findsOneWidget);
    expect(find.text('Test Description'), findsOneWidget);

    final editButton = find.byIcon(Icons.edit).first;
    await tester.tap(editButton);

    await tester.enterText(find.byType(TextField).first, 'Edited Item');
    await tester.enterText(find.byType(TextField).at(1), 'Edited Description');

    await tester.tap(find.text('Update Item'));
    await tester.pump();

    expect(find.text('Edited Item'), findsOneWidget);
    expect(find.text('Edited Description'), findsOneWidget);
    expect(find.text('Initial Item'),
        findsNothing);
  });

  testWidgets('Remove item test', (WidgetTester tester) async {
    final provider = ItemProvider();
    provider.nameController.text = 'Item to be Removed';
    provider.descriptionController.text = 'Item to be Description';
    provider.addItem();

    await tester.pumpWidget(
      ChangeNotifierProvider.value(
        value: provider,
        child: MaterialApp(home: ItemTrackerScreen()),
      ),
    );

    expect(find.text('Item to be Removed'), findsOneWidget);
    expect(find.text('Item to be Description'), findsOneWidget);

    final removeButton = find.byIcon(Icons.delete).first;
    await tester.tap(removeButton);

    await tester.pump();

    expect(find.text('Item to be Removed'), findsNothing);
    expect(find.text('Item to be Description'), findsNothing);
  });

  testWidgets('RenderBox test for item position and size', (WidgetTester tester) async {
    final provider = ItemProvider();
    final imageTicker = ItemTrackerScreen();

    provider.nameController.text = 'Render Item';
    provider.descriptionController.text = 'Render Description';
    provider.addItem();

    await tester.pumpWidget(
      ChangeNotifierProvider.value(
        value: provider,
        child: MaterialApp(home: imageTicker),
      ),
    );
    final BuildContext context = tester.element(find.byType(Container));

    final listItem = find.byType(ListTile).first;

    expect(listItem, findsOneWidget);
    imageTicker.measureWidget(context, 0);

  });

}
