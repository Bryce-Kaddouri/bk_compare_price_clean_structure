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
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final AuthRepository authRepository = AuthRepositoryImpl(dataSource: AuthDataSource(auth: FirebaseAuth.instance));
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
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
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
