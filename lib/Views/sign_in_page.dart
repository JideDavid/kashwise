import 'package:flutter/material.dart';
import 'package:kashwise/Services/firebase_services.dart';
import 'package:kashwise/Services/my_printer.dart';
import 'package:kashwise/View_Models/user_details_provider.dart';
import 'package:kashwise/utils/constants/enums.dart';
import 'package:provider/provider.dart';
import '../Services/pref_helper.dart';
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
  bool activeLoginButton = false;
  bool activeSignUpButton = false;
  UserInitType userInitType = UserInitType.login;
  bool usernameExists = false;
  bool emailExists = false;
  final _loginFormKey = GlobalKey<FormState>();
  final _signUpFormKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController resetPasswordController = TextEditingController();

  setLoginButtonActivation() {
    if (emailController.text.isEmpty || passwordController.text.length < 5) {
      setState(() {
        activeLoginButton = false;
      });
    } else {
      setState(() {
        activeLoginButton = true;
      });
    }
  }

  setSignUpButtonActivation() {
    if (emailController.text.isEmpty ||
        usernameController.text.trim().length < 5 ||
        passwordController.text.length < 5 ||
        confirmPasswordController.text.isEmpty ||
        emailExists == true) {
      activeSignUpButton = false;
      setState(() {});
    } else {
      activeSignUpButton = true;
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    setFreshAppSetting();
  }

  setFreshAppSetting()async{
    bool appIsFresh = await PrefHelper().getAppIsFresh();
    if(appIsFresh){
      userInitType = UserInitType.signUp;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    double sw = MediaQuery.of(context).size.width;
    return PopScope(
      canPop: false,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: SizedBox(
            width: SizeConfig.screenWidth,
            height: SizeConfig.screenHeight,
            child: Column(
              children: [
                ///
                /// Appbar
                Column(children: [
                  ///Title and action Button
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(
                            vertical: TSizes.paddingSpaceLg,
                            horizontal: TSizes.paddingSpaceLg
                        ),
                    child: Stack(children: [
                      /// Title
                      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                        Text(
                          userInitType == UserInitType.login ? 'Log In' : 'SignUp',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      ]),

                      /// Actions
                      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                        ///Action button
                        GestureDetector(
                            onTap: () {},
                            child: const Row(
                              children: [],
                            ))
                      ]),
                    ]),
                  ),
                  Divider(
                    color: Colors.grey.withOpacity(0.4),
                    thickness: 0.8,
                    height: 0,
                  )
                ]),

                ///
                ///  Body
                Expanded(
                  child: SingleChildScrollView(
                    child: SizedBox(
                      height: SizeConfig.screenHeight * 0.9,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          userInitType == UserInitType.login
                              ?

                              ///
                              /// Login Input Section
                              Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                                  child: Form(
                                    key: _loginFormKey,
                                    onChanged: setLoginButtonActivation,
                                    child: Column(
                                      children: [
                                        /// Email Label
                                        const Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.symmetric(vertical: TSizes.paddingSpaceSm),
                                              child: Text(
                                                "Email Address",
                                                // style: TextStyle(color: TColors.lightGrey),
                                              ),
                                            ),
                                          ],
                                        ),

                                        ///Email Input Field
                                        TextFormField(
                                          decoration: InputDecoration(
                                              hintText: "youremail@example.com",
                                              hintStyle: Theme.of(context).inputDecorationTheme.hintStyle),
                                          enableSuggestions: true,
                                          validator: (value) {
                                            return TValidator.validateEmail(value!.trim(), emailExists);
                                          },
                                          controller: emailController,
                                        ),
                                        const SizedBox(
                                          height: 16,
                                        ),

                                        /// Password
                                        const Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.symmetric(vertical: TSizes.paddingSpaceSm),
                                              child: Text(
                                                "Password",
                                                // style: TextStyle(color: TColors.lightGrey),
                                              ),
                                            ),
                                          ],
                                        ),

                                        ///Password Input Field
                                        TextFormField(
                                          decoration: InputDecoration(
                                              suffixIcon: IconButton(
                                                onPressed: () {
                                                  _obscure = !_obscure;
                                                  setState(() {});
                                                },
                                                icon: Icon(_obscure ? Icons.visibility_off : Icons.visibility),
                                              ),
                                              hintText: "Enter your Password",
                                              hintStyle: Theme.of(context).inputDecorationTheme.hintStyle),
                                          obscureText: _obscure,
                                          enableSuggestions: true,
                                          validator: (value) {
                                            return TValidator.validatePasswordLogin(value!.trim());
                                          },
                                          controller: passwordController,
                                        ),
                                      ],
                                    ),
                                  ))
                              :

                              ///
                              /// Sign Up Input Section
                              Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                                  child: Form(
                                    key: _signUpFormKey,
                                    onChanged: () {
                                      setSignUpButtonActivation();
                                    },
                                    child: Column(
                                      children: [
                                        ///Email Input Field
                                        TextFormField(
                                          decoration: InputDecoration(
                                              suffixIcon: Visibility(
                                                  visible: emailExists,
                                                  child: const Icon(
                                                    Icons.error_outline,
                                                    color: TColors.accent,
                                                  )),
                                              hintText: "Enter Email",
                                              hintStyle: Theme.of(context).inputDecorationTheme.hintStyle),
                                          enableSuggestions: true,
                                          onChanged: (value) async {
                                            emailExists =
                                                await FirebaseHelper().checkEmailExist(emailController.text.trim());
                                            setSignUpButtonActivation();
                                            setState(() {});
                                            MPrint(activeSignUpButton.toString());
                                          },
                                          validator: (value) {
                                            return TValidator.validateEmail(value!.trim(), emailExists);
                                          },
                                          controller: emailController,
                                        ),
                                        const SizedBox(
                                          height: 16,
                                        ),

                                        ///Username Input Field
                                        TextFormField(
                                          decoration: InputDecoration(
                                              suffixIcon: Visibility(
                                                  visible: usernameExists,
                                                  child: const Icon(
                                                    Icons.error_outline,
                                                    color: TColors.accent,
                                                  )),
                                              hintText: "Enter username",
                                              hintStyle: Theme.of(context).inputDecorationTheme.hintStyle),
                                          enableSuggestions: true,
                                          onChanged: (value) async {
                                            usernameExists = await FirebaseHelper()
                                                .checkUsernameExist(usernameController.text.trim());
                                            setSignUpButtonActivation();
                                            setState(() {});
                                          },
                                          validator: (value) {
                                            return TValidator.validateUsername(value!.trim(), usernameExists);
                                          },
                                          controller: usernameController,
                                        ),
                                        const SizedBox(
                                          height: 16,
                                        ),

                                        ///Password Input Field
                                        TextFormField(
                                          decoration: InputDecoration(
                                              suffixIcon: IconButton(
                                                onPressed: () {
                                                  _obscure = !_obscure;
                                                  setState(() {});
                                                },
                                                icon: Icon(_obscure ? Icons.visibility_off : Icons.visibility),
                                              ),
                                              hintText: "Enter Password",
                                              hintStyle: Theme.of(context).inputDecorationTheme.hintStyle),
                                          obscureText: _obscure,
                                          enableSuggestions: true,
                                          validator: (value) {
                                            return TValidator.validatePasswordLogin(value!.trim());
                                          },
                                          controller: passwordController,
                                        ),
                                        const SizedBox(
                                          height: 16,
                                        ),

                                        ///Confirm Password Input Field
                                        TextFormField(
                                          decoration: InputDecoration(
                                              suffixIcon: IconButton(
                                                onPressed: () {
                                                  _obscure = !_obscure;
                                                  setState(() {});
                                                },
                                                icon: Icon(_obscure ? Icons.visibility_off : Icons.visibility),
                                              ),
                                              hintText: "Confirm Password",
                                              hintStyle: Theme.of(context).inputDecorationTheme.hintStyle),
                                          obscureText: _obscure,
                                          enableSuggestions: true,
                                          validator: (value) {
                                            if (value != passwordController.text.trim()) {
                                              return 'Password does not match!';
                                            } else {
                                              return null;
                                            }
                                          },
                                          controller: confirmPasswordController,
                                        ),
                                      ],
                                    ),
                                  )),

                          ///
                          /// Toggle login - SignUp
                          userInitType == UserInitType.login
                              ? Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: TSizes.paddingSpaceLg),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          const Text('Don\'t have an account?',
                                          ),
                                          const SizedBox(
                                            width: TSizes.paddingSpaceLg,
                                          ),
                                          GestureDetector(
                                              onTap: () {
                                                if (userInitType == UserInitType.login) {
                                                  userInitType = UserInitType.signUp;
                                                } else {
                                                  userInitType = UserInitType.login;
                                                }
                                                emailController.text = '';
                                                passwordController.text = '';
                                                usernameController.text = '';
                                                confirmPasswordController.text = '';
                                                setState(() {});
                                              },
                                              child: Text(
                                                'Sign Up',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall
                                                    ?.copyWith(color: TColors.accent),
                                              )),
                                        ],
                                      ),
                                      GestureDetector(
                                          onTap: () {
                                            showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return AlertDialog(
                                                    title: const Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        Text('Enter Email'),
                                                      ],
                                                    ),
                                                    content: TextField(
                                                      textAlign: TextAlign.center,
                                                      keyboardType: TextInputType.emailAddress,
                                                      controller: resetPasswordController,
                                                    ),
                                                    actions: [
                                                      FilledButton(
                                                          onPressed: () {
                                                            FirebaseHelper()
                                                                .requestChangePassword(
                                                                context, resetPasswordController.text);
                                                          },
                                                          style: Theme.of(context).filledButtonTheme.style?.copyWith(
                                                              backgroundColor:
                                                                  const MaterialStatePropertyAll(TColors.primary)),
                                                          child: Padding(
                                                            padding: const EdgeInsets.symmetric(
                                                                horizontal: TSizes.paddingSpaceLg),
                                                            child: Text(
                                                              'Confirm',
                                                              style: Theme.of(context)
                                                                  .textTheme
                                                                  .bodyLarge
                                                                  ?.copyWith(color: TColors.white),
                                                            ),
                                                          )),
                                                    ],
                                                    actionsAlignment: MainAxisAlignment.center,
                                                  );
                                                });
                                          },
                                          child: Text(
                                            'Forgot password?',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall
                                                ?.copyWith(color: TColors.accent, fontSize: 12),
                                          ))
                                    ],
                                  ),
                                )
                              : Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: TSizes.paddingSpaceLg),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text('Already have an account?',
                                      ),
                                      const SizedBox(
                                        width: TSizes.paddingSpaceLg,
                                      ),
                                      GestureDetector(
                                          onTap: () {
                                            if (userInitType == UserInitType.login) {
                                              userInitType = UserInitType.signUp;
                                            } else {
                                              userInitType = UserInitType.login;
                                            }
                                            emailController.text = '';
                                            passwordController.text = '';
                                            confirmPasswordController.text = '';
                                            setState(() {});
                                          },
                                          child: Text(
                                            'Login',
                                            style:
                                                Theme.of(context).textTheme.bodySmall?.copyWith(color: TColors.accent),
                                          )),
                                    ],
                                  ),
                                ),

                          // SizedBox(height: SizeConfig.screenHeight * 0.4,),

                          const Spacer(),

                          userInitType == UserInitType.login
                              ?

                              ///
                              /// Login Button
                              Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 10,
                                  ),
                                  child: ElevatedButton(
                                      onPressed: activeLoginButton
                                          ? () async {
                                              if (_loginFormKey.currentState!.validate()) {
                                                bool isSignedIn =
                                                    await Provider.of<UserDetailsProvider>(context, listen: false)
                                                        .loginWithEmailAndPassword(context, emailController.text.trim(),
                                                            passwordController.text.trim());
                                                if (isSignedIn) {
                                                  //ignore: use_build_context_synchronously
                                                  Navigator.pushReplacement(context,
                                                      MaterialPageRoute(builder: (context) => const HomeMain()));
                                                }
                                              } else {}
                                            }
                                          : null,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Login",
                                            style: Theme.of(context).textTheme.bodyLarge,
                                          ),
                                        ],
                                      )),
                                )
                              :

                              ///
                              /// Sign Up Button
                              Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 10,
                                  ),
                                  child: ElevatedButton(
                                      onPressed: activeSignUpButton
                                          ? () async {
                                              if (_signUpFormKey.currentState!.validate()) {
                                                bool isSignedIn =
                                                    await Provider.of<UserDetailsProvider>(context, listen: false)
                                                        .createUserWithEmailAndPassword(
                                                            emailController.text.trim(),
                                                            passwordController.text.trim(),
                                                            usernameController.text.trim());
                                                if (isSignedIn) {
                                                  //ignore: use_build_context_synchronously
                                                  Navigator.of(context).pushReplacement(
                                                      MaterialPageRoute(builder: (context) => const HomeMain()));
                                                }
                                              } else {}
                                            }
                                          : null,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Sign Up",
                                            style: Theme.of(context).textTheme.bodyLarge,
                                          ),
                                        ],
                                      )),
                                ),

                          ///
                          ///SizedBox
                          SizedBox(
                            height: sw / 15,
                          ),

                          Text(
                            "Or sign in with google",
                            style: Theme.of(context).textTheme.bodySmall,
                          ),

                          const SizedBox(
                            height: TSizes.paddingSpaceLg,
                          ),

                          /// Google Sign in Button
                          SizedBox(
                            height: SizeConfig.screenWidth * 0.15,
                            width: SizeConfig.screenWidth * 0.15,
                            child: context.watch<UserDetailsProvider>().loading
                                ? CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Theme.of(context).primaryColor,
                                  )
                                : FilledButton(
                                    onPressed: () async {
                                      bool signedIn = await context.read<UserDetailsProvider>().signInWithGoogle(context);
                                      if (signedIn) {
                                        // ignore: use_build_context_synchronously
                                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) {
                                          return const HomeMain();
                                        }));
                                      }
                                    },
                                    style: Theme.of(context).filledButtonTheme.style?.copyWith(
                                        backgroundColor: MaterialStatePropertyAll(Colors.grey.withOpacity(0.1)),
                                        shape: MaterialStatePropertyAll(
                                            RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)))),
                                    child: Image.asset(TImages.googleIcon)),
                          ),

                          const SizedBox(
                            height: TSizes.paddingSpaceLg,
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
