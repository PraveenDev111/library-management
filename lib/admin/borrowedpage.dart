import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BorrowedBooksPageAdmin extends StatelessWidget {
  const BorrowedBooksPageAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Borrowed Books'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream:
            FirebaseFirestore.instance.collection('library_books').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No books borrowed.'));
          }

          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data() as Map<String, dynamic>;
              return ListTile(
                title: Text('Book Name: ${data['book_name']}'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Book ID: ${data['book_id']}'),
                    Text(
                        'Borrowed Date: ${data['borrowed_date'].toDate().toString()}'),
                    Text('Due Date: ${data['due_date'].toDate().toString()}'),
                    Text('Student ID: ${data['student_id']}'),
                  ],
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
