import 'dart:io';
import 'package:flutter/material.dart';
import 'package:register_student/db/model/data_model.dart';
import 'package:register_student/presentation/edit_students.dart';

class StudentDetails extends StatelessWidget {
  const StudentDetails({super.key, required this.studentData});
  final StudentModel studentData;

  @override
  Widget build(BuildContext context) {
    // getAllStudents();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(studentData.name.toString().toUpperCase()),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: ((context) => EditStudentPage(
                          student: studentData,
                        )),
                  ),
                );
              },
              icon: const Icon(Icons.edit),
              ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              studentData.imagePath != null
                  ? CircleAvatar(
                      radius: 80,
                      backgroundImage: FileImage(File(studentData.imagePath!)),
                      backgroundColor: Colors.amber,
                    )
                  :const CircleAvatar(
                      radius: 80,
                      backgroundImage:  NetworkImage(
                          'https://th.bing.com/th?q=Profile+Logo&w=120&h=120&c=1&rs=1&qlt=90&cb=1&dpr=1.3&pid=InlineBlock&mkt=en-IN&cc=IN&setlang=en&adlt=moderate&t=1&mw=247'),
                      backgroundColor: Colors.amber,
                    ),
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: Center(
                    child: Text('Name : ${studentData.name}',
                        style: const TextStyle(fontSize: 20)),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: Center(
                    child: Text(
                      'Age : ${studentData.age}',
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: Center(
                    child: Text('Email : ${studentData.email}',
                        style: const TextStyle(fontSize: 20)),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: Center(
                    child: Text('Contact : ${studentData.contact}',
                        style: const TextStyle(fontSize: 20)),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
