

import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:bk_compare_price_mvc/src/features/suppliers/data/model/supplier_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';

import '../../business/usecase/add_supplier_usecase.dart';
import '../../business/usecase/delete_supplier_usecase.dart';
import '../../business/usecase/get_all_supplier_usecase.dart';
import '../../business/usecase/get_supplier_by_id_usecase.dart';
import '../../business/usecase/update_photo_url_usecase.dart';
import '../../business/usecase/update_supplier_usecase.dart';
import '../../business/usecase/upload_image_usecase.dart';

class SupplierProvider with ChangeNotifier{

  final AddSupplierUseCase addSupplierUseCase;
  final UploadImageUseCase uploadImageUseCase;
  final GetAllSupplierUseCase getAllSuppliersUseCase;
  final GetSupplierByIdUseCase getSupplierByIdUseCase;
  final UpdateSupplierUseCase updateSupplierUseCase;
  final DeleteSupplierUseCase deleteSupplierUseCase;
  final UpdatePhotoUrlUseCase updatePhotoUrlUseCase;

  SupplierProvider({
    required this.addSupplierUseCase,
    required this.uploadImageUseCase,
    required this.getAllSuppliersUseCase,
    required this.getSupplierByIdUseCase,
    required this.updateSupplierUseCase,
    required this.deleteSupplierUseCase,
    required this.updatePhotoUrlUseCase
  });

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  void setIsLoading(bool isLoading){
    _isLoading = isLoading;
    notifyListeners();
  }

  List<SupplierModel> _suppliers = [];
  List<SupplierModel> get suppliers => _suppliers;
  void setSuppliers(List<SupplierModel> suppliers){
    _suppliers = suppliers;
    notifyListeners();
  }

  void getAllSuppliers() async{
    setIsLoading(true);
    List<SupplierModel> suppliers = await getAllSuppliersUseCase.call();
    setSuppliers(suppliers);
    setIsLoading(false);
  }

  TextEditingController _addSupplierNameController = TextEditingController();
  TextEditingController get addSupplierNameController => _addSupplierNameController;
  void setAddSupplierNameController(String? text){
    _addSupplierNameController = TextEditingController(text: text);
    notifyListeners();
  }

  String _addSupplierNameErrorMessage = '';
  String get addSupplierNameErrorMessage => _addSupplierNameErrorMessage;
  void setAddSupplierNameErrorMessage(String errorMessage){
    _addSupplierNameErrorMessage = errorMessage;
    notifyListeners();
  }

  String _addImagePath = '';
  String get addImagePath => _addImagePath;
  void setAddImagePath(String imagePath){
    _addImagePath = imagePath;
    notifyListeners();
  }

  String _editImagePath = '';
  String get editImagePath => _editImagePath;
  void setEditImagePath(String imagePath){
    _editImagePath = imagePath;
    notifyListeners();
  }

  UploadTask? _addUploadTask;
  UploadTask? get addUploadTask => _addUploadTask;
  void setAddUploadTask(UploadTask? uploadTask){
    _addUploadTask = uploadTask;
    notifyListeners();
  }

  UploadTask? _editUploadTask;
  UploadTask? get editUploadTask => _editUploadTask;
  void setEditUploadTask(UploadTask? uploadTask){
    _editUploadTask = uploadTask;
    notifyListeners();
  }



  ImagePicker _imagePicker = ImagePicker();
  ImagePicker get imagePicker => _imagePicker;
  void setImagePicker(ImagePicker imagePicker){
    _imagePicker = imagePicker;
    notifyListeners();
  }

  void pickImage(ImageSource source) async{
    final pickedFile = await _imagePicker.pickImage(source: source);
    if(pickedFile != null){
      setAddImagePath(pickedFile.path);
      setImageData(await pickedFile.readAsBytes());
    }
  }

  Uint8List? _imageData;
  Uint8List? get imageData => _imageData;
  void setImageData(Uint8List? imageData){
    _imageData = imageData;
    notifyListeners();
  }

