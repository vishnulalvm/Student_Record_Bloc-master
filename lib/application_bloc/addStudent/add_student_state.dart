part of 'add_student_bloc.dart';

class AddStudentState {
  final StudentModel? studentList;
  final bool loading;
  final File? image;

  AddStudentState({this.studentList, required this.loading, this.image});

  factory AddStudentState.initial() {
    return AddStudentState(loading: false);
  }
}
