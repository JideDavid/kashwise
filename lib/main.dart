import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kashwise/Models/user_model.dart';
import 'package:kashwise/Views/home_main.dart';
import 'package:kashwise/Views/home_tabs/loading.dart';
import 'package:provider/provider.dart';
import 'Services/pref_helper.dart';
import 'View_Models/login_password_provider.dart';
import 'View_Models/user_details_provider.dart';
import 'View_Models/user_settings_provider.dart';
import 'View_Models/widget_state_provider.dart';
import 'Views/onboarding.dart';
import 'Views/sign_in_page.dart';
import 'firebase_options.dart';
import 'utils/constants/size_config.dart';
import 'utils/theme/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => UserSettingsProvider()),
    ChangeNotifierProvider(create: (_) => LoginPasswordProvider()),
    ChangeNotifierProvider(create: (_) => WidgetStateProvider()),
    ChangeNotifierProvider(create: (_) => UserDetailsProvider()),
  ], child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool appIsFresh = true;

  Future<void> getAppFresh() async {
    appIsFresh = (await PrefHelper().getAppIsFresh());
  }

  @override
  void initState() {
    super.initState();
    getAppFresh();
    // Getting user settings
    context.read<UserSettingsProvider>().getSavedThemeMode();
    context.read<UserSettingsProvider>().getBalanceVisibility();
  }

  //Checking if a user is already signed in
  Future<bool> userSignedIn() async{
    // await Future.delayed(const Duration(seconds: 2000));
    User? user = FirebaseAuth.instance.currentUser;
    if(user == null){
      return false;
    }else{
      // await Future.delayed(const Duration(minutes: 50));
      DocumentSnapshot userDetail = await FirebaseFirestore.instance.collection("users").doc(user.uid).get();
      //ignore: use_build_context_synchronously
      Provider.of<UserDetailsProvider>(context, listen: false).setUserDetails(UserDetails.fromJson(userDetail));
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    /// Setting screen size configuration
    SizeConfig().init(context);

    return MaterialApp(
      title: 'Flutter Demo',
      theme: context.watch<UserSettingsProvider>().isLightMode
          ? TAppTheme.lightTheme
          : TAppTheme.darkTheme,
      home: appIsFresh
          ? const OnBoarding()
          :
      FutureBuilder(future: userSignedIn(), initialData: const LoadingPage(), builder: (BuildContext context, AsyncSnapshot<Object> snapshot){
            if(snapshot.data == false){
              return const SignInPage();
            }
            else if(snapshot.data == true){
              return const HomeMain();
            }
            else{
              return const LoadingPage();
            }
      }),


      routes: {
        "/main": (context) => const MyApp(),
        "/signInPage": (context) => const SignInPage(),
      },
    );
  }
}

class InitializeScreen extends StatelessWidget {
  const InitializeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

