import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:kashwise/Models/pay_request_model.dart';
import 'package:kashwise/Services/firebase_services.dart';
import 'package:kashwise/Services/my_printer.dart';
import 'package:kashwise/Services/number_formatter.dart';
import 'package:kashwise/Services/qr_scanner.dart';
import 'package:kashwise/View_Models/user_details_provider.dart';
import 'package:kashwise/utils/constants/text_strings.dart';
import 'package:kashwise/utils/custom_widgets/m_error_dialog.dart';
import 'package:provider/provider.dart';
import '../../utils/constants/colors.dart';
import '../../utils/constants/size_config.dart';
import '../../utils/constants/sizes.dart';
import '../../utils/custom_widgets/loading_screen_overlay.dart';

class ScanQRPage extends StatefulWidget {
  const ScanQRPage({super.key});

  @override
  State<ScanQRPage> createState() => _ScanQRPageState();
}

class _ScanQRPageState extends State<ScanQRPage> {
  String scanValue = '';
  bool qrIsValid = false;
  QRPayRequest? qrPayRequest;
  TextEditingController amountController = TextEditingController();
  bool loadingOverlay = false;

  scanQrCode() async {
    String? scannedCode = await QRScanner().scanQR();
    Map<String, dynamic> formattedResp;

    ///
    /// handle null response
    if (scannedCode == null) {
      scanValue = '!..scan error..!';
      setState(() {});

      ///
      /// handle QR cancelled
    } else if (scannedCode == '-1') {
      scanValue = '!..scan cancelled..!';
      setState(() {});
    }

    ///
    ///handle valid QR format
    else {
      try {
        formattedResp = jsonDecode(scannedCode);
        qrPayRequest = QRPayRequest.fromJson(formattedResp);
        scanValue = scannedCode;
        qrIsValid = qrPayRequest!.isValid;
      } catch (e) {
        MPrint(e.toString());
        scanValue = '!..scan a ${TTexts.appName} user QR code!';
      }
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    scanQrCode();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: !loadingOverlay,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Stack(
            children:[

              ///
              /// main page contents
              Column(
              children: [
                ///
                ///Appbar
                Column(children: [
                  ///Title and action Button
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: TSizes.paddingSpaceLg,
                        horizontal: TSizes.paddingSpaceLg),
                    child: Stack(alignment: AlignmentDirectional.center, children: [
                      /// Title
                      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                        Text(
                          'QR Send',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      ]),

                      /// Actions
                      SizedBox(
                        height: 20,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Icon(Icons.navigate_before),
                              ),
                              GestureDetector(
                                onTap: () {},
                                child: const Icon(Icons.info_outline),
                              )
                            ]),
                      ),
                    ]),
                  ),
                  Divider(
                    color: Colors.grey.withOpacity(0.4),
                    thickness: 0.8,
                    height: TSizes.paddingSpaceLg,
                  )
                ]),


