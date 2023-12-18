import 'dart:io';
import 'dart:typed_data';

import 'package:bk_compare_price_mvc/src/features/products/business/usecase/get_all_products_usecase.dart';
import 'package:bk_compare_price_mvc/src/features/products/data/model/product_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../business/usecase/update_photo_url_usecase.dart';
import '../../business/usecase/upload_image_usecase.dart';
import '../../business/usecase/add_product_usecase.dart';
import '../../business/usecase/delete_product_usecase.dart';
import '../../business/usecase/get_product_by_id_usecase.dart';
import '../../business/usecase/update_product_usecase.dart';

class ProductProvider with ChangeNotifier{

  final AddProductUseCase addProductUseCase;
  final ProductUploadImageUseCase uploadImageUseCase;
  final GetAllProductsUseCase getAllProductsUseCase;
  final GetProductByIdUseCase getProductByIdUseCase;
  final UpdateProductUseCase updateProductUseCase;
  final DeleteProductUseCase deleteProductUseCase;
  final ProductUpdatePhotoUrlUseCase updatePhotoUrlUseCase;

  ProductProvider({
    required this.addProductUseCase,
    required this.uploadImageUseCase,
    required this.getAllProductsUseCase,
    required this.getProductByIdUseCase,
    required this.updateProductUseCase,
    required this.deleteProductUseCase,
    required this.updatePhotoUrlUseCase,
  });

  List<ProductModel> _products = [];
  List<ProductModel> get products => _products;
  void setProducts(List<ProductModel> products){
    _products = products;
    notifyListeners();
  }

  void getAllProducts() async{
    setIsLoading(true);
    List<ProductModel> products = await getAllProductsUseCase.call();
    print('products: ${products[0].id}');
    setProducts(products);
    setIsLoading(false);
  }

  void getProductById(String productId) async{
    setIsLoading(true);
    ProductModel? product = await getProductByIdUseCase.call(productId);
    if(product != null){
      setSelectedProduct(product);
      setEditProductNameController(product.name);

    }
    setIsLoading(false);
  }

  TextEditingController _editProductNameController = TextEditingController();
  TextEditingController get editProductNameController => _editProductNameController;
  void setEditProductNameController(String? text){
    _editProductNameController = TextEditingController(text: text);
    notifyListeners();
  }

  String _editProductNameErrorMessage = '';
  String get editProductNameErrorMessage => _editProductNameErrorMessage;
  void setEditProductNameErrorMessage(String errorMessage){
    _editProductNameErrorMessage = errorMessage;
    notifyListeners();
  }

  bool _isEditingProductName = false;
  bool get isEditingProductName => _isEditingProductName;
  void setIsEditingProductName(bool isEditingProductName){
    _isEditingProductName = isEditingProductName;
    notifyListeners();
  }

  void toggleIsEditingProductName() {
    setIsEditingProductName(!isEditingProductName);
  }


  ProductModel? _selectedProduct;
  ProductModel? get selectedProduct => _selectedProduct;
  void setSelectedProduct(ProductModel? product){
    _selectedProduct = product;
    notifyListeners();
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  void setIsLoading(bool isLoading){
    _isLoading = isLoading;
    notifyListeners();
  }

  bool _isEditingName = false;
  bool get isEditingName => _isEditingName;
  void setIsEditingName(bool isEditingName){
    _isEditingName = isEditingName;
    notifyListeners();
  }

  TextEditingController _addProductNameController = TextEditingController();
  TextEditingController get addProductNameController => _addProductNameController;
  void setAddProductNameController(String value){
    _addProductNameController.text = value;
    notifyListeners();
  }

  String _addProductNameErrorMessage = '';
  String get addProductNameErrorMessage => _addProductNameErrorMessage;
  void setAddProductNameErrorMessage(String value){
    _addProductNameErrorMessage = value;
    notifyListeners();
  }

  String _addImagePath = '';
  String get addImagePath => _addImagePath;
  void setAddImagePath(String value){
    _addImagePath = value;
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

  Future<String?> addProduct(BuildContext context) async{
    setIsLoading(true);
    if(_addProductNameController.text.isEmpty){
      setAddProductNameErrorMessage('Please enter supplier name');
    }else if(_addImagePath.isEmpty){
      setAddProductNameErrorMessage('Please select image');
    }else{
      DateTime now = DateTime.now();
      ProductModel productModel = ProductModel(id: '', name: _addProductNameController.text, photoUrl: '', createdAt: now, updatedAt: now, prices: []);

      String? supplierId = await addProductUseCase.call(productModel);
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

  void updateProductPhotoUrl(String supplierId, String photoUrl) async{
    setIsLoading(true);
    await updatePhotoUrlUseCase.call(supplierId, photoUrl);
    setIsLoading(false);
  }

  void updateNameProduct(String name){
    String name = _editProductNameController.text;
    print('name: $name');
    if(_selectedProduct!.name != name){
      updateProductUseCase.call(ProductModel(id: _selectedProduct!.id, name: name, photoUrl: _selectedProduct!.photoUrl, createdAt: _selectedProduct!.createdAt, updatedAt: DateTime.now(), prices: _selectedProduct!.prices));
    }
  }
}
