import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class EventFormButton extends StatelessWidget {
  const EventFormButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        onPressed: () {
          context.push('/form');
        },
        child: const Icon(Icons.add));
  }
}
