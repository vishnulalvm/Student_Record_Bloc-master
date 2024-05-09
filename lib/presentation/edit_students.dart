import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:register_student/application_bloc/homePage/home_page_bloc.dart';
import 'package:register_student/db/model/data_model.dart';

class EditStudentPage extends StatelessWidget {
  EditStudentPage({super.key, required this.student});

  final StudentModel student;

  final _updateNameController = TextEditingController();

  final _updateAgeController = TextEditingController();

  final _updateContactController = TextEditingController();

  final _updateEmailController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    
    _updateAgeController.text = student.age.toString();
    _updateNameController.text = student.name;
    _updateContactController.text = student.contact.toString();
    _updateEmailController.text = student.email;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          'Edit ${student.name} ',
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              children: [

                InkWell(
                  onTap: () {
                    
                  },


                  child: student.imagePath != null
                      ? CircleAvatar(
                          radius: 80,
                          foregroundImage: FileImage(File(student.imagePath!)),
                        )
                      : const CircleAvatar(
                          radius: 80,
                          foregroundImage: NetworkImage(
                              'https://th.bing.com/th?q=Profile+Logo&w=120&h=120&c=1&rs=1&qlt=90&cb=1&dpr=1.3&pid=InlineBlock&mkt=en-IN&cc=IN&setlang=en&adlt=moderate&t=1&mw=247'),
                        ),




                ),
                const SizedBox(
                  height: 10,
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _updateNameController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Name is required';
                    } else if (value.contains('@') || value.contains('.')) {
                      return 'Enter valid Name';
                    } else {
                      return null;
                    }
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        width: 2,
                        color: Color.fromARGB(255, 165, 89, 83),
                      ),
                    ),
                    labelText: 'Name',
                    hintText: 'Name',
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: _updateAgeController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Age is required';
                    } else if (!RegExp(r'^[0-9]{1,2}').hasMatch(value) ||
                        (value.length) > 2) {
                      return 'Enter valid age';
                    } else {
                      return null;
                    }
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    labelText: 'Age',
                    hintText: 'Age',
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: _updateEmailController,
                  validator: (value) {
                    if (_updateEmailController.text.isEmpty ||
                        !RegExp(r'[A-Za-z\._\-[0-9]*[@][A-Za-z]*[\.][a-z]{2,4}')
                            .hasMatch(value!)) {
                      return 'Enter valid Email ID';
                    } else {
                      return null;
                    }
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    labelText: 'Email',
                    hintText: 'Email',
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: _updateContactController,
                  validator: (value) {
                    if ((_updateContactController.text.isEmpty)) {
                      return 'Phone Number is required';
                    } else {
                      return null;
                    }
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    labelText: 'Contact',
                    hintText: 'Contact',
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () {
                    final name = _updateNameController.text.trim();
                    final age = _updateAgeController.text.trim();
                    final email = _updateEmailController.text.trim();
                    final contact = _updateContactController.text.trim();

                    final studentUpdated = StudentModel(
                      name: name,
                      age: int.parse(age),
                      contact: int.parse(contact),
                      email: email,
                      id: student.id,
                    );

                    BlocProvider.of<HomePageBloc>(context)
                        .add(EditStudent(student: studentUpdated));

                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text(
                              ' Details of ${studentUpdated.name} updated successfully!',
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            backgroundColor: Colors.blue),
                      );
                      Navigator.pop(context, true);
                      Navigator.pop(context, true);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text(
                              ' Details of ${studentUpdated.name} updated failed!',
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            backgroundColor: Colors.red),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: const Text('Confirm'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
