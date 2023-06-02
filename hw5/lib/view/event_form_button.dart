import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class EventFormButton extends StatelessWidget {
  final bool usingFirestore;
  const EventFormButton({Key? key, required this.usingFirestore}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return FloatingActionButton(
        onPressed: () {
          context.push('/form');
        },
        child: const Icon(Icons.add));
  }
}
