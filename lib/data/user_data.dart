import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:toody/model/task_model.dart';
import 'package:uuid/uuid.dart';

class FirestoreDatasource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<bool> createUser(String fullname, String email) async {
    try {
      await _firestore.collection('users').doc(_auth.currentUser!.uid).set(
          {"id": _auth.currentUser!.uid, "fullname": fullname, "email": email});
      return true;
    } catch (e) {
      return true;
    }
  }

  Future<bool> addTask(String title, String description, String category,
      String timeTask, String dateTask) async {
    try {
      var uuid = const Uuid().v4();
      await FirebaseFirestore.instance
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .collection('task')
          .doc(uuid)
          .set({
        'id': uuid,
        'title': title,
        'description': description,
        'isDone': false,
        'category': category,
        'timeTask': timeTask,
        'dateTask': dateTask,
      });

      return true;
    } catch (e) {
      return false;
    }
  }

  List getTask(AsyncSnapshot snapshot) {
    try {
      final taskList = snapshot.data.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return Task(
          data['id'],
          data['title'],
          data['description'],
          data['category'],
          data['dateTask'],
          data['timeTask'],
          data['isDone'],
        );
      }).toList();

      // Sort tasks by dateTask (ascending order)
      taskList.sort((a, b) => DateFormat('MM/dd/yyyy')
          .parse(a.dateTask)
          .compareTo(DateFormat('MM/dd/yyyy').parse(b.dateTask)));

      return taskList;
    } catch (e) {
      return [];
    }
  }

  Stream<QuerySnapshot> stream() {
    return _firestore
        .collection('users')
        .doc(_auth.currentUser!.uid)
        .collection('task')
        .snapshots();
  }

  Future<bool> isdone(String uuid, bool isDone) async {
    try {
      await _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .collection('task')
          .doc(uuid)
          .update({'isDone': isDone});
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> deleteTask(String uuid) async {
    try {
      await _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .collection('task')
          .doc(uuid)
          .delete();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<String> getLoggedInUserName() async {
    try {
      String uid = FirebaseAuth.instance.currentUser!.uid;

      DocumentReference docRef = _firestore.collection('users').doc(uid);

      DocumentSnapshot snapshot = await docRef.get();

      Map<String, dynamic> userData = snapshot.data() as Map<String, dynamic>;
      String fullname = userData['fullname'];

      return fullname;
    } catch (e) {
      return 'Unknown User';
    }
  }
}
