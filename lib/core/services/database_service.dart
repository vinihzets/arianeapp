import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final users = FirebaseFirestore.instance.collection('users');
  final clients = FirebaseFirestore.instance.collection('clients');
  final typePerfurations = FirebaseFirestore.instance.collection('type_perfurations');
}
