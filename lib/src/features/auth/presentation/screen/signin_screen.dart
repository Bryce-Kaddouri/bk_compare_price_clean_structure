import 'package:bk_compare_price_mvc/src/core/component/custom_button.dart';
import 'package:bk_compare_price_mvc/src/core/component/text_field_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/auth_provider.dart';

class SigninScreen extends StatelessWidget {
  SigninScreen({Key? key}) : super(key: key);

  // global key for form

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFieldWidget(label: 'Email', controller: context.watch<AuthenticationProvider>().emailSigninController, keyboardType: TextInputType.emailAddress, showSuffixIcon: context.watch<AuthenticationProvider>().signinEmailErrorMessage != null, errorMessage: context.watch<AuthenticationProvider>().signinEmailErrorMessage, ),
              SizedBox(height: 16,),
              TextFieldWidget(label: 'Password', controller: context.watch<AuthenticationProvider>().passwordSigninController, obscureText: context.watch<AuthenticationProvider>().obscureText, keyboardType: TextInputType.visiblePassword, showSuffixIcon: context.watch<AuthenticationProvider>().signinPasswordErrorMessage != null, errorMessage: context.watch<AuthenticationProvider>().signinPasswordErrorMessage, ),
              SizedBox(height: 16,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Checkbox(value: context.watch<AuthenticationProvider>().obscureText, onChanged: (value) => context.read<AuthenticationProvider>().setObscureText(value!)),
                  Text('Show password'),
                ],
              ),
              SizedBox(height: 16,),
              RichText(
                text: TextSpan(
                  text: 'Forgot password?',
                  style: TextStyle(color: Theme.of(context).colorScheme.primary),
                   recognizer: TapGestureRecognizer()
                     ..onTap = () {
                      Navigator.pushNamed(context, '/forgot_password');
                    },
                ),
              ),
              RichText(
                text: TextSpan(
                  text: 'Don\'t have an account? ',
                  style: TextStyle(color: Theme.of(context).textTheme.bodyText1!.color),
                  children: [
                    TextSpan(
                      text: 'Sign up',
                      style: TextStyle(color: Theme.of(context).colorScheme.primary),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.pushNamed(context, '/signup');
                        },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 48,),
              Container(
                child:
              CustomButton(text: 'Submit', onPressed: (){
                String email = context.read<AuthenticationProvider>().emailSigninController.text;
                String password = context.read<AuthenticationProvider>().passwordSigninController.text;
                bool isValid = context.read<AuthenticationProvider>().signinCheck(email, password);
                if(isValid){
                  context.read<AuthenticationProvider>().signin(email, password);
                }

              }, isLoading: context.watch<AuthenticationProvider>().isLoading,),
              ),
            ],
          ),
        ),

    );


  }
}