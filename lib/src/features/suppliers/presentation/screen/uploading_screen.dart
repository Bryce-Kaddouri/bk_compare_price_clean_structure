import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';

import '../provider/supplier_provider.dart';

class UploadingScreen extends StatelessWidget {
  String supplierId;
  UploadingScreen({required this.supplierId});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Uploading'),
      ),
      body: StreamBuilder<TaskSnapshot?>(
        stream: context.watch<SupplierProvider>().addUploadTask?.snapshotEvents,
        builder: (context, snapshot) {
          if(snapshot.hasData){
            if(snapshot.data == null){

            }else{
              double progress = snapshot.data!.bytesTransferred / snapshot.data!.totalBytes;
              if(snapshot.data!.state == TaskState.success){
                snapshot.data!.ref.getDownloadURL().then((value) {
                  context.read<SupplierProvider>().updateSupplierPhotoUrl(supplierId, value);
                });

                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Upload Success'),
                      SizedBox(height: 20),
                      ElevatedButton(onPressed: (){
                        context.read<SupplierProvider>().setAddUploadTask(null);
                        context.read<SupplierProvider>().setAddImagePath('');
                        context.read<SupplierProvider>().setAddSupplierNameController('');
                        Get.toNamed('/suppliers');
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