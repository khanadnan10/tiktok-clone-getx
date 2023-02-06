import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tiktok_new_clone/model/user.dart' as model;
import 'package:tiktok_new_clone/utils/constants.dart';
import 'package:tiktok_new_clone/views/auth/login_page.dart';
import 'package:tiktok_new_clone/views/home_page.dart';

class AuthController extends GetxController {
  late Rx<File?> _profileImage;
  late Rx<User?> _user;
  @override
  void onReady() {
    _user = Rx<User?>(FirebaseAuth.instance.currentUser);
    _user.bindStream(firebaseAuth.userChanges());
    ever(_user, _screenDecide);
    super.onReady();
  }

  _screenDecide(User? user) {
    if (user != null) {
      Get.offAll(() => const LoginPage());
    } else {
      Get.offAll(() => const HomePage());
    }
  }

  void pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      print('Image Selected');
    } else {
      Get.snackbar('', 'please select an image');
    }
    _profileImage = Rx(File(image!.path));
  }

  Future<String> _uploadtoStorage(File image) async {
    Reference ref = firebaseStorage
        .ref()
        .child('profilePic')
        .child(firebaseAuth.currentUser!.uid);

    UploadTask putFile = ref.putFile(image);
    TaskSnapshot upload = await putFile;
    String? url = await upload.ref.getDownloadURL();
    return url;
  }

  Future<void> signUpUser(
      String username, String email, String password, File? image) async {
    try {
      // Registering user with email and password

      UserCredential cred = await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);

      // Storing extra information into firestore and storage
      String profilePicdownloadUrl = await _uploadtoStorage(image!);
      model.User user = model.User(
          name: username,
          email: email,
          uid: cred.user!.uid,
          profilePhoto: profilePicdownloadUrl);

      await firebaseFirestore
          .collection('users')
          .doc(cred.user!.uid)
          .set(user.toJson());
    } on FirebaseException catch (e) {
      Get.snackbar('Signup Error', 'Something went wrong while registering');
      print(e.toString());
    }
  }

  Future<void> signInUser(String email, String password) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseException catch (e) {
      Get.snackbar(
          'Error logging in', 'Something went wrong with signin. Try again!');

      print(e.toString());
    }
  }

  Future<void> signOut() async {
    await firebaseAuth.signOut();
  }
}
