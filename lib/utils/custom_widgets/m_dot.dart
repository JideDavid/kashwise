import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../View_Models/login_password_provider.dart';

class MDot extends StatelessWidget {
  const MDot({super.key, required this.activeIndex});
  final int activeIndex;

  @override
  Widget build(BuildContext context) {

    return CircleAvatar(
      radius: 8,
      backgroundColor: context.watch<LoginPasswordProvider>().entries.length >= activeIndex
          ? Theme.of(context).primaryColor : Colors.grey,
    );
  }
}