  void showBottomSheetSelectSource(BuildContext context){
    showModalBottomSheet(
      context: context,
      builder: (context){
        return Container(
          height: 150,
          child: Column(
            children: [
              ListTile(
                leading: Icon(Icons.camera_alt),
                title: Text('Camera'),
                onTap: (){
                  pickImage(ImageSource.camera);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_album),
                title: Text('Gallery'),
                onTap: (){
                  pickImage(ImageSource.gallery);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      }
    );
  }

  Future<String?> addSupplier(BuildContext context) async{
    setIsLoading(true);
    if(_addSupplierNameController.text.isEmpty){
      setAddSupplierNameErrorMessage('Please enter supplier name');
    }else if(_addImagePath.isEmpty){
      setAddSupplierNameErrorMessage('Please select image');
    }else{
      DateTime now = DateTime.now();
      SupplierModel supplier = SupplierModel(id: '', name: _addSupplierNameController.text, photoUrl: '', createdAt: now, updatedAt: now, color: Color.fromRGBO(Random().nextInt(255), Random().nextInt(255), Random().nextInt(255), 1));

      String? supplierId = await addSupplierUseCase.call(supplier);
      setIsLoading(false);
      print('supplierId: $supplierId');
      if(supplierId != null){
        File file = File(_addImagePath);
        UploadTask? uploadTask = uploadImageUseCase.call(file, supplierId, _imageData!);
       if(uploadTask != null){
         print('uploadTask: $uploadTask');
          setAddUploadTask(uploadTask);

        }else{
          print('Error upload image to storage failed');
        }
      }else{
        print('Error add supplier to firestore failed');
      }
      return supplierId;
    }
  }

void updateSupplier(BuildContext context, String supplierId) async{
    setIsLoading(true);
    if(_addSupplierNameController.text.isEmpty){
      setAddSupplierNameErrorMessage('Please enter supplier name');
    }else{
      DateTime now = DateTime.now();
      SupplierModel supplier = SupplierModel(id: supplierId, name: _addSupplierNameController.text, photoUrl: '', createdAt: now, updatedAt: now, color: _selectedSupplier!.color);

      await updateSupplierUseCase.call(supplier);
      setIsLoading(false);
      print('supplierId: $supplierId');
        File file = File(_addImagePath);
        UploadTask? uploadTask = uploadImageUseCase.call(file, supplierId, _imageData!);
        if(uploadTask != null){
          print('uploadTask: $uploadTask');
          setAddUploadTask(uploadTask);

        }else{
          print('Error upload image to storage failed');
        }

    }
  }

  void updateSupplierPhotoUrl(String supplierId, String photoUrl) async{
    setIsLoading(true);
    await updatePhotoUrlUseCase.call(supplierId, photoUrl);
    setIsLoading(false);
  }

  TextEditingController _editSupplierNameController = TextEditingController();
  TextEditingController get editSupplierNameController => _editSupplierNameController;
  void setEditSupplierNameController(String? text){
    _editSupplierNameController = TextEditingController(text: text);
    notifyListeners();
  }

  String _editSupplierNameErrorMessage = '';
  String get editSupplierNameErrorMessage => _editSupplierNameErrorMessage;
  void setEditSupplierNameErrorMessage(String errorMessage){
    _editSupplierNameErrorMessage = errorMessage;
    notifyListeners();
  }

  bool _isEditingSupplierName = false;
  bool get isEditingSupplierName => _isEditingSupplierName;
  void setIsEditingSupplierName(bool isEditingSupplierName){
    _isEditingSupplierName = isEditingSupplierName;
    notifyListeners();
  }

  void toggleIsEditingSupplierName() {
    setIsEditingSupplierName(!isEditingSupplierName);
  }


  SupplierModel? _selectedSupplier;
  SupplierModel? get selectedSupplier => _selectedSupplier;
  void setSelectedSupplier(SupplierModel? supplier){
    _selectedSupplier = supplier;
    notifyListeners();
  }

  void getSupplierById(String supplierId) async{
    setIsLoading(true);
    SupplierModel? supplier = await getSupplierByIdUseCase.call(supplierId);
    if(supplier != null){
      setSelectedSupplier(supplier);
      setEditSupplierNameController(supplier.name);

    }
    setIsLoading(false);
  }

  void updateNameSupplier(String name){
    String name = _editSupplierNameController.text;
    print('name: $name');
    if(_selectedSupplier!.name != name){
      updateSupplierUseCase.call(SupplierModel(id: _selectedSupplier!.id, name: name, photoUrl: _selectedSupplier!.photoUrl, createdAt: _selectedSupplier!.createdAt, updatedAt: DateTime.now(), color: _selectedSupplier!.color));
    }
  }

}