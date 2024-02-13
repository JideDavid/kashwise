import 'package:flutter/material.dart';
import 'package:kashwise/utils/constants/size_config.dart';

import '../constants/colors.dart';

class MFeedback{
  BuildContext context;
  MFeedback({required this.context});

  error(String errorMSG){
    showDialog(context: context, builder: (context) => AlertDialog(
      title: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.info_outline, color:  TColors.error,)
        ],
      ),
      content: Text(errorMSG, style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.black),
      textAlign: TextAlign.center,
        softWrap: true,
      ),
      backgroundColor: TColors.white,
    ));
  }

  success(String successMSG){
    showDialog(context: context, builder: (context) => AlertDialog(
      content: SizedBox(
        // height: SizeConfig.screenHeight * 0.3,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.check_circle, color: TColors.success,size: 50,),
            Text(successMSG, style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.black),
              textAlign: TextAlign.center,
              softWrap: true,
            ),
          ],
        ),
      ),
      backgroundColor: TColors.white,
    ));
  }
}