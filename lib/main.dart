import 'package:bk_compare_price_mvc/src/features/auth/business/repository/auth_repository.dart';
import 'package:bk_compare_price_mvc/src/features/auth/business/usecase/get_current_user_usecase.dart';
import 'package:bk_compare_price_mvc/src/features/auth/business/usecase/send_password_reset_usecase.dart';
import 'package:bk_compare_price_mvc/src/features/auth/business/usecase/signin_usecase.dart';
import 'package:bk_compare_price_mvc/src/features/auth/business/usecase/signout_usecase.dart';
import 'package:bk_compare_price_mvc/src/features/auth/business/usecase/signup_usecase.dart';
import 'package:bk_compare_price_mvc/src/features/auth/data/datasource/auth_datasource.dart';
import 'package:bk_compare_price_mvc/src/features/auth/data/model/user_model.dart';
import 'package:bk_compare_price_mvc/src/features/auth/data/repository/auth_repository_impl.dart';
import 'package:bk_compare_price_mvc/src/features/auth/presentation/provider/auth_provider.dart';
import 'package:bk_compare_price_mvc/src/features/auth/presentation/screen/signin_screen.dart';
import 'package:bk_compare_price_mvc/src/features/home/presentation/screen/home_screen.dart';
import 'package:bk_compare_price_mvc/src/features/products/business/repository/product_repository.dart';
import 'package:bk_compare_price_mvc/src/features/products/business/usecase/add_product_usecase.dart';
import 'package:bk_compare_price_mvc/src/features/products/business/usecase/delete_product_usecase.dart';
import 'package:bk_compare_price_mvc/src/features/products/business/usecase/get_all_products_usecase.dart';
import 'package:bk_compare_price_mvc/src/features/products/business/usecase/get_product_by_id_usecase.dart';
import 'package:bk_compare_price_mvc/src/features/products/business/usecase/update_photo_url_usecase.dart';
import 'package:bk_compare_price_mvc/src/features/products/business/usecase/update_product_usecase.dart';
import 'package:bk_compare_price_mvc/src/features/products/business/usecase/upload_image_usecase.dart';
import 'package:bk_compare_price_mvc/src/features/products/data/datasource/product_datasource.dart';
import 'package:bk_compare_price_mvc/src/features/products/data/repository/product_repository_impl.dart';
import 'package:bk_compare_price_mvc/src/features/products/presentation/provider/product_provider.dart';
import 'package:bk_compare_price_mvc/src/features/products/presentation/screen/add_product_screen.dart';
import 'package:bk_compare_price_mvc/src/features/products/presentation/screen/product_detail_screen.dart';
import 'package:bk_compare_price_mvc/src/features/products/presentation/screen/products_screen.dart';
import 'package:bk_compare_price_mvc/src/features/products/presentation/screen/uploading_screen.dart';
import 'package:bk_compare_price_mvc/src/features/suppliers/business/repository/supplier_repository.dart';
import 'package:bk_compare_price_mvc/src/features/suppliers/business/usecase/add_supplier_usecase.dart';
import 'package:bk_compare_price_mvc/src/features/suppliers/business/usecase/delete_supplier_usecase.dart';
import 'package:bk_compare_price_mvc/src/features/suppliers/business/usecase/get_all_supplier_usecase.dart';
import 'package:bk_compare_price_mvc/src/features/suppliers/business/usecase/get_supplier_by_id_usecase.dart';
import 'package:bk_compare_price_mvc/src/features/suppliers/business/usecase/update_photo_url_usecase.dart';
import 'package:bk_compare_price_mvc/src/features/suppliers/business/usecase/update_supplier_usecase.dart';
import 'package:bk_compare_price_mvc/src/features/suppliers/business/usecase/upload_image_usecase.dart';
import 'package:bk_compare_price_mvc/src/features/suppliers/data/datasource/supplier_datasource.dart';
import 'package:bk_compare_price_mvc/src/features/suppliers/data/repository/supplier_repository_impl.dart';
import 'package:bk_compare_price_mvc/src/features/suppliers/presentation/provider/supplier_provider.dart';
import 'package:bk_compare_price_mvc/src/features/suppliers/presentation/screen/add_supplier_screen.dart';
import 'package:bk_compare_price_mvc/src/features/suppliers/presentation/screen/supplier_detail_screen.dart';
import 'package:bk_compare_price_mvc/src/features/suppliers/presentation/screen/suppliers_screen.dart';
import 'package:bk_compare_price_mvc/src/features/suppliers/presentation/screen/uploading_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;

  final AuthRepository authRepository = AuthRepositoryImpl(dataSource: AuthDataSource(auth: auth));
  final SupplierRepository supplierRepository = SupplierRepositoryImpl(dataSource: SupplierDataSource(firestore: firestore, storage: storage, auth: auth));
  final ProductRepository productRepository = ProductRepositoryImpl(dataSource: ProductDataSource(firestore: firestore, storage: storage, auth: auth));
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (_) => AuthenticationProvider(
        signupUseCase: SignupUsecase(
          repository: authRepository
        ),
        signinUseCase: SigninUseCase(
          repository: authRepository
        ),
        sendResetPasswordUseCase: SendResetPasswordUseCase(
          repository: authRepository
        ),
        signoutUseCase: SignoutUseCase(
          repository: authRepository
        ),
        getCurrentUserUseCase: GetCurrentUserUseCase(
          repository: authRepository
        ),

      ),
    ),
    ChangeNotifierProvider(create: (_)=>SupplierProvider(
      addSupplierUseCase: AddSupplierUseCase(
        repository: supplierRepository
      ), uploadImageUseCase: UploadImageUseCase(repository: supplierRepository), getAllSuppliersUseCase: GetAllSupplierUseCase(repository: supplierRepository), getSupplierByIdUseCase: GetSupplierByIdUseCase(repository: supplierRepository), updateSupplierUseCase: UpdateSupplierUseCase(supplierRepository: supplierRepository), deleteSupplierUseCase: DeleteSupplierUseCase(supplierRepository: supplierRepository), updatePhotoUrlUseCase: UpdatePhotoUrlUseCase(repository: supplierRepository),
    )),
    ChangeNotifierProvider(create: (_)=>ProductProvider(
      addProductUseCase: AddProductUseCase(repository: productRepository), uploadImageUseCase: ProductUploadImageUseCase(repository: productRepository), getAllProductsUseCase: GetAllProductsUseCase(repository: productRepository), getProductByIdUseCase: GetProductByIdUseCase(repository: productRepository), updateProductUseCase: UpdateProductUseCase(repository: productRepository), deleteProductUseCase: DeleteProductUseCase(repository: productRepository), updatePhotoUrlUseCase: ProductUpdatePhotoUrlUseCase(repository: productRepository),
    )),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      getPages: [
        GetPage(name: '/home', page: () => const HomeScreen()),
        GetPage(name: '/signin', page: () => SigninScreen()),
        GetPage(name: '/signup', page: () => SigninScreen()),
        GetPage(name: '/reset-password', page: () => SigninScreen()),
        GetPage(name: '/suppliers', page: () => const SuppliersScreen()),
        GetPage(name: '/suppliers/add', page: () => const AddSupplierScreen()),
        GetPage(name: '/suppliers/add/upload-image/:id', page: () => UploadingScreen(supplierId: Get.parameters['id']!)),
        GetPage(name: '/suppliers/detail/:id', page: () => SupplierDetailScreen(supplierId: Get.parameters['id']!)),
        GetPage(name: '/products', page: () => ProductsScreen()),
        GetPage(name: '/products/add', page: () => AddProductScreen()),
        GetPage(name: '/products/add/upload-image/:id', page: () => ProductUploadingScreen(productId: Get.parameters['id']!)),
        GetPage(name: '/products/detail/:id', page: () => ProductDetailScreen(productId: Get.parameters['id']!)),


      ],
      title: 'Flutter Demo',
      theme: ThemeData(
        
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: StreamBuilder<UserModel?>(
        stream: AuthDataSource(auth: FirebaseAuth.instance).userStream,
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            print("snapshot.data == null");
            return SigninScreen();
          } else {
            print("snapshot.data != null");
            return const HomeScreen();
          }
        },
      ),
      );
  }
}
