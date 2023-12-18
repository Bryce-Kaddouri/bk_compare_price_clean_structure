import 'dart:io';

import 'package:bk_compare_price_mvc/src/core/component/custom_button.dart';
import 'package:bk_compare_price_mvc/src/core/component/text_field_widget.dart';
import 'package:bk_compare_price_mvc/src/features/suppliers/presentation/provider/supplier_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';

class AddSupplierScreen extends StatelessWidget{
  const AddSupplierScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: Text("Add Supplier"), centerTitle: true, automaticallyImplyLeading: false, leading: IconButton(icon: Icon(Icons.arrow_back_ios),onPressed: (){
        Get.toNamed('/suppliers');
      },),),
      body: Column(
        children: [
          SizedBox(height: 20,),
          TextFieldWidget(label: 'Supplier Name', controller: context.watch<SupplierProvider>().addSupplierNameController, errorMessage: context.watch<SupplierProvider>().addSupplierNameErrorMessage,),
          SizedBox(height: 20,),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(5),
            ),
            height: 250,
            width: 250,
            child:
            InkWell(
              child: context.watch<SupplierProvider>().addImagePath.isEmpty ? Icon(Icons.add_a_photo_outlined) : !kIsWeb ? Image.file(File(context.watch<SupplierProvider>().addImagePath), fit: BoxFit.cover,) : Image.network(context.watch<SupplierProvider>().addImagePath, fit: BoxFit.cover,),
              onTap: () async{
                context.read<SupplierProvider>().showBottomSheetSelectSource(context);
              },
            ),
          ),
          SizedBox(height: 20,),
          CustomButton(text: 'Create Supplier', onPressed: ()async{
            String? supplierId = await context.read<SupplierProvider>().addSupplier(context);
            print('supplierId from add screen: $supplierId');
            Get.toNamed('/suppliers/add/upload-image/$supplierId');

          })
        ],
      ),
    );
    }
}