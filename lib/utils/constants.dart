import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/Material.dart';
import 'package:tiktok_new_clone/controller/auth_controller.dart';

Color kBackgroundColor = Colors.black;
const kButtomColor = Color(0xfffd2c54);
Color kGreyColor = Colors.grey.shade100;

var firebaseAuth = FirebaseAuth.instance;
var firebaseStorage = FirebaseStorage.instance;
var firebaseFirestore = FirebaseFirestore.instance;

var authController = AuthController.instance;
