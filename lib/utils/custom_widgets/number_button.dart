import 'package:flutter/material.dart';

import '../constants/size_config.dart';

class NumberButton extends StatelessWidget {
  const NumberButton({super.key, required this.text, required this.function, required this.color, required this.style,});

   final String text;
   final Function function;
   final Color color;
   final TextStyle style;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: (){
          function();
        },
        style: ButtonStyle(
          enableFeedback: true,
          overlayColor: MaterialStatePropertyAll(Theme.of(context).primaryColor.withOpacity(0.3))
        ),
        child: SizedBox(
            height: SizeConfig.screenWidth * 0.1,
            width: SizeConfig.screenWidth * 0.1,
            child: FittedBox(child: Center(
                child: Text(text, style: style.copyWith(color: color),)))));
  }
}
