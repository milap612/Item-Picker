import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:item_tracker/form_button_widget.dart';
import 'package:item_tracker/list_item_widget.dart';
import 'package:item_tracker/validator.dart';
import 'package:provider/provider.dart';

import 'app_strings.dart';
import 'decoration.dart';
import 'form_text_field_widget.dart';
import 'item_provider.dart';

class ItemTrackerScreen extends StatelessWidget
    with Validator, WidgetDecoration {
  ItemTrackerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.itemTracker)),
      body: Consumer<ItemProvider>(builder: (context, itemProvider, child) {
        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                controller: itemProvider.scrollController,
                itemCount: itemProvider.items.length,
                itemBuilder: (context, index) =>
                    GestureDetector(
                      key: itemProvider.keys[index],
                      onTap: () => measureWidget(context,index),
                        child: ListItemWidget(itemIndex: index)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Form(
                key: itemProvider.formKey,
                child: Column(
                  children: [
                    FormTextFieldWidget(
                      focusNode: itemProvider.focusItemName,
                      textInputType: TextInputType.name,
                      decoration: textFieldDecoration(AppStrings.name),
                      textEditingController: itemProvider.nameController,
                      validatorFun: (String descriptionValue) =>
                          validateName(descriptionValue),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    FormTextFieldWidget(
                      textInputType: TextInputType.multiline,
                      decoration: textFieldDecoration(AppStrings.description),
                      textEditingController: itemProvider.descriptionController,
                      validatorFun: (String descriptionValue) =>
                          validateDescription(descriptionValue),
                    ),
                    FormButtonWidget(
                      buttonText: itemProvider.editItemBool
                          ? AppStrings.updateItem
                          : AppStrings.addItem,
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  void measureWidget(BuildContext context,int index) {
    final key = context.read<ItemProvider>().keys[index];
    final RenderBox? renderBox = key.currentContext?.findRenderObject() as RenderBox?;
    final size = renderBox?.size;
    final position = renderBox?.localToGlobal(Offset.zero);

    Fluttertoast.showToast(
        msg: "Widget at index $index has size: $size and positioned at: $position",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.blue,
        textColor: Colors.white,
        fontSize: 16.0
    );
    }
}
