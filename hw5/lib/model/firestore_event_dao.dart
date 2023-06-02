import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_planner/view_model/event.dart';

const _collectionName = 'events';
const _id = 'id';
const _title = 'title';
const _description = 'description';
const _startDate = 'startDate';
const _endDate = 'endDate';

class FireStoreEventDao {
  FirebaseFirestore _firestore;

  FireStoreEventDao({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  Future<List<Event>?> getEvent(int id) async {
    final doc = await _firestore.doc('$_collectionName/$id').get();
    if (!doc.exists) {
      throw Future.error('Could not find $_collectionName/$id');
    }
    return _documentDataToEventList(doc.data()!);
  }
  Future<List<Event>> listEvents() async {
    final querySnap = await _eventsCollection.get();
    final docs = querySnap.docs;

    List<Event>events = [];
    for (var doc in docs){
      events.add(_documentDataToEvent(doc.data()));
    }
    return events;
  }
  Future<List<Event>> listCurrentEvents() async{
    final list =  await listEvents();
    return list.where((event) => event.endDate.isAfter(DateTime.now())).toList();
  }

  Future<String> addEvent(Event event) async {
    final docRef = await _eventsCollection.add(_eventToDocumentData(event));
    return docRef.id;
  }
  CollectionReference<Map<String,dynamic>> get _eventsCollection => _firestore.collection(_collectionName);
  List<Event> _documentDataToEventList(Map<String, dynamic> data){
    final List<Map<String, dynamic>> events = data['events'];
    return events.map(_documentDataToEvent).toList();
  }
  Event _documentDataToEvent(Map<String, dynamic> eventData) => Event(
        eventData[_title],
        eventData[_description],
        (eventData[_startDate] as Timestamp).toDate(),
        (eventData[_endDate] as Timestamp).toDate(),
        eventData[_id],
  );
  Map<String, dynamic> _eventToDocumentData(Event event) => {
    _id: event.id,
    _title: event.title,
    _description: event.description,
    _startDate: event.startDate,
    _endDate: event.endDate
  };
  Map<String, dynamic> _eventListToDocumentData(List<Event> events) => {
    'events': events.map(_eventToDocumentData).toList()
  };
}
