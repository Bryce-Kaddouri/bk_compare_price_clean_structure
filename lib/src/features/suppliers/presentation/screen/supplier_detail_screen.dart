import 'package:bk_compare_price_mvc/src/core/component/text_field_widget.dart';
import 'package:bk_compare_price_mvc/src/features/suppliers/presentation/provider/supplier_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class SupplierDetailScreen extends StatefulWidget {
  final String supplierId;

  const SupplierDetailScreen({Key? key, required this.supplierId})
      : super(key: key);

  @override
  State<SupplierDetailScreen> createState() => _SupplierDetailScreenState();
}

class _SupplierDetailScreenState extends State<SupplierDetailScreen> {
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SupplierProvider>().getSupplierById(widget.supplierId);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (context.watch<SupplierProvider>().isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else if (context.watch<SupplierProvider>().selectedSupplier == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Supplier Detail'),
          centerTitle: true,
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Get.toNamed('/suppliers');
            },
          ),
        ),
        body: Center(
          child: Text('No Supplier'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(context.watch<SupplierProvider>().selectedSupplier!.name),
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Get.toNamed('/suppliers');
          },
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(125),
              ),
              height: 250,
              width: 250,
              child: Stack(children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(125),
                  ),
                  height: 250,
                  width: 250,
                  child: ClipOval(
                    child: Image.network(
                      context
                          .watch<SupplierProvider>()
                          .suppliers
                          .firstWhere(
                              (element) => element.id == widget.supplierId)
                          .photoUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(125),
                  ),
                  height: 250,
                  width: 250,
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(125),
                      ),
                      height: 50,
                      width: 50,
                      child: IconButton(
                        icon: Icon(
                          Icons.edit,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          print('edit');
                        },
                      ),
                    ),
                  ),
                ),
              ]),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  child: TextFieldWidget(
                      label: 'Supplier Name',
                      controller: context
                          .watch<SupplierProvider>()
                          .editSupplierNameController,
                      errorMessage: context
                          .watch<SupplierProvider>()
                          .editSupplierNameErrorMessage,
                      isEnable: context
                          .watch<SupplierProvider>()
                          .isEditingSupplierName,
                      showSuffixIcon: context
                          .watch<SupplierProvider>()
                          .editSupplierNameErrorMessage
                          .isNotEmpty),
                ),
                if (context.watch<SupplierProvider>().isEditingSupplierName ==
                    true)
                  IconButton(
                      onPressed: () {
                        context
                                .read<SupplierProvider>()
                                .editSupplierNameController
                                .text =
                            context
                                .read<SupplierProvider>()
                                .suppliers
                                .firstWhere((element) =>
                                    element.id == widget.supplierId)
                                .name;
                        context
                            .read<SupplierProvider>()
                            .toggleIsEditingSupplierName();
                      },
                      icon: Icon(Icons.cancel)),
                IconButton(
                    onPressed: () {
                      if (context
                              .read<SupplierProvider>()
                              .isEditingSupplierName ==
                          true) {
                        print('update');
                        if (context
                            .read<SupplierProvider>()
                            .editSupplierNameController
                            .text
                            .isEmpty) {
                          context
                              .read<SupplierProvider>()
                              .setEditSupplierNameErrorMessage(
                                  'Please enter supplier name');
                        } else {
                          context.read<SupplierProvider>().updateNameSupplier(
                              context
                                  .read<SupplierProvider>()
                                  .editSupplierNameController
                                  .text);

                          context
                              .read<SupplierProvider>()
                              .toggleIsEditingSupplierName();
                          context
                              .read<SupplierProvider>()
                              .getSupplierById(widget.supplierId);
                        }
                      } else {
                        context
                            .read<SupplierProvider>()
                            .toggleIsEditingSupplierName();
                      }
                    },
                    icon: Icon(
                        context.watch<SupplierProvider>().isEditingSupplierName
                            ? Icons.check
                            : Icons.edit))
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    color: context
                            .watch<SupplierProvider>()
                            .isEditingSupplierColor
                        ? context.watch<SupplierProvider>().editPickerColor
                        : context
                            .watch<SupplierProvider>()
                            .suppliers
                            .firstWhere(
                                (element) => element.id == widget.supplierId)
                            .color,
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                if (context.watch<SupplierProvider>().isEditingSupplierColor)
                  IconButton(
                    onPressed: () {
                      context
                          .read<SupplierProvider>()
                          .setIsEditingSupplierColor(false);
                    },
                    icon: Icon(Icons.cancel),
                  ),
                IconButton(
                    onPressed: () {
                      if (context
                              .read<SupplierProvider>()
                              .isEditingSupplierColor ==
                          true) {
                        print('update');
                        context.read<SupplierProvider>().updateColorSupplier();
                        Future.delayed(Duration(seconds: 1), () {
                          context
                              .read<SupplierProvider>()
                              .setIsEditingSupplierColor(false);
                          context
                              .read<SupplierProvider>()
                              .getSupplierById(widget.supplierId);
                        });
                      } else {
                        context
                            .read<SupplierProvider>()
                            .showDialogColorPicker(context, true);
                      }
                    },
                    icon: Icon(
                        context.watch<SupplierProvider>().isEditingSupplierColor
                            ? Icons.check
                            : Icons.edit))
              ],
            )
          ],
        ),
      ),
    );
  }
}