                ///
                /// Content section
                Expanded(
                child: qrIsValid

                    ///
                    /// Pay request details
                    ? Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: TSizes.paddingSpaceLg),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              width: SizeConfig.screenWidth,
                              height: SizeConfig.screenHeight * 0.6,
                              decoration: BoxDecoration(
                                  color: qrPayRequest?.amount == 0
                                      ? TColors.accent.withOpacity(0.2)
                                      : TColors.pastelVar1.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(20)),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: TSizes.paddingSpaceLg * 2),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    /// Amount
                                    Column(
                                      children: [
                                        const Text('Send'),
                                        Text(
                                          NumberFormatter().formatAmount(qrPayRequest!.amount),
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineLarge
                                              ?.copyWith(
                                                  color: qrPayRequest?.amount == 0
                                                      ? TColors.accent
                                                      : TColors.pastelVar1),
                                        )
                                      ],
                                    ),

                                    ///Username
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text('To'),
                                        Text(qrPayRequest!.username.toString(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .headlineLarge)
                                      ],
                                    ),

                                    /// Wallet Id
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text('Wallet ID:'),
                                        Text(qrPayRequest!.walletTag.toString())
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            ///
                            /// Add Amount
                            Visibility(
                              visible: !qrPayRequest!.hasAmount,
                              child: FilledButton(
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title: const Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text('Enter Amount'),
                                              ],
                                            ),
                                            content: TextField(
                                              textAlign: TextAlign.center,
                                              keyboardType: TextInputType.number,
                                              controller: amountController,
                                            ),
                                            actions: [
                                              FilledButton(
                                                  onPressed: () {
                                                    /// Validate amount entry
                                                    double? inputAmount =
                                                        double.tryParse(
                                                            amountController
                                                                .text);
                                                    if (inputAmount == null) {
                                                      MPrint('Input amount is not valid');
                                                    } else {
                                                      /// If valid, generate new QR including amount
                                                      qrPayRequest = QRPayRequest(
                                                          isValid: qrPayRequest!
                                                              .isValid,
                                                          hasAmount: qrPayRequest!
                                                              .hasAmount,
                                                          walletTag: qrPayRequest!
                                                              .walletTag,
                                                          username: qrPayRequest!
                                                              .username,
                                                          uid: qrPayRequest!.uid,
                                                          amount: inputAmount);
                                                      setState(() {});
                                                    }

                                                    Navigator.of(context).pop();
                                                  },
                                                  style: Theme.of(context)
                                                      .filledButtonTheme
                                                      .style
                                                      ?.copyWith(
                                                          backgroundColor:
                                                              const MaterialStatePropertyAll(
                                                                  TColors
                                                                      .primary)),
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: TSizes
                                                            .paddingSpaceLg),
                                                    child: Text(
                                                      'Confirm',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyLarge
                                                          ?.copyWith(
                                                              color:
                                                                  TColors.white),
                                                    ),
                                                  )),
                                            ],
                                            actionsAlignment:
                                                MainAxisAlignment.center,
                                          );
                                        });
                                  },
                                  style: Theme.of(context)
                                      .filledButtonTheme
                                      .style
                                      ?.copyWith(
                                        backgroundColor:
                                            const MaterialStatePropertyAll(
                                                TColors.accent),
                                      ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: TSizes.paddingSpaceLg),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Enter amount',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge
                                              ?.copyWith(color: TColors.white),
                                        ),
                                      ],
                                    ),
                                  )),
                            ),

                            ///
                            /// Send fund
                            Visibility(
                              visible: qrPayRequest!.amount == 0 ? false : true,
                              child: FilledButton(
                                  onPressed: () async{
                                    setState(() {
                                      loadingOverlay = true;
                                    });
                                    bool resp = await FirebaseHelper().transferToAppUser(context, Provider.of<UserDetailsProvider>(context, listen: false).account.uid , qrPayRequest!.uid, qrPayRequest!.amount);
                                    if(resp){
                                      MPrint("Transfer successful");
                                      if(mounted){
                                        setState(() {
                                          loadingOverlay = false;
                                          MFeedback(context: context).success("Transfer successful");
                                        });
                                      }
                                    }else{
                                      MPrint("Transfer failed");
                                      setState(() {
                                        loadingOverlay = false;
                                      });
                                    }
                                  },
                                  style: Theme.of(context)
                                      .filledButtonTheme
                                      .style
                                      ?.copyWith(
                                        backgroundColor:
                                            const MaterialStatePropertyAll(
                                                TColors.primary),
                                      ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: TSizes.paddingSpaceLg),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Send',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge
                                              ?.copyWith(color: TColors.white),
                                        ),
                                      ],
                                    ),
                                  )),
                            ),

                            // Reset button
                            IconButton(
                                onPressed: () {
                                  qrIsValid = false;
                                  scanValue = '';
                                  setState(() {});
                                },
                                icon: CircleAvatar(
                                    backgroundColor: Colors.grey.withOpacity(0.4),
                                    child: const Icon(
                                        Icons.navigate_before_outlined)))
                          ],
                        ),
                      )

                    ///
                    /// Scan QR interface
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ///
                          ///
                          Column(
                            children: [
                              const Icon(
                                Icons.error_outline_outlined,
                                color: TColors.accent,
                              ),

                              ///
                              /// Scan value
                              Center(
                                child: Text(scanValue),
                              ),
                            ],
                          ),

                          const SizedBox(height: TSizes.paddingSpaceLg,),

                          ///
                          /// Scan start button
                          SizedBox(
                            height: SizeConfig.screenWidth * 0.25,
                            width: SizeConfig.screenWidth * 0.25,
                            child: FilledButton(
                              onPressed: () async {
                                await scanQrCode();
                              },
                              style: Theme.of(context)
                                  .filledButtonTheme
                                  .style!
                                  .copyWith( backgroundColor: MaterialStatePropertyAll(TColors.primary.withOpacity(0.2))),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.qr_code_2_outlined,
                                    size: SizeConfig.screenWidth * 0.1,
                                  ),
                                  const Text('Scan Code')
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                              ),

              ],
            ),

              ///
              ///  Loading Overlay
              Visibility(
                  visible: loadingOverlay,
                  child: const MLoadOverlay(description: "Processing...",)),
            ]
          ),
        ),
      ),
    );
  }
}
