import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddBurrowerPage extends StatefulWidget {
  const AddBurrowerPage({super.key});

  @override
  _AddBurrowerPageState createState() => _AddBurrowerPageState();
}

class _AddBurrowerPageState extends State<AddBurrowerPage> {
  final TextEditingController _bookNameController = TextEditingController();
  final TextEditingController _bookIdController = TextEditingController();
  DateTime _borrowedDate = DateTime.now(); // Default to current date
  DateTime _dueDate = DateTime.now(); // Default to current date
  final TextEditingController _studentIdController = TextEditingController();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> _addBurrower() async {
    try {
      // Convert DateTime to Timestamp
      Timestamp borrowedTimestamp = Timestamp.fromDate(_borrowedDate);
      Timestamp dueTimestamp = Timestamp.fromDate(_dueDate);

      // Add the book details to Firestore
      await _firestore.collection('library_books').add({
        'book_name': _bookNameController.text,
        'book_id': _bookIdController.text,
        'borrowed_date': borrowedTimestamp,
        'due_date': dueTimestamp,
        'student_id': _studentIdController.text,
      });

      // Navigate back to the previous page after adding the book
      Navigator.pop(context);
    } catch (e) {
      print('Error adding burrower: $e');
      // Handle error if necessary
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _borrowedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _borrowedDate) {
      setState(() {
        _borrowedDate = picked;
      });
    }
  }

  Future<void> _selectDueDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: _dueDate,
        firstDate: DateTime(2000),
        lastDate: DateTime(2025));
    if (picked != null && picked != _dueDate) {
      setState(() {
        _dueDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Burrower'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _bookNameController,
              decoration: const InputDecoration(labelText: 'Book Name'),
            ),
            TextField(
              controller: _bookIdController,
              decoration: const InputDecoration(labelText: 'Book ID'),
            ),
            InkWell(
              onTap: () => _selectDate(context),
              child: InputDecorator(
                decoration: const InputDecoration(
                  labelText: 'Borrowed Date',
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('${_borrowedDate.toLocal()}'.split(' ')[0]),
                    const Icon(Icons.calendar_today),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () => _selectDueDate(context),
              child: InputDecorator(
                decoration: const InputDecoration(
                  labelText: 'Due Date',
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('${_dueDate.toLocal()}'.split(' ')[0]),
                    const Icon(Icons.calendar_today),
                  ],
                ),
              ),
            ),
            TextField(
              controller: _studentIdController,
              decoration: const InputDecoration(labelText: 'Student ID'),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _addBurrower,
              child: const Text('Add Burrower'),
            ),
          ],
        ),
      ),
    );
  }
}
