import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:http/http.dart' as http;
import 'package:kashwise/View_Models/user_details_provider.dart';
import 'package:provider/provider.dart';

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
  String publicKey = "pk_test_2a0fe206d6e14d455a6f0c3fcda0418d4cf31856";
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
        .doc(Provider.of<UserDetailsProvider>(context, listen: false).account.uid)
        .get());
    initialBalance = initBalance.get('walletBalance');

    // initialize transaction to get access code for bank and selectable methods
    Uri url = Uri.parse("https://api.paystack.co/transaction/initialize");
    var response = await http.post(url,
        headers: {'authorization' : "Bearer sk_test_5791c0a884a543c323401522129d798767291374",},
        body: {
          //ignore: use_build_context_synchronously
          "email": Provider.of<UserDetailsProvider>(context, listen: false).account.email,
          "amount": (amount * 100).toString()
        }
    );
    Map data = jsonDecode(response.body);
    accessCode = data['data']['access_code'];
    ref = data['data']['reference'];


    //charging user
    Charge charge = Charge()
      ..amount = (amount * 100).toInt()
    //ignore: use_build_context_synchronously
      ..email = Provider.of<UserDetailsProvider>(context, listen: false).account.email
      ..reference = transactionRef
      ..accessCode = accessCode
      ..currency = "NGN";

    CheckoutResponse chkResponse =
    // ignore: use_build_context_synchronously
    await payStack.checkout(
        context, charge: charge,
        method: CheckoutMethod.selectable);

    if (chkResponse.status) {

      //wallet balance from database
      DocumentSnapshot userData =
      //ignore: use_build_context_synchronously
      await FirebaseFirestore.instance.collection('users').doc(Provider.of<UserDetailsProvider>(context, listen: false).account.uid).get();
      double walletBalance = userData.get('walletBalance') + amount;
      newBalance = walletBalance;

      await FirebaseFirestore.instance
          .collection('users')
      //ignore: use_build_context_synchronously
          .doc(Provider.of<UserDetailsProvider>(context, listen: false).account.uid)
          .update({'walletBalance': walletBalance});

      //recording transaction in history
      await FirebaseFirestore.instance
          .collection('users')
      //ignore: use_build_context_synchronously
          .doc(Provider.of<UserDetailsProvider>(context, listen: false).account.uid)
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
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Fund Wallet",
              style: heading,
            ),
            Text(
              "Input requested details to fund your wallet",
              style: subHeading,
            )
          ],
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.history,
              ))
        ],
        toolbarHeight: 80,
        elevation: 0,
        backgroundColor: Colors.black.withOpacity(0),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
          FilledButton(onPressed: !hasInputAmount ? null : payWithPayStack,
              child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 5),
                child: Text("Fund Wallet"),
              ),
            ],
          ))

        ]),
      ),
    );
  }
}
