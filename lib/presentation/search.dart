import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:register_student/application_bloc/homePage/home_page_bloc.dart';
import 'package:register_student/presentation/student_details.dart';

class MySearch extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            if (query.isEmpty) {
              close(context, null);
            } else {
              query = '';
            }
          },
          icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center(
      child: Text(query),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return BlocBuilder<HomePageBloc, HomePageState>(
      builder: (context, state) {
        final listItems = query.isEmpty
            ? state.studentList
            : state.studentList
                .where((element) => element.name
                    .toLowerCase()
                    .startsWith(query.toLowerCase().toString()))
                .toList();

        return listItems.isEmpty
            ? const Center(child: Text("No student data found!"))
            : ListView.builder(
                itemCount: listItems.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 5.00, right: 5.00),
                    child: Column(
                      children: [
                        ListTile(
                          leading: const CircleAvatar(
                            backgroundImage: NetworkImage(
                                'https://th.bing.com/th?q=Profile+Logo&w=120&h=120&c=1&rs=1&qlt=90&cb=1&dpr=1.3&pid=InlineBlock&mkt=en-IN&cc=IN&setlang=en&adlt=moderate&t=1&mw=247'),
                            radius: 30,
                          ),
                          title: Text(
                            listItems[index].name,
                          ),
                          subtitle: Text(
                            listItems[index].email,
                          ),
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (ctx) => StudentDetails(
                                    studentData: listItems[index]),
                              ),
                            );
                          },
                        ),
                        const Divider(
                          thickness: 2,
                          color: Colors.blueAccent,
                        ),
                      ],
                    ),
                  );
                },
              );
      },
    );
  }
}
