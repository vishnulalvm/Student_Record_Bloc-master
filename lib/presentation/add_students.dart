import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:register_student/application_bloc/addStudent/add_student_bloc.dart';
import 'package:register_student/db/model/data_model.dart';
import 'package:register_student/presentation/home_page.dart';

class AddStudents extends StatelessWidget {
  AddStudents({super.key});

  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();

  final _ageController = TextEditingController();

  final _contactController = TextEditingController();

  final _emailController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'ADD STUDENT',
        ),
      ),
      body: BlocBuilder<AddStudentBloc, AddStudentState>(
        builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  Stack(
                    children: [
                      ColoredBox(
                        color: Colors.white,
                        child: InkWell(
                          onTap: () {
                            BlocProvider.of<AddStudentBloc>(context)
                                .add(AddImageEvent());
                          },
                          child: state.image != null
                              ? CircleAvatar(
                                  radius: 90,
                                  foregroundImage: FileImage(state.image!),
                                )
                              : const CircleAvatar(
                                  radius: 90,
                                  foregroundImage: NetworkImage(
                                      'https://th.bing.com/th?q=Profile+Logo&w=120&h=120&c=1&rs=1&qlt=90&cb=1&dpr=1.3&pid=InlineBlock&mkt=en-IN&cc=IN&setlang=en&adlt=moderate&t=1&mw=247'),
                                ),
                        ),
                      ),
                      Positioned(
                        bottom: 5,
                        left: 0,
                        child: Center(
                          child: IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.add_a_photo,
                              size: 50,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 15,
                          ),
                         
                          const SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            textCapitalization: TextCapitalization.words,
                            controller: _nameController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Name is required';
                              } else if (value.contains('@') ||
                                  value.contains('.')) {
                                return 'Enter valid Name';
                              } else {
                                return null;
                              }
                            },
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              labelText: "Name",
                              hintText: 'Name',
                            ),
                          ),
                          const SizedBox(height: 15),
                          TextFormField(
                            keyboardType: TextInputType.number,
                            controller: _ageController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Age is required';
                              } else if (!RegExp(r'^[0-9]{1,2}')
                                      .hasMatch(value) ||
                                  (value.length) > 2) {
                                return 'Enter valid age';
                              } else {
                                return null;
                              }
                            },
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              labelText: "Age",
                              hintText: 'Age',
                            ),
                          ),
                          const SizedBox(height: 15),
                          TextFormField(
                            controller: _emailController,
                            validator: (value) {
                              if (_emailController.text.isEmpty ||
                                  !RegExp(r'[A-Za-z\._\-[0-9]*[@][A-Za-z]*[\.][a-z]{2,4}')
                                      .hasMatch(value!)) {
                                return 'Enter valid Email ID';
                              } else {
                                return null;
                              }
                            },
                            keyboardType: TextInputType.emailAddress,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              labelText: "Email",
                              hintText: 'Email',
                            ),
                          ),
                          const SizedBox(height: 15),
                          TextFormField(
                            keyboardType: TextInputType.number,
                            controller: _contactController,
                            validator: (value) {
                              if ((_contactController.text.isEmpty)) {
                                return 'Phone Number is required';
                              } else {
                                return null;
                              }
                            },
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              labelText: "Contact",
                              hintText: 'Contact',
                            ),
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                final name = _nameController.text.trim();
                                final age = _ageController.text.trim();
                                final email = _emailController.text.trim();
                                final contact = _contactController.text.trim();

                                if (name.isEmpty ||
                                    age.isEmpty ||
                                    email.isEmpty ||
                                    contact.isEmpty) {
                                  return;
                                }
                                final student = StudentModel(
                                  name: name,
                                  age: int.parse(age),
                                  email: email,
                                  contact: int.parse(contact),
                                );

//////////////----------

                                BlocProvider.of<AddStudentBloc>(context)
                                    .add(AddStudent(student: student));


                                    

                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const HomePage(),
                                  ),
                                );
                              }
                            },
                            child: const Text(
                              'Add Student',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // Future<void> onAddButton(context) async {
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     const SnackBar(
  //       content: Text(
  //         'Student Added Successfully',
  //       ),
  //       backgroundColor: Colors.blueGrey,
  //     ),
  //   );
  // }
}
