import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../View_Models/user_details_provider.dart';
import '../constants/colors.dart';
import '../constants/size_config.dart';
import '../constants/sizes.dart';

class TransactionCard extends StatelessWidget {
  final int index;
  const TransactionCard({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return context.watch<UserDetailsProvider>().allTransactionList[index].method == 'walletTransfers'
        ? Column(
            children: [
              SizedBox(
                  height: SizeConfig.screenHeight * 0.05,
                  width: double.maxFinite,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: TSizes.paddingSpaceLg),
                    child: Row(
                      children: [
                        // transaction type icon
                        ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Container(
                            color: context.read<UserDetailsProvider>().allTransactionList[index].isCredit
                              ? TColors.primary.withOpacity(0.2) : TColors.accent.withOpacity(0.2),
                            width: SizeConfig.screenWidth * 0.1,
                            height: SizeConfig.screenWidth * 0.1,
                            child: Icon(
                                context.read<UserDetailsProvider>().allTransactionList[index].isCredit
                                ? Icons.receipt_long_sharp : Icons.send_and_archive_rounded),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // sender or receiver
                            context.watch<UserDetailsProvider>().allTransactionList[index].isCredit
                            ? Text('Credit from ${context.watch<UserDetailsProvider>().allTransactionList[index].senderUsername}',
                            style: Theme.of(context).textTheme.bodyMedium, softWrap: true, overflow: TextOverflow.ellipsis,)
                                : Text('Transfer to ${context.watch<UserDetailsProvider>().allTransactionList[index].receiverUsername}',
                              style: Theme.of(context).textTheme.bodyMedium, softWrap: true, overflow: TextOverflow.ellipsis),

                            // date
                            SizedBox(
                              width: SizeConfig.screenWidth * 0.5,
                              child: Text(
                                 timeago.format(
                                     DateTime.fromMicrosecondsSinceEpoch(
                                         context.watch<UserDetailsProvider>().allTransactionList[index].date.microsecondsSinceEpoch)).toString(),
                                style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 10),
                                softWrap: true,
                                overflow: TextOverflow.ellipsis,
                              ),
                            )
                          ],
                        ),
                        const Spacer(),
                        Text(
                          context.watch<UserDetailsProvider>().allTransactionList[index].amount.toString(),
                          style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                              color: context.watch<UserDetailsProvider>().allTransactionList[index].isCredit
                                  ? TColors.pastelVar1
                                  : TColors.pastelVar3),
                        ),
                      ],
                    ),
                  )),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: TSizes.paddingSpaceLg),
                child: Divider(
                  color: TColors.grey.withOpacity(0.2),
                ),
              )
            ],
          )
        : Column(
            children: [
              SizedBox(
                  height: SizeConfig.screenHeight * 0.05,
                  width: double.maxFinite,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: TSizes.paddingSpaceLg),
                    child: Row(
                      children: [
                        // transaction type icon
                        ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Container(
                            color: TColors.primary,
                            width: SizeConfig.screenWidth * 0.1,
                            height: SizeConfig.screenWidth * 0.1,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          context.watch<UserDetailsProvider>().transferList[index].amount.toString(),
                          style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                              color: context.watch<UserDetailsProvider>().transferList[index].isCredit
                                  ? TColors.pastelVar1
                                  : TColors.pastelVar3),
                        ),
                      ],
                    ),
                  )),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: TSizes.paddingSpaceLg),
                child: Divider(
                  color: TColors.grey.withOpacity(0.2),
                ),
              )
            ],
          );
  }
}
