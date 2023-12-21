import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../provider/supplier_provider.dart';

class SuppliersScreen extends StatefulWidget {
  const SuppliersScreen({Key? key}) : super(key: key);

  @override
  State<SuppliersScreen> createState() => _SuppliersScreenState();
}

class _SuppliersScreenState extends State<SuppliersScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SupplierProvider>().getAllSuppliers();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("My Suppliers"),
          centerTitle: true,
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Get.toNamed('/home');
            },
          ),
        ),
        body: Consumer<SupplierProvider>(
          builder: (context, supplierProvider, child) {
            if (supplierProvider.suppliers.isEmpty) {
              return Center(
                child: Text('No Suppliers'),
              );
            }
            return ListView.builder(
              itemCount: supplierProvider.suppliers.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(supplierProvider.suppliers[index].name),
                  subtitle: Text(supplierProvider.suppliers[index].id),
                  onTap: () {
                    Get.toNamed(
                        '/suppliers/detail/${supplierProvider.suppliers[index].id}');
                  },
                );
              },
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.toNamed('/suppliers/add');
          },
          child: const Icon(Icons.add),
          backgroundColor: Colors.green,
        ));
  }
}
