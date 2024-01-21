import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kashwise/View_Models/user_details_provider.dart';
import 'package:nonce/nonce.dart';
import 'package:provider/provider.dart';
import '../View_Models/user_settings_provider.dart';
import '../utils/constants/colors.dart';
import '../utils/constants/image_strings.dart';
import '../utils/constants/size_config.dart';
import '../utils/constants/sizes.dart';
import '../utils/validators/validation.dart';
import 'home_main.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});


  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {

  bool _obscure = true;
  bool valid = false;
  bool activeButton = false;
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  setButtonActivation(){
    if(emailController.text.isEmpty
        || passwordController.text.length < 5){
      setState(() {
        activeButton = false;
      });
    }

    else{
      setState(() {
        activeButton = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double sw = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: ()async{ return false;},
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Column(
            children: [
              ///
              /// FAQ button
               Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: TColors.accent,
                      child: IconButton(
                          onPressed: context.read<UserSettingsProvider>().changeLightMode,
                          icon: const Icon(
                            Icons.question_mark,
                            color: TColors.primary,
                          )),
                    )
                  ],
                ),
              ),

              ///
              ///Divider
              Divider(
                thickness: 2,
                color: Colors.grey.withOpacity(0.2),
              ),

              ///
              ///SizedBox
              SizedBox(
                height: sw / 8,
              ),

              ///
              /// Brand Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ///Logo
                    Container(
                      height: sw / 4,
                      width: sw / 4,
                      decoration: BoxDecoration(
                          color: TColors.primary,
                          borderRadius: BorderRadius.circular(30)),
                    ),

                    ///SizedBox
                    const SizedBox(
                      height: 16,
                    ),

                    ///Greeting Text
                    Text(
                      "Hey there!",
                      style: Theme.of(context).textTheme.headlineLarge,
                    )
                  ],
                ),
              ),

              ///
              /// Input Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: Form(
                  key: _formKey,
                  onChanged: setButtonActivation,
                  child: Column(
                    children: [
                      ///Email Input Field
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: "Enter Email",
                          hintStyle: Theme.of(context).inputDecorationTheme.hintStyle
                        ),
                        enableSuggestions: true,
                        validator: (value){
                          return TValidator.validateEmail(value!.trim());
                        },
                        controller: emailController,
                      ),
                      const SizedBox(height: 16,),

                      ///Password Input Field
                      TextFormField(
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            onPressed: (){
                              _obscure = !_obscure;
                              setState(() {});
                            },
                            icon: Icon( _obscure ? Icons.visibility_off : Icons.visibility),
                          ),
                            hintText: "Enter Password",
                            hintStyle: Theme.of(context).inputDecorationTheme.hintStyle
                        ),
                        obscureText: _obscure,
                        enableSuggestions: true,
                        validator: (value){
                          return TValidator.validatePasswordLogin(value!.trim());
                        },
                        controller: passwordController,
                      ),
                    ],
                  ),
                )
              ),

              ///
              /// Submit Button
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                child: ElevatedButton(
                    onPressed: activeButton ? (){
                      if(_formKey.currentState!.validate()){
                        setState(() {
                          valid = true;
                        });
                        //log user in with credentials
                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const HomeMain()));
                      }
                      else{
                        setState(() {
                          valid = false;
                        });
                      }
                    }
                    : null,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Sign In",
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    )),
              ),

              const Spacer(),

              Text("Or sign in with google", style: Theme.of(context).textTheme.bodySmall,),

              const SizedBox(height: TSizes.paddingSpaceLg,),

              /// Google Sign in Button
              SizedBox(
                height: SizeConfig.screenWidth * 0.15,
                  width: SizeConfig.screenWidth * 0.15,
                  child: FilledButton(
                      onPressed: () async {
                        bool signedIn = await context.read<UserDetailsProvider>().signInWithGoogle();
                        if(signedIn){
                          // ignore: use_build_context_synchronously
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_){
                            return const HomeMain();
                          }));
                        }
                      },
                      style: Theme.of(context).filledButtonTheme.style?.copyWith(
                        backgroundColor: MaterialStatePropertyAll(Colors.grey.withOpacity(0.1)),
                        shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)))
                      ),
                      child: Image.asset(TImages.googleIcon)),
              ),

              const Spacer(),

              ///Dev Button
              GestureDetector(
                onTap: (){
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const HomeMain()));
                },
                child: Center(child: Text('Dev In', style: TextStyle(color: Colors.grey.withOpacity(0.1)),)),
              ),

              const SizedBox(height: 10,)
            ],
          ),
        ),
      ),
    );
  }
}
