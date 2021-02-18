import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseServiceAuth {
  static Future register(String email, String passw) async {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email.trim(), password: passw);
  }

  static Future login(String email, String passw) async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email.trim(), password: passw);
  }

  static Future logOut() async {
    await FirebaseAuth.instance.signOut();
  }

  static Future deleteUser(user) async {
    await user.delete();
  }

  static Future changePassword(user, String passw) async {
    await user.updatePassword(passw);
  }

  static Future changeEmail(user, String email) async {
    await user.updateEmail(email);
  }

  static Future forgotPassword(user, String email) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }
}

class DatabaseServiceFirestore {
  validatelogin({String collection, uid}) async {
    var result = false;
    await FirebaseFirestore.instance.collection(collection).doc(uid).get().then(
      (DocumentSnapshot value) {
        if (value.exists) {
          result = true;
        }
      },
    );
    return result;
  }

  FutureOr setDoc({String uid, String collectionName, instance}) async {
    await FirebaseFirestore.instance
        .collection(collectionName)
        .doc(uid)
        .set(instance.toJson());
  }

  Future<DocumentReference> addDoc({String collectionName, instance}) async {
    return await FirebaseFirestore.instance
        .collection(collectionName)
        .add(instance.toJson());
  }

  Stream<DocumentSnapshot> getDoc({String uid, String collectionName}) {
    return FirebaseFirestore.instance
        .collection(collectionName)
        .doc(uid)
        .snapshots();
  }

  FutureOr deleteDoc({String uid, String collectionName}) {
    FirebaseFirestore.instance.collection(collectionName).doc(uid).delete();
  }

  Stream getDocs({String collectionNamed, field, resultfield}) {
    return FirebaseFirestore.instance
        .collection(collectionNamed)
        .where(field, isEqualTo: resultfield)
        .snapshots();
  }

  Stream getAllDocs({String collectionNamed}) {
    return FirebaseFirestore.instance.collection(collectionNamed).snapshots();
  }

  DocumentReference getRef({String collectionNamed, String uid}) {
    return FirebaseFirestore.instance.collection(collectionNamed).doc(uid);
  }
}
