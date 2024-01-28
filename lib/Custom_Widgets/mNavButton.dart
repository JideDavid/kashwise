import 'package:flutter/material.dart';
import '../utils/constants/colors.dart';
import '../utils/constants/sizes.dart';

class MNavButton extends StatelessWidget {
  MNavButton({super.key, required this.function, required this.iconColor,
    required this.icon,required this.title, required this.subTitle, });

  late final Function function;
  late final Icon icon;
  late final Color iconColor;
  late final String title;
  late final String subTitle;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
        style: Theme.of(context)
            .filledButtonTheme
            .style
            ?.copyWith(
            backgroundColor: MaterialStatePropertyAll(
                Colors.grey.withOpacity(0))),
        onPressed: (){
          function();
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: TSizes.paddingSpaceLg),
          child: Row(
            children: [
              Container(
                height: 32, width: 22,
                decoration: BoxDecoration(
                    color: iconColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(4)
                ),
                child: icon,
              ),
              const SizedBox(
                width: TSizes.paddingSpaceLg,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style:
                    Theme.of(context).textTheme.headlineSmall,
                  ),
                  Text(
                    subTitle,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(
                        fontWeight: FontWeight.normal,
                        fontSize: 10),
                  )
                ],
              ),
              const Spacer(),
              const Icon(
                Icons.navigate_next,
                color: TColors.accent,
              )
            ],
          ),
        ));
  }
}
