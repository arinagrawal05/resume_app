import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firabase_storage;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class AppUtils {
  static String getFirstWord(String fullName) {
    List local = fullName.split(" ");
    return local[0];
  }

  static launchURL(String url) async {
    var link = Uri.parse(url);
    if (!await launchUrl(link)) {
      throw Exception('Could not launch $link');
    }
  }

  static Future<Future> navigate(
    Widget pagename,
    BuildContext context,
  ) async {
    return Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => pagename,
      ),
    );
  }

  updatePolicyStatus(String policyID, String status, DateTime statusDate) {
    FirebaseFirestore.instance.collection("Policies").doc(policyID).update({
      "policy_status": status,
      "status_date": statusDate,
    });
  }
}

Future<String?>? uploadFileToFirebase(
    {required Uint8List imageFile, required String fileName}) async {
  String imageUrl = '';
  try {
    firabase_storage.UploadTask uploadTask;

    firabase_storage.Reference ref = firabase_storage.FirebaseStorage.instance
        .ref()
        .child('Documents')
        .child('/' + fileName);

    final metadata =
        firabase_storage.SettableMetadata(contentType: 'image/jpeg');

    //uploadTask = ref.putFile(File(file.path));
    uploadTask = ref.putData(imageFile, metadata);

    await uploadTask.whenComplete(() => null);
    imageUrl = await ref.getDownloadURL();
  } catch (e) {
    print(e);
  }
  return imageUrl;
}
