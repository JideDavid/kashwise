import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:kashwise/Models/pay_request_model.dart';
import 'package:kashwise/Services/my_printer.dart';
import 'package:kashwise/Services/number_formatter.dart';
import 'package:kashwise/View_Models/user_details_provider.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../utils/constants/colors.dart';
import '../../utils/constants/size_config.dart';
import '../../utils/constants/sizes.dart';

class GenerateQRCodePage extends StatefulWidget {
  const GenerateQRCodePage({super.key});

  @override
  State<GenerateQRCodePage> createState() => _GenerateQRCodePageState();
}

class _GenerateQRCodePageState extends State<GenerateQRCodePage> {
  String qRValue = '';
  bool hasAmount = false;
  double amount = 0;
  TextEditingController amountController = TextEditingController();

  generateOpenQRCode() {
    String payReq = jsonEncode(QRPayRequest(
        isValid: true,
        hasAmount: false,
        walletTag: Provider.of<UserDetailsProvider>(context, listen: false)
            .account
            .walletTag,
        username: Provider.of<UserDetailsProvider>(context, listen: false)
            .account
            .username,
        uid: Provider.of<UserDetailsProvider>(context, listen: false)
            .account
            .uid,
        amount: 0));
    amount =0;
    qRValue = payReq;
    Map<String, dynamic> resp = jsonDecode(payReq);
    MPrint(value: resp['walletTag'].toString());
    setState(() {});
  }

  generateOpenQRCodeWithAmount( double reqAmount) {
    String payReq = jsonEncode(QRPayRequest(
        isValid: true,
        hasAmount: true,
        walletTag: Provider.of<UserDetailsProvider>(context, listen: false)
            .account
            .walletTag,
        username: Provider.of<UserDetailsProvider>(context, listen: false)
            .account
            .username,
        uid: Provider.of<UserDetailsProvider>(context, listen: false)
            .account
            .uid,
        amount: reqAmount));
    amount = reqAmount;
    qRValue = payReq;
    Map<String, dynamic> resp = jsonDecode(payReq);
    MPrint(value: resp['walletTag'].toString());
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    generateOpenQRCode();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
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
                      'Request with QR code',
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
                height: 0,
              )
            ]),

            ///
            /// Content section
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: TSizes.paddingSpaceLg,
                    vertical: TSizes.paddingSpaceLg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ///
                    /// Generated QR view and details
                    Container(
                      height: SizeConfig.screenHeight * 0.6,
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                          color: amount == 0 ?  TColors.accent.withOpacity(0.2) : TColors.pastelVar1.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          /// QR view
                          Container(
                            height: SizeConfig.screenWidth * 0.5,
                            width: SizeConfig.screenWidth * 0.5,
                            decoration: BoxDecoration(
                                color: amount == 0
                                    ? TColors.accent.withOpacity(0.5)
                                    : TColors.pastelVar1.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                        color: amount == 0 ? TColors.accent : TColors.pastelVar1, width: 2)),
                            child: Visibility(
                              visible: qRValue.isNotEmpty,
                              child: Padding(
                                padding:
                                    const EdgeInsets.all(TSizes.paddingSpaceSm),
                                child: QrImageView(
                                  data: qRValue,
                                  eyeStyle: const QrEyeStyle(
                                      eyeShape: QrEyeShape.circle,
                                      color: Colors.black),
                                ),
                              ),
                            ),
                          ),

                          ///Request details
                          Column(
                            children: [
                              /// Request type
                              Container(
                                color: Colors.grey.withOpacity(0.2),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: TSizes.paddingSpaceLg,
                                      vertical: TSizes.paddingSpaceLg),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text('Request type:'),
                                      Text(amount == 0 ? 'open' : 'fixed'),
                                    ],
                                  ),
                                ),
                              ),
                              /// Wallet ID
                              Container(
                                color: Colors.grey.withOpacity(0.1),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: TSizes.paddingSpaceLg,
                                      vertical: TSizes.paddingSpaceLg),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text('Wallet ID:'),
                                      Text(Provider.of<UserDetailsProvider>(
                                              context)
                                          .account
                                          .walletTag),
                                    ],
                                  ),
                                ),
                              ),
                              /// Request amount
                              Container(
                                color: Colors.grey.withOpacity(0.2),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: TSizes.paddingSpaceLg,
                                      vertical: TSizes.paddingSpaceLg),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text('Request amount:'),
                                      Text(amount == 0 ? '--' : NumberFormatter().formatAmount(amount)),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),

                    // const SizedBox(height: TSizes.paddingSpaceLg,),

                    amount == 0

                    ///
                    /// Add amount button
                    ? FilledButton(
                        onPressed: () {
                          ///
                          /// Input amount alert dialog
                          showDialog(context: context, builder: (context){
                            return AlertDialog(
                              title: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
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
                                      ///Todo:
                                      /// Validate amount entry
                                      double? inputAmount = double.tryParse(amountController.text);
                                      if(inputAmount == null){
                                        MPrint(value: 'Input amount is not valid');
                                      }else{
                                        /// If valid, generate new QR including amount
                                        generateOpenQRCodeWithAmount(inputAmount);
                                        amountController.text = '';
                                        setState(() {});
                                      }

                                      Navigator.of(context).pop();
                                    },
                                    style: Theme.of(context).filledButtonTheme.style?.copyWith(
                                        backgroundColor: const MaterialStatePropertyAll(TColors.primary)
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: TSizes.paddingSpaceLg),
                                      child: Text(
                                        'Request',
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
                        style: Theme.of(context).filledButtonTheme.style?.copyWith(
                            backgroundColor: const MaterialStatePropertyAll(TColors.primary)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: TSizes.paddingSpaceLg),
                          child: Text(
                            'Add Amount',
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(color: TColors.white),
                          ),
                        ))

                    ///
                    /// Clear amount button
                    : FilledButton(
                        onPressed: () {
                          amount = 0;
                          generateOpenQRCode();
                          setState(() {});
                        },
                        style: Theme.of(context).filledButtonTheme.style?.copyWith(
                            backgroundColor: const MaterialStatePropertyAll(TColors.accent)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: TSizes.paddingSpaceLg),
                          child: Text(
                            'Clear Amount',
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(color: TColors.black),
                          ),
                        )),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
