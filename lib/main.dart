import 'dart:io';
// This is why we should separate logic and view
import 'package:drift/drift.dart' as DriftImport;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:galery_app/core/resources/consts/sizes.dart';
import 'package:galery_app/data/datasources/local/database/app_database.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:galery_app/presentation/widgets/image_picker/my_image_picker.dart';
import 'package:provider/provider.dart';
import 'data/datasources/local/database/dao/file_entity_dao.dart';
import 'domain/entities/file_entities.dart';
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

  // Firebase sign in (nanti pindahkan ke halaman login)
  final GoogleSignIn googleSignIn = GoogleSignIn();
  User? firebaseUser;
  GoogleSignInAccount? account = await googleSignIn.signIn();
  final GoogleSignInAuthentication? googleAuth = await account?.authentication;
  final AuthCredential cred = GoogleAuthProvider.credential(idToken: googleAuth?.idToken, accessToken: googleAuth?.accessToken);
  final UserCredential _res = await FirebaseAuth.instance.signInWithCredential(cred);
  firebaseUser = _res.user;
  print("firebaseUser: $firebaseUser");

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

  runApp(Provider(
    create: (BuildContext context) { return MyDatabase(); },
    child: const
    MyApp(),
  )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final db = Provider.of<MyDatabase>(context);
        return Provider<FileEntityDao>(
          create: (BuildContext context) { return db.fileEntityDao; },
          child: MaterialApp(
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
          ),
        );
      }
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

    return Builder(
      builder: (context) {
        StreamBuilder<List<FileWithTag>> _buildTaskList(BuildContext context) {
          final dao = Provider.of<FileEntityDao>(context,listen: false);
          return StreamBuilder(
            stream:
            dao.watchAllTasks(),
            builder: (context, AsyncSnapshot<List<FileWithTag>> snapshot) {
              final files = snapshot.data ?? [];

              return ListView.builder(
                itemCount: files.length,
                itemBuilder: (_, index) {
                  final itemTask = files[index];
                  // return Text("${itemTask}");
                  // FIXME change with ListTile and later make a gridview
                  return Center(
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: sizeNormal),
                      child: IntrinsicWidth(
                        child: Row(
                          children: [
                            SizedBox(
                                width: sizeHuge,
                                height: sizeHuge,
                                child: Image.network("${itemTask.theFile.url}",width: sizeMedium,fit: BoxFit.cover,)),
                          ],
                        ),
                      ),
                    ),
                  )
                  ;
                  // return _buildListItem(itemTask, dao);
                },
              );
            },
          );
        }

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
                // FIXME This is why we should separate logic and view
            Column(
              children: [
                MyImagePickerWidget(
                  functionCallbackSetImageFilePath: (file){
                    setState((){
                      fileUploaded = file;
                      imageName = file?.path.split("/").last ?? "";
                    });
                  },
                ),
                Expanded(child: _buildTaskList(context))
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: fileUploaded != null ? () async {
              try {
                final storage = FirebaseStorage.instance;
                // Create a storage reference from our app
                final storageRef = storage.ref();

                // Create a reference to "mountains.jpg"
                final mountainsRef = storageRef.child(imageName);

                // upload file ke storage
                mountainsRef.putFile(fileUploaded!).snapshotEvents.listen((taskSnapshot) async {
                  switch(taskSnapshot.state){
                    case TaskState.running:
                    // ...
                      break;
                    case TaskState.paused:
                    // ...
                      break;
                    case TaskState.success:
                      final dao = Provider.of<FileEntityDao>(context,listen:false);
                      var theUrl = await taskSnapshot.ref.getDownloadURL();

                      // final database = MyDatabase();

                      // Simple insert:
                      await dao.insertFile(FileEntitiesCompanion.insert(name: '$imageName',url: DriftImport.Value<String>(theUrl)));
                      // await database
                      //     .into(database.fileEntities)
                      //     .insert(FileEntitiesCompanion.insert(name: '${imageName}',url: DriftImport.Value<String>(theUrl)));

                      // Simple select:
                      // final allFiles = await database.select(database.fileEntities).get();
                      // print('Files in database: $allFiles');
                      print("Success Upload to firebase cloud, URL: ${theUrl}");
                      break;
                    case TaskState.canceled:
                    // ...
                      break;
                    case TaskState.error:
                    // ...
                      break;

                  }
                });
                    // .onData((data) {});
              } on FirebaseException catch (e) {
                print("ERROR: ${e.toString()}");
              }
            } : null,
            child: const Icon(Icons.send),),
        );
      }
    );
  }
}
