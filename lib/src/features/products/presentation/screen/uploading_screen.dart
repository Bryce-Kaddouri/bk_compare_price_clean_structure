import 'package:bk_compare_price_mvc/src/features/products/presentation/provider/product_provider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';

class ProductUploadingScreen extends StatelessWidget {
  String productId;
  ProductUploadingScreen({required this.productId});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Uploading'),
      ),
      body: StreamBuilder<TaskSnapshot?>(
        stream: context.watch<ProductProvider>().addUploadTask?.snapshotEvents,
        builder: (context, snapshot) {
          if(snapshot.hasData){
            if(snapshot.data == null){

            }else{
              double progress = snapshot.data!.bytesTransferred / snapshot.data!.totalBytes;
              if(snapshot.data!.state == TaskState.success){
                snapshot.data!.ref.getDownloadURL().then((value) {
                  context.read<ProductProvider>().updateProductPhotoUrl(productId, value);
                });

                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Upload Success'),
                      SizedBox(height: 20),
                      ElevatedButton(onPressed: (){
                        context.read<ProductProvider>().setAddUploadTask(null);
                        context.read<ProductProvider>().setAddImagePath('');
                        context.read<ProductProvider>().setAddProductNameController('');
                        Get.toNamed('/products');
                      }, child: Text('OK'))
                    ],
                  ),
                );
              }else {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('${(progress * 100).toStringAsFixed(2)} %'),
                      CircularProgressIndicator(value: progress,),
                      SizedBox(height: 20),
                      Text('Uploading...'),
                    ],
                  ),
                );
              }
            }
          }
          print(snapshot.data);
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 20),
                Text('Uploading...'),
              ],
            ),
          );
        }
      ),
    );
  }
}