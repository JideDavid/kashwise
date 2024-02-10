import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:http/http.dart' as http;
import 'package:kashwise/View_Models/user_details_provider.dart';
import 'package:kashwise/utils/constants/api_constants.dart';
import 'package:provider/provider.dart';
import '../../utils/constants/sizes.dart';

class FundWithPaystackPage extends StatefulWidget {
  const FundWithPaystackPage({super.key});

  @override
  // ignore: no_logic_in_create_state
  State<FundWithPaystackPage> createState() => _FundWithPaystackPageState();
}

class _FundWithPaystackPageState extends State<FundWithPaystackPage> {
  TextStyle heading = const TextStyle(
    fontWeight: FontWeight.bold,
  );
  TextStyle subHeading = const TextStyle(
    fontWeight: FontWeight.normal,
    fontSize: 12,
  );

  bool tapDown = false;
  String publicKey = ApiString.paystackPublicKey;
  String accessCode = "";
  final payStack = PaystackPlugin();
  double amount = 0;
  double initialBalance = 0;
  double newBalance = 0;
  bool hasInputAmount = false;
  String transactionRef = '';
  String paymentMethod = 'card';

  TextEditingController amountController = TextEditingController();

  Future<void> payWithPayStack() async {
    //formatting and setting transaction reference
    String ref = "ref_${DateTime.now()}";
    ref = ref.replaceAll(' ', '');
    ref = ref.replaceAll('-', '');
    ref = ref.replaceAll(':', '');
    ref = ref.replaceAll('.', '');
    transactionRef = ref;

    //getting user's initial balance
    DocumentSnapshot initBalance = (await FirebaseFirestore.instance
        .collection('users')
        .doc(Provider.of<UserDetailsProvider>(context, listen: false)
            .account
            .uid)
        .get());
    initialBalance = initBalance.get('walletBalance');

    // initialize transaction to get access code for bank and selectable methods
    Uri url = Uri.parse("https://api.paystack.co/transaction/initialize");
    var response = await http.post(url, headers: {
      'authorization':
          "Bearer ${ApiString.paystackSecretKey}",
    }, body: {
      //ignore: use_build_context_synchronously
      "email": Provider.of<UserDetailsProvider>(context, listen: false)
          .account
          .email,
      "amount": (amount * 100).toString()
    });
    Map data = jsonDecode(response.body);
    accessCode = data['data']['access_code'];
    ref = data['data']['reference'];

    //charging user
    Charge charge = Charge()
      ..amount = (amount * 100).toInt()
      //ignore: use_build_context_synchronously
      ..email =
      //ignore: use_build_context_synchronously
          Provider.of<UserDetailsProvider>(context, listen: false).account.email
      ..reference = transactionRef
      ..accessCode = accessCode
      ..currency = "NGN";

    CheckoutResponse chkResponse =
        // ignore: use_build_context_synchronously
        await payStack.checkout(context,
            charge: charge, method: CheckoutMethod.selectable);

    if (chkResponse.status) {
      //wallet balance from database
      DocumentSnapshot userData =
          //ignore: use_build_context_synchronously
          await FirebaseFirestore.instance
              .collection('users')
          //ignore: use_build_context_synchronously
              .doc(Provider.of<UserDetailsProvider>(context, listen: false)
                  .account
                  .uid)
              .get();
      double walletBalance = userData.get('walletBalance') + amount;
      newBalance = walletBalance;

      await FirebaseFirestore.instance
          .collection('users')
          //ignore: use_build_context_synchronously
          .doc(Provider.of<UserDetailsProvider>(context, listen: false)
              .account
              .uid)
          .update({'walletBalance': walletBalance});

      //recording transaction in history
      await FirebaseFirestore.instance
          .collection('users')
          //ignore: use_build_context_synchronously
          .doc(Provider.of<UserDetailsProvider>(context, listen: false)
              .account
              .uid)
          .collection('transactions')
          .doc(transactionRef)
          .set({
        'type': 'wallet funding',
        'isCredit': true,
        'amount': amount,
        'method': 'card',
        'date': DateTime.now(),
        'transactionRef': transactionRef,
        'initialBalance': initialBalance,
        'newBalance': newBalance
      });

      // ignore: use_build_context_synchronously
      //Navigator.of(context).pop();
    }
  }

  @override
  void initState() {
    super.initState();
    payStack.initialize(publicKey: publicKey);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ///
              /// Appbar
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
                        'Fund Wallet',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ]),

                    /// Actions
                    SizedBox(
                      height: 20,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
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
              /// Body
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: TSizes.paddingSpaceLg,
                      vertical: TSizes.paddingSpaceLg
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      /// Amount text field
                      TextField(
                        controller: amountController,
                        onChanged: (value) {
                          amount = double.tryParse(amountController.text)!;
                          if (amount < 1) {
                            setState(() {
                              hasInputAmount = false;
                            });
                          } else {
                            setState(() {
                              hasInputAmount = true;
                            });
                          }
                        },
                        maxLength: 9,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(
                          counterText: "",
                          hintText: 'Enter Amount',
                        ),
                      ),

                      /// Fund wallet button
                      FilledButton(
                          onPressed: !hasInputAmount ? null : payWithPayStack,
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 5),
                                child: Text("Fund Wallet"),
                              ),
                            ],
                          ))
                    ],
                  ),
                ),
              )

            ]),
      ),
    );
  }
}
