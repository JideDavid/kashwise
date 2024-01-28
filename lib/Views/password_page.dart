import 'package:flutter/material.dart';
import 'package:kashwise/View_Models/user_details_provider.dart';
import 'package:kashwise/Views/sign_in_page.dart';
import 'package:provider/provider.dart';
import '../Custom_Widgets/mdot.dart';
import '../View_Models/login_password_provider.dart';
import '../utils/constants/size_config.dart';
import '../utils/custom_widgets/number_button.dart';

class PasswordLogin extends StatelessWidget {
  const PasswordLogin({super.key});


  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: ()async { return false; },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                children: [

                  ///
                  ///User Display
                  SizedBox(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ///User Display Picture
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: CircleAvatar(
                          backgroundColor: Theme.of(context).primaryColor,
                          radius: SizeConfig.screenWidth * 0.15,),
                        ),
                        ///Greeting Text
                        Text("Welcome Back", style: Theme.of(context).textTheme.headlineLarge,),
                        ///User Name
                        Text("User 001", style: Theme.of(context).textTheme.bodyMedium,),


                      ],
                    ),
                  ),

                  ///
                  ///Entry Feedback
                  SizedBox(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.lock_person,color: Theme.of(context).primaryColor,),
                            const SizedBox(width: 8,),
                            const Text("Passcode")                        ],
                        ),
                        const SizedBox(height: 12,),
                        SizedBox(
                          width: SizeConfig.screenWidth * 0.5,
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              MDot(activeIndex: 1),
                              MDot(activeIndex: 2),
                              MDot(activeIndex: 3),
                              MDot(activeIndex: 4),
                              MDot(activeIndex: 5),
                              MDot(activeIndex: 6),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  ///
                  /// Number Buttons
                  SizedBox(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            NumberButton(text: "1", function: (){
                              context.read<LoginPasswordProvider>().addEntry(1);
                              if(context.read<LoginPasswordProvider>().authenticateCode()){
                                Navigator.of(context).pop();
                              }
                            },
                                color: Colors.grey,
                                style: Theme.of(context).textTheme.headlineLarge!),
                            NumberButton(text: "2", function: (){
                              context.read<LoginPasswordProvider>().addEntry(2);
                              if(context.read<LoginPasswordProvider>().authenticateCode()){
                                Navigator.of(context).pop();
                              }
                            },
                                color: Colors.grey,
                                style: Theme.of(context).textTheme.headlineLarge!),
                            NumberButton(text: "3", function: (){
                              //adding number entry
                              context.read<LoginPasswordProvider>().addEntry(3);
                              //setting screen activeness to false
                              if(context.read<LoginPasswordProvider>().authenticateCode()){
                                Navigator.of(context).pop();
                              }
                            },
                                color: Colors.grey,
                                style: Theme.of(context).textTheme.headlineLarge!),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            NumberButton(text: "4", function: (){
                              context.read<LoginPasswordProvider>().addEntry(4);
                              if(context.read<LoginPasswordProvider>().authenticateCode()){
                                Navigator.of(context).pop();
                              }
                            },
                                color: Colors.grey,
                                style: Theme.of(context).textTheme.headlineLarge!),
                            NumberButton(text: "5", function: (){
                              context.read<LoginPasswordProvider>().addEntry(5);
                              if(context.read<LoginPasswordProvider>().authenticateCode()){
                                Navigator.of(context).pop();
                              }
                            },
                                color: Colors.grey,
                                style: Theme.of(context).textTheme.headlineLarge!),
                            NumberButton(text: "6", function: (){
                              context.read<LoginPasswordProvider>().addEntry(6);
                              if(context.read<LoginPasswordProvider>().authenticateCode()){
                                Navigator.of(context).pop();
                              }
                            },
                                color: Colors.grey,
                                style: Theme.of(context).textTheme.headlineLarge!),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            NumberButton(text: "7", function: (){
                              context.read<LoginPasswordProvider>().addEntry(7);
                              if(context.read<LoginPasswordProvider>().authenticateCode()){
                                Navigator.of(context).pop();
                              }
                            },
                                color: Colors.grey,
                                style: Theme.of(context).textTheme.headlineLarge!),
                            NumberButton(text: "8", function: (){
                              context.read<LoginPasswordProvider>().addEntry(8);
                              if(context.read<LoginPasswordProvider>().authenticateCode()){
                                Navigator.of(context).pop();
                              }
                            },
                                color: Colors.grey,
                                style: Theme.of(context).textTheme.headlineLarge!),
                            NumberButton(text: "9", function: (){
                              context.read<LoginPasswordProvider>().addEntry(9);
                              if(context.read<LoginPasswordProvider>().authenticateCode()){
                                Navigator.of(context).pop();
                              }
                            },
                                color: Colors.grey,
                                style: Theme.of(context).textTheme.headlineLarge!),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            NumberButton(text: "Sign Out", function: (){
                              Provider.of<UserDetailsProvider>(context, listen: false).signOutGoogleUser();
                              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const SignInPage()));
                            },
                                color: Theme.of(context).primaryColor,
                                style: Theme.of(context).textTheme.bodyLarge!),
                            NumberButton(text: "0", function: (){
                              context.read<LoginPasswordProvider>().addEntry(0);
                              if(context.read<LoginPasswordProvider>().authenticateCode()){
                                Navigator.of(context).pop();
                              }
                            },
                                color: Colors.grey,
                                style: Theme.of(context).textTheme.headlineLarge!),
                            NumberButton(text: context.watch<LoginPasswordProvider>().entries.isEmpty
                                ?"" : "Delete", function: (){
                              context.read<LoginPasswordProvider>().removeLastEntry();
                              context.read<LoginPasswordProvider>().setIsLocked(false);
                            },
                                color: Theme.of(context).primaryColor,
                                style: Theme.of(context).textTheme.bodyLarge!),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}