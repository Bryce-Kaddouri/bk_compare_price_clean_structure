import 'dart:io';

import 'package:bk_compare_price_mvc/src/features/products/presentation/provider/product_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';

import '../../../../core/component/custom_button.dart';
import '../../../../core/component/text_field_widget.dart';

class AddProductScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: Text("Add Product"), centerTitle: true, automaticallyImplyLeading: false, leading: IconButton(icon: Icon(Icons.arrow_back_ios),onPressed: (){
        Get.toNamed('/products');
      },),),
      body: Column(
        children: [
          SizedBox(height: 20,),
          TextFieldWidget(label: 'Product Name', controller: context.watch<ProductProvider>().addProductNameController, errorMessage: context.watch<ProductProvider>().addProductNameErrorMessage,),
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
              child: context.watch<ProductProvider>().addImagePath.isEmpty ? Icon(Icons.add_a_photo_outlined) : !kIsWeb ? Image.file(File(context.watch<ProductProvider>().addImagePath), fit: BoxFit.cover,) : Image.network(context.watch<ProductProvider>().addImagePath, fit: BoxFit.cover,),
              onTap: () async{
                context.read<ProductProvider>().showBottomSheetSelectSource(context);
              },
            ),
          ),
          SizedBox(height: 20,),
          CustomButton(text: 'Create Supplier', onPressed: ()async{
            String? supplierId = await context.read<ProductProvider>().addProduct(context);
            Get.toNamed('/products/add/upload-image/$supplierId');

          })
        ],
      ),
    );
  }
}