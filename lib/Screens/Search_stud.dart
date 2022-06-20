import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:student_manag/db_funct/database.dart';
import 'package:student_manag/Screens/Stud_Prof.dart';

import '../db_funct/database.dart';

class SearchStud extends StatelessWidget {
  SearchStud({Key? key}) : super(key: key);
  final searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(15, 20, 15, 20),
                    child: TextField(
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Enter student name to search',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                      ),
                      controller: searchController,
                      onChanged: (value) {
                        context.read<Counter>().getSearchResult(value);
                      },
                    ),
                  ),
                ),
              ],
            ),
            Consumer<Counter>(
              builder: (context, datas, _) {
                return Expanded(
                  child: ListView.separated(
                      itemBuilder: (context, index) {
                        var data = datas.searchData[index];
                        if (data.name
                            .toLowerCase()
                            .contains(searchController.text.toLowerCase())) {
                          return Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: Card(
                              color: const Color.fromARGB(168, 186, 204, 156),
                              child: ListTile(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => StudProf(
                                        data: data,
                                      ),
                                    ),
                                  );
                                },
                                title: Text(
                                  data.name.toUpperCase(),
                                ),
                              ),
                            ),
                          );
                        } else {
                          return Container();
                        }
                      },
                      separatorBuilder: (context, index) {
                        return const Divider();
                      },
                      itemCount: context.read<Counter>().searchData.length),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
