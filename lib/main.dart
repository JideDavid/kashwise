import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'View_Models/login_password_provider.dart';
import 'View_Models/user_details_provider.dart';
import 'View_Models/user_settings_provider.dart';
import 'View_Models/widget_state_provider.dart';
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
    ChangeNotifierProvider(create: (_) => UserDetailsProvider())],
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {

    // Getting user settings
    context.read<UserSettingsProvider>().getSavedThemeMode();
    context.read<UserSettingsProvider>().getBalanceVisibility();

    // Setting screen size configuration
    SizeConfig().init(context);

    return MaterialApp(
      title: 'Flutter Demo',
      theme: context.watch<UserSettingsProvider>().isLightMode
          ? TAppTheme.lightTheme
          : TAppTheme.darkTheme,
      home: const SignInPage(),
    );
  }
}
