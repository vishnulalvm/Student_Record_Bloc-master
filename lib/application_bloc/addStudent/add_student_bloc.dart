import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:register_student/db/model/data_model.dart';
import 'package:register_student/infrastructure/db_service_funct.dart';
import 'package:register_student/infrastructure/image_picker.dart';

part 'add_student_event.dart';
part 'add_student_state.dart';

class AddStudentBloc extends Bloc<AddStudentEvent, AddStudentState> {
  final DbServiceFunctions _studentDbFunctions = DbServiceFunctions();

  AddStudentBloc() : super(AddStudentState(loading: false)) {
    on<AddStudent>((event, emit) async {
      if (state.image != null) {
        StudentModel student = StudentModel(
            name: event.student.name,
            age: event.student.age,
            email: event.student.email,
            contact: event.student.contact,
            imagePath: state.image?.path);
        await _studentDbFunctions.addStudentDetails(student);
        emit(AddStudentState(loading: false, image: null));
      } else {
        await _studentDbFunctions.addStudentDetails(event.student);
      }
    });

    on<AddImageEvent>((event, emit) async {
      emit(AddStudentState(loading: true));
      XFile? pickedImageXFile = await ImagePickerServices().pickImage();
      if (pickedImageXFile != null) {
        File pickedImageFile = File(pickedImageXFile.path);
        emit(AddStudentState(loading: false, image: pickedImageFile));
      } else {
        emit(AddStudentState(loading: false));
      }
    });
  }
}
