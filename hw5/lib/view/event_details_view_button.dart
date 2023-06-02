import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class EventDetailsViewButton extends StatelessWidget {
  final int index;
  const EventDetailsViewButton({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        onPressed: () {
          context.push('/event/$index');
        },
        child: const Text('Details'));
  }
}
