import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kashwise/Models/user_model.dart';
import 'package:kashwise/Services/my_printer.dart';
import 'package:kashwise/utils/constants/size_config.dart';
import 'package:kashwise/utils/custom_widgets/m_display_picture.dart';
import 'package:provider/provider.dart';
import '../../Services/firebase_services.dart';
import '../../Services/number_formatter.dart';
import '../../View_Models/user_details_provider.dart';
import '../../utils/constants/colors.dart';
import '../../utils/constants/sizes.dart';

class TransferPage extends StatefulWidget {
  const TransferPage({super.key});

  @override
  State<TransferPage> createState() => _TransferPageState();
}

class _TransferPageState extends State<TransferPage> {
  TextEditingController searchKeywordController = TextEditingController();
  List<UserDetails> queryUsers = [];
  bool searchWithUsername = true;
  UserDetails? selectedUser;
  double amount = 0;

  TextEditingController amountController = TextEditingController();

  Future <QuerySnapshot?> getUsersWithUsername(String keyword) async{
    QuerySnapshot users = await FirebaseFirestore.instance.collection("users").get();
    if(users.docs.isNotEmpty){
      queryUsers = [];
      for(var doc in users.docs){
        UserDetails user = UserDetails.fromJson(doc);
        if(user.username.toLowerCase().startsWith(keyword.toLowerCase())){
          queryUsers.add(user);
          MPrint(value: user.username);
        }
      }
      MPrint(value: "All users added");
      setState(() {});
      return users;
    }else{
      MPrint(value: "No user exist");
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          children: [

            ///
            ///Appbar
            Column(children: [

              ///Title and action Button
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: TSizes.paddingSpaceLg,
                    horizontal: TSizes.paddingSpaceLg),
                child: Stack(
                    alignment: AlignmentDirectional.center,
                    children: [

                      /// Title
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Transfer',
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
                                onTap: (){
                                  Navigator.pop(context);
                                },
                                child: const Icon(
                                  Icons.arrow_back_ios_outlined
                                ),
                              )
                            ]),
                      ),

                    ]
                ),
              ),
              Divider(
                color: Colors.grey.withOpacity(0.4),
                thickness: 0.8,
                height: 0,
              )
            ]),

            ///
            /// Body Content

            ///
            /// Search user interface
            selectedUser == null ? Expanded(
              child: Column(
                children: [
                  ///
                  /// Username input field
                  Padding(
                    padding: const EdgeInsets.all(TSizes.paddingSpaceLg),
                    child: TextField(
                      onChanged: (value){
                        if(value.isNotEmpty){
                          getUsersWithUsername(value);
                        }else{
                          setState(() {
                            queryUsers = [];
                          });
                        }
                      },
                    ),
                  ),
              
                  ///
                  /// Tab button
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: TSizes.paddingSpaceLg),
                    child: Row(
                      children: [
                        /// username tab
                        GestureDetector(
                          onTap: (){
                            setState(() {
                              searchWithUsername = true;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: searchWithUsername ? TColors.accent : TColors.darkerGrey.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(20)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: TSizes.paddingSpaceSm, horizontal: TSizes.paddingSpaceLg),
                              child: Text("username", style: Theme.of(context).textTheme.bodySmall!.copyWith(color: searchWithUsername? Colors.black : Colors.grey),),
                            ),
                          ),
                        ),
              
                        const SizedBox(width: TSizes.paddingSpaceLg),
              
                        /// username tab
                        GestureDetector(
                          onTap: (){
                            setState(() {
                              searchWithUsername = false;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: !searchWithUsername ? TColors.accent : TColors.darkerGrey.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(20)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: TSizes.paddingSpaceSm, horizontal: TSizes.paddingSpaceLg),
                              child: Text("wallet ID", style: Theme.of(context).textTheme.bodySmall!.copyWith(color: !searchWithUsername? Colors.black : Colors.grey),),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
              
                  const SizedBox(
                    height: TSizes.paddingSpaceLg,
                  ),
              
                  ///
                  /// Users List Section
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: TSizes.paddingSpaceLg),
                      child: Container(
                        width: SizeConfig.screenWidth,
                        height: SizeConfig.screenHeight,
                        color: Colors.amber.withOpacity(0.01),
                        child: queryUsers.isNotEmpty ? ListView.builder(itemCount: queryUsers.length, itemBuilder: (context, index){
              
                          ///
                          /// User card
                          return Padding(
                            padding: const EdgeInsets.only(bottom: TSizes.paddingSpaceLg),
                            child: Container(
                              height: 60,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.grey.withOpacity(0.2)
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: TSizes.paddingSpaceLg),
                                child: GestureDetector(
                                  onTap: (){
                                    selectedUser = queryUsers[index];
                                    setState(() {});
                                  },
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      MDisplayPic(url: queryUsers[index].image),
                                      const SizedBox(width: TSizes.paddingSpaceLg,),
                                      Text(queryUsers[index].username),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        })
                            : Container(
                          height: 40, width: 40, color: Colors.red.withOpacity(0),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
            
            ///
            /// Enter amount and send fund interface
                : Expanded(
                  child: Padding(
                                padding: const EdgeInsets.symmetric(
                    horizontal: TSizes.paddingSpaceLg),
                                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: SizeConfig.screenWidth,
                      height: SizeConfig.screenHeight * 0.6,
                      decoration: BoxDecoration(
                          color: amount == 0
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
                                  NumberFormatter().formatAmount(amount),
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineLarge
                                      ?.copyWith(
                                      color: amount == 0
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
                                Text(selectedUser!.username.toString(),
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
                                Text(selectedUser!.walletTag.toString())
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  
                    ///
                    /// Add Amount
                    Visibility(
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
                                              MPrint(
                                                  value:
                                                  'Input amount is not valid');
                                            } else {
                                              /// If valid, generate new QR including amount
                                              amount = inputAmount;
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
                      visible: amount == 0 ? false : true,
                      child: FilledButton(
                          onPressed: () async{
                            bool resp = await FirebaseHelper().transferToAppUser(Provider.of<UserDetailsProvider>(context, listen: false).account.uid , selectedUser!.uid, amount);
                            if(resp){
                              MPrint(value: "Transfer successful");
                            }else{
                              MPrint(value: "Transfer failed");
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
                          selectedUser = null;
                          amount = 0;
                          setState(() {});
                        },
                        icon: CircleAvatar(
                            backgroundColor: Colors.grey.withOpacity(0.4),
                            child: const Icon(
                                Icons.navigate_before_outlined)))
                  ],
                                ),
                              ),
                )

          ],
        ),
      ),
    );
  }
}
