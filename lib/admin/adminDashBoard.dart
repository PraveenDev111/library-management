import 'package:flutter/material.dart';
import 'package:library_management/admin/borrowedpage.dart';
import 'package:library_management/admin/burrowerdetails.dart';

import 'addLibraryRoom.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  final user = "Librarian";

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog.adaptive(
            title: Text('Welcome $user'),
            content: const Text(
              'As an admin, you have several privileges over the content available across Library manager. Check manual for more details.',
              style: TextStyle(fontSize: 14),
              textAlign: TextAlign.justify,
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AddBurrowerPage()));
                  },
                  child: const Row(
                    children: [
                      Icon(Icons.people_alt),
                      Text(' Add burrower'),
                    ],
                  )),
              TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LibraryDashboard()));
                  },
                  child: const Row(
                    children: [
                      Icon(Icons.menu_book_sharp),
                      Text(' Rooms booking'),
                    ],
                  )),
              TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const BorrowedBooksPageAdmin()));
                  },
                  child: const Row(
                    children: [
                      Icon(Icons.menu_book_sharp),
                      Text(' View borrowed books'),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
