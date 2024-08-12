import 'package:flash_chat/constants.dart';
import 'package:flutter/material.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Contacts Screen',
          style: kBodyStyle1(color: Theme.of(context).primaryColorDark)),
    );
  }
}
