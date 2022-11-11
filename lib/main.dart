import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:galery_app/presentation/widgets/image_picker/my_image_picker.dart';
import 'firebase_options.dart';

// test commit firebase cloud
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Firebase AppCheck
  await FirebaseAppCheck.instance.activate(
    webRecaptchaSiteKey: 'recaptcha-v3-site-key',
    // Default provider for Android is the Play Integrity provider. You can use the "AndroidProvider" enum to choose
    // your preferred provider. Choose from:
    // 1. debug provider
    // 2. safety net provider
    // 3. play integrity provider
    androidProvider: AndroidProvider.debug,
  );

  var statusCamera = await Permission.camera.status;
  var statusStorage = await Permission.storage.status;
  if (statusCamera.isDenied) await Permission.camera.request();
  if (await Permission.camera.isPermanentlyDenied) {
    openAppSettings();
  }
  if (statusStorage.isDenied) {
    await Permission.storage.request();
  }

  if (await Permission.manageExternalStorage.status.isDenied ||
      await Permission.manageExternalStorage.isPermanentlyDenied) {
    await Permission.manageExternalStorage.request();
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String imageName = '';
  File? fileUploaded;



  @override
  Widget build(BuildContext context) {
    final storage = FirebaseStorage.instance;
    // Create a storage reference from our app
    final storageRef = storage.ref();

    // Create a reference to "mountains.jpg"
    final mountainsRef = storageRef.child(imageName);
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child:
        MyImagePickerWidget(
          functionCallbackSetImageFilePath: (file){
            setState((){
              fileUploaded = file;
              imageName = file?.path.split("/").last ?? "";
            });
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: fileUploaded != null ? () async {
          try {
            // Firebase sign in (nanti pindahkan ke halaman login)
            final GoogleSignIn googleSignIn = GoogleSignIn();
            User? firebaseUser;
            GoogleSignInAccount? account = await googleSignIn.signIn();
            final GoogleSignInAuthentication? googleAuth = await account?.authentication;
            final AuthCredential cred = GoogleAuthProvider.credential(idToken: googleAuth?.idToken, accessToken: googleAuth?.accessToken);
            final UserCredential _res = await FirebaseAuth.instance.signInWithCredential(cred);
            firebaseUser = _res.user;

            // upload file ke storage
            await mountainsRef.putFile(fileUploaded!).snapshotEvents.listen((taskSnapshot) {
              switch(taskSnapshot.state){
                case TaskState.running:
                // ...
                  break;
                case TaskState.paused:
                // ...
                  break;
                case TaskState.success:
                  print("Success Upload to firebase cloud");
                  break;
                case TaskState.canceled:
                // ...
                  break;
                case TaskState.error:
                // ...
                  break;

              }
            });
          } on FirebaseException catch (e) {
            print("ERROR: ${e.toString()}");
          }
        } : null,
        child: const Icon(Icons.send),),
    );
  }
}
