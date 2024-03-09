import 'package:flutter/material.dart';
import 'package:kashwise/Services/airtime_data_services.dart';
import 'package:kashwise/View_Models/user_details_provider.dart';
import 'package:kashwise/utils/constants/enums.dart';
import 'package:kashwise/utils/custom_widgets/loading_screen_overlay.dart';
import 'package:kashwise/utils/custom_widgets/m_error_dialog.dart';
import 'package:provider/provider.dart';
import '../../utils/constants/image_strings.dart';
import '../../utils/constants/size_config.dart';
import '../../utils/constants/sizes.dart';
import '../../utils/validators/validation.dart';

class AirtimePage extends StatefulWidget {
  const AirtimePage({super.key});

  @override
  State<AirtimePage> createState() => _AirtimePageState();
}

class _AirtimePageState extends State<AirtimePage> {
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  ServiceProvider serviceProvider = ServiceProvider.airtel;
  double amount = 0;
  final airtimeFormKey = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: PopScope(
        canPop: !isLoading,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Stack(
            children: [

              Column(
              children: [
                ///
                /// Appbar
                Column(children: [
                  ///Title and action Button
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: TSizes.paddingSpaceLg, horizontal: TSizes.paddingSpaceLg),
                    child: Stack(alignment: AlignmentDirectional.center, children: [
                      /// Title
                      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                        Text(
                          'Airtime',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      ]),

                      /// Actions
                      SizedBox(
                        height: 20,
                        child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Icon(Icons.arrow_back_ios_outlined),
                          )
                        ]),
                      ),
                    ]),
                  ),
                  Divider(
                    color: Colors.grey.withOpacity(0.4),
                    thickness: 0.8,
                    height: 0,
                  )
                ]),

                ///
                /// Body content
                SizedBox(
                  height: SizeConfig.screenHeight * 0.7,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: TSizes.paddingSpaceXl, vertical: TSizes.paddingSpaceXl),
                    child: Column(
                      children: [

                        Form(
                          key: airtimeFormKey,
                          child: Column(
                            children: [

                              /// phone Label
                              const Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(vertical: TSizes.paddingSpaceSm),
                                    child: Text(
                                      "Phone Number",
                                      // style: TextStyle(color: TColors.lightGrey),
                                    ),
                                  ),
                                ],
                              ),

                              ///Phone Input Field
                              TextFormField(
                                keyboardType: TextInputType.phone,
                                decoration: InputDecoration(
                                    hintText: "Enter your phone number",
                                    hintStyle: Theme.of(context).inputDecorationTheme.hintStyle),
                                enableSuggestions: true,
                                validator: (value) {
                                  return TValidator.validatePhoneNumber(value!.trim());
                                },
                                controller: phoneNumberController,
                              ),
                              const SizedBox(
                                height: 16,
                              ),

                              /// phone Label
                              const Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(vertical: TSizes.paddingSpaceSm),
                                    child: Text(
                                      "Amount",
                                      // style: TextStyle(color: TColors.lightGrey),
                                    ),
                                  ),
                                ],
                              ),

                              ///amount Input Field
                              TextFormField(
                                keyboardType: TextInputType.phone,
                                decoration: InputDecoration(
                                    hintText: "Enter Amount",
                                    hintStyle: Theme.of(context).inputDecorationTheme.hintStyle),
                                enableSuggestions: true,
                                validator: (value) {
                                  return TValidator.validatePhoneNumber(value!.trim());
                                },
                                controller: amountController,
                              ),
                              const SizedBox(
                                height: 16,
                              ),

                              /// Service provider Label
                              const Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(vertical: TSizes.paddingSpaceSm),
                                    child: Text(
                                      "Service Provider",
                                      // style: TextStyle(color: TColors.lightGrey),
                                    ),
                                  ),
                                ],
                              ),

                            ],
                          ),
                        ),

                        /// Service providers
                        FittedBox(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              /// Airtel
                              FilledButton(
                                  style: Theme.of(context).filledButtonTheme.style!.copyWith(
                                      fixedSize: MaterialStatePropertyAll(
                                          Size(SizeConfig.screenWidth * 0.22, SizeConfig.screenWidth * 0.22)),
                                      padding: const MaterialStatePropertyAll(EdgeInsets.all(0))),
                                  onPressed: () {
                                    setState(() {
                                      serviceProvider = ServiceProvider.airtel;
                                    });
                                  },
                                  child: Container(
                                    decoration:
                                    BoxDecoration(image: DecorationImage(image: AssetImage(
                                        serviceProvider == ServiceProvider.airtel
                                            ? TImages.airtelActive
                                            : TImages.airtelDisable))),
                                  )),
                              const SizedBox(
                                width: TSizes.paddingSpaceLg,
                              ),

                              /// Glo
                              FilledButton(
                                  style: Theme.of(context).filledButtonTheme.style!.copyWith(
                                      fixedSize: MaterialStatePropertyAll(
                                          Size(SizeConfig.screenWidth * 0.22, SizeConfig.screenWidth * 0.22)),
                                      padding: const MaterialStatePropertyAll(EdgeInsets.all(0))),
                                  onPressed: () {
                                    setState(() {
                                      serviceProvider = ServiceProvider.glo;
                                    });
                                  },
                                  child: Container(
                                    decoration:
                                    BoxDecoration(image: DecorationImage(image: AssetImage(
                                        serviceProvider == ServiceProvider.glo
                                            ? TImages.gloActive
                                            : TImages.gloDisable))),
                                  )),
                              const SizedBox(
                                width: TSizes.paddingSpaceLg,
                              ),

                              /// mtn
                              FilledButton(
                                  style: Theme.of(context).filledButtonTheme.style!.copyWith(
                                      fixedSize: MaterialStatePropertyAll(
                                          Size(SizeConfig.screenWidth * 0.22, SizeConfig.screenWidth * 0.22)),
                                      padding: const MaterialStatePropertyAll(EdgeInsets.all(0))),
                                  onPressed: () {
                                    setState(() {
                                      serviceProvider = ServiceProvider.mtn;
                                    });
                                  },
                                  child: Container(
                                    decoration:
                                    BoxDecoration(image: DecorationImage(image: AssetImage(
                                        serviceProvider == ServiceProvider.mtn
                                            ? TImages.mtnActive
                                            : TImages.mtnDisable))),
                                  )),
                              const SizedBox(
                                width: TSizes.paddingSpaceLg,
                              ),

                              ///9Mobile
                              FilledButton(
                                  style: Theme.of(context).filledButtonTheme.style!.copyWith(
                                      fixedSize: MaterialStatePropertyAll(
                                          Size(SizeConfig.screenWidth * 0.22, SizeConfig.screenWidth * 0.22)),
                                      padding: const MaterialStatePropertyAll(EdgeInsets.all(0))),
                                  onPressed: () {
                                    setState(() {
                                      serviceProvider = ServiceProvider.nMobile;
                                    });
                                  },
                                  child: Container(
                                    decoration:
                                    BoxDecoration(image: DecorationImage(image: AssetImage(
                                        serviceProvider == ServiceProvider.nMobile
                                            ? TImages.nmobileActive
                                            : TImages.nmobileDisable))),
                                  )),
                            ],
                          ),
                        ),

                        const Spacer(),

                        FilledButton(
                            onPressed: () async{
                          //
                          // deactivate button
                          setState(() {
                            isLoading = true;
                          });

                          bool resp = await AirtimeNdData().buyAirtime(
                              Provider.of<UserDetailsProvider>(context, listen: false).account.uid,
                              phoneNumberController.text,
                              double.parse(amountController.text),
                            serviceProvider == ServiceProvider.airtel ? "airtel"
                                : serviceProvider == ServiceProvider.glo ? "glo"
                                : serviceProvider == ServiceProvider.mtn ? "mtn"
                                : "nMobile"
                          );
                          if(resp){
                            // ignore: use_build_context_synchronously
                            MFeedback(context: context).success('Airtime purchase successful');
                          }else{
                            // ignore: use_build_context_synchronously
                            MFeedback(context: context).error('Airtime purchase failed');
                          }

                          //
                          // activate button
                          setState(() {
                            isLoading = false;
                          });
                        }, child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                          Text("Buy Airtime")
                        ],))
                      ],
                    ),
                  ),
                ),

              ],
            ),


              /// Loading Overlay
              Visibility(
                  visible: isLoading,
                  child: const MLoadOverlay(description: "Purchasing Airtime"))
            ]
          ),
        ),
      ),
    );
  }
}
