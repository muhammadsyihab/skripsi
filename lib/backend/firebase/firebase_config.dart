import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyDUe4hwqEdDHfLjf7U3UM8omrqsI4oM2Aw",
            authDomain: "pt-aneka.firebaseapp.com",
            projectId: "pt-aneka",
            storageBucket: "pt-aneka.appspot.com",
            messagingSenderId: "757366815481",
            appId: "1:757366815481:web:cec7d7b0b37aa6d280c028",
            measurementId: "G-66KYJZ03T9"));
  } else {
    await Firebase.initializeApp();
  }
}
