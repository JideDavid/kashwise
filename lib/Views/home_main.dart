import 'package:flutter/cupertino.dart';
// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kashwise/Services/my_printer.dart';
import 'package:kashwise/View_Models/user_settings_provider.dart';
// import 'package:kashwise/View_Models/user_details_provider.dart';
import 'package:provider/provider.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import '../Services/pref_helper.dart';
import '../View_Models/login_password_provider.dart';
import '../utils/constants/colors.dart';
import '../utils/constants/size_config.dart';
import 'invest.dart';
import 'home_page.dart';
import 'more_page.dart';
// import 'password_page.dart';
import 'pay_page.dart';
import 'send_page.dart';

class HomeMain extends StatefulWidget {
  const HomeMain({super.key});

  @override
  State<HomeMain> createState() => _HomeMainState();
}

class _HomeMainState extends State<HomeMain> with WidgetsBindingObserver{

  int gNavIndex = 0;
  PersistentTabController controller = PersistentTabController(initialIndex: 0);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    PrefHelper().setAppIsFresh(false);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if (state == AppLifecycleState.inactive ||
        state == AppLifecycleState.detached) return;

    final isBackground = state == AppLifecycleState.paused;

    if (isBackground) {
      //checking if the screen is already locked
      if(Provider.of<LoginPasswordProvider>(context, listen: false).isLocked
      ){
        MPrint(">>>>>>>>>>>>>>>  lock screen active  <<<<<<<<<<<<<<<<<<");
      }
      else{
        MPrint(">>>>>>>>>>>>>>>  lock screen not active  <<<<<<<<<<<<<<<<<<");

        // Provider.of<LoginPasswordProvider>(context, listen: false).setIsLocked(true);
        // Navigator.push(context, MaterialPageRoute(builder: (context) => const PasswordLogin()));
      }
    }
  }



  @override
  Widget build(BuildContext context) {


    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: PersistentTabView(
          context,
          controller: controller,
          screens: const [HomePage(), SendPage(), PayPage(), InvestPage(), MorePage()],
          items: [
            PersistentBottomNavBarItem(
              icon: const Icon(Icons.home),
              title: ("Home"),
              activeColorPrimary: TColors.primary,
              inactiveColorPrimary: CupertinoColors.systemGrey,
            ),
            PersistentBottomNavBarItem(
              icon: const Icon(Icons.money),
              title: ("Send"),
              activeColorPrimary: TColors.primary,
              inactiveColorPrimary: CupertinoColors.systemGrey,
            ),
            PersistentBottomNavBarItem(
              icon: const Icon(Icons.bubble_chart),
              title: ("Pay"),
              activeColorPrimary: TColors.primary,
              inactiveColorPrimary: CupertinoColors.systemGrey,
            ),
            PersistentBottomNavBarItem(
              icon: const Icon(Icons.credit_card_sharp),
              title: ("Invest"),
              activeColorPrimary: TColors.primary,
              inactiveColorPrimary: CupertinoColors.systemGrey,
            ),
            PersistentBottomNavBarItem(
              icon: const Icon(Icons.widgets),
              title: ("More"),
              activeColorPrimary: TColors.primary,
              inactiveColorPrimary: CupertinoColors.systemGrey,
            ),
          ],
          confineInSafeArea: true,
          backgroundColor: TColors.grey.withOpacity(0.01), // Default is Colors.white.
          handleAndroidBackButtonPress: true, // Default is true.
          resizeToAvoidBottomInset: false, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
          stateManagement: true, // Default is true.
          hideNavigationBarWhenKeyboardShows: false, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
          decoration: NavBarDecoration(
            borderRadius: BorderRadius.circular(0),
            colorBehindNavBar: Provider.of<UserSettingsProvider>(context).isLightMode
                ? TColors.softWhite : TColors.black,
          ),
          popAllScreensOnTapOfSelectedTab: true,
          popActionScreens: PopActionScreensType.all,
          itemAnimationProperties: const ItemAnimationProperties( // Navigation Bar's items animation properties.
            duration: Duration(milliseconds: 200),
            curve: Curves.ease,
          ),
          screenTransitionAnimation: const ScreenTransitionAnimation( // Screen transition animation on change of selected tab.
            animateTabTransition: true,
            curve: Curves.ease,
            duration: Duration(milliseconds: 200),
          ),
          navBarStyle: NavBarStyle.style9, // Choose the nav bar style with this property.
          navBarHeight: SizeConfig.screenHeight * 0.08,
        ),
        body: gNavIndex == 0
      
            /// HomePage
            ? const SafeArea(child: HomePage())
      
            : gNavIndex == 1
                /// Payment
                ? const SendPage()
      
                : gNavIndex == 2
                    /// Budget
                    ? const PayPage()
      
                    : gNavIndex == 3
                        /// Cards
                        ? const InvestPage()
      
                        /// More
                        : const MorePage()
      ),
    );
  }
}
