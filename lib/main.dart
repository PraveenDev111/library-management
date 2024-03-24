import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:library_management/admin/adminDashBoard.dart';
import 'package:library_management/bookdonate.dart';
import 'package:library_management/burrowedbooks.dart';
import 'package:library_management/components/constants.dart';
import 'package:library_management/library.dart';
import 'package:library_management/library_room.dart';
import 'package:library_management/test.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: "AIzaSyArJhUHEiNIKZ_oSjphjmrvcRMYYr61O2c",
        authDomain: "library-manager-5dd84.firebaseapp.com",
        projectId: "library-manager-5dd84",
        storageBucket: "library-manager-5dd84.appspot.com",
        messagingSenderId: "78347985226",
        appId: "1:78347985226:web:0bfdf4ac73d72dbb99e1b3"),
  );
  runApp(
    DevicePreview(
      builder: (context) =>
          const MainApp(), // Wrap your MaterialApp with DevicePreview
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    mobileDeviceWidth = MediaQuery.of(context).size.width;
    mobileDeviceHeight = MediaQuery.of(context).size.height;

    return MaterialApp(
      initialRoute: '/', // Set the initial route to '/new'
      routes: {
        '/': (context) => const Library(),
        '/test': ((context) => const TestApp()),
        '/donationpage': (context) => const BookDonationPage(),
        '/roombooking': (context) => const LibraryRoom(),
        '/burrowedbooks': (context) => const BorrowedBooksPage(),
        '/admin': (context) => const AdminDashboard()
      },
    );
  }
}
