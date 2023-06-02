import 'package:event_planner/view/event_form_button.dart';
import 'package:event_planner/view/event_viewer.dart';
import 'package:event_planner/view/event_viewer_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../view_model/event_view_model.dart';


class EventViewerPage extends StatefulWidget {
  const EventViewerPage({Key? key}) : super(key: key);

  @override
  State<EventViewerPage> createState() => _EventViewerPageState();
}

class _EventViewerPageState extends State<EventViewerPage> {
  _onUsingFireStoreToggle(){
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    bool usingFireStore = context.read<EventViewModel>().usingFireStore;
    print('fs:$usingFireStore');
    return Scaffold(
        appBar: EventViewerAppBar(notifyParent: _onUsingFireStoreToggle,),
        body: usingFireStore
            ? const EventViewer(usingFireStore:true)
            : const EventViewer(usingFireStore:false),
        floatingActionButton: usingFireStore
        ? const EventFormButton(usingFirestore: true)
        : const EventFormButton(usingFirestore: false));
  }
}


