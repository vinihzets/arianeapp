import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final users = FirebaseFirestore.instance.collection('users');
  final clients = FirebaseFirestore.instance.collection('clients');
  final periods = FirebaseFirestore.instance.collection('periods');
  final perfurations = FirebaseFirestore.instance.collection('perfurations');
  final pendings = FirebaseFirestore.instance.collection('pendings');
  final typePerfurations = FirebaseFirestore.instance.collection(
    'type_perfurations',
  );
}
