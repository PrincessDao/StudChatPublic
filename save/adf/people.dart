import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Person {
  late String fullName;
  late String group;
  late String imageUrl;

  Person();

  factory Person.fromJson(Map<String, dynamic> json) {
    final person = Person();
    person.fullName = json['fullName'] as String;
    person.group = json['group'] as String;
    person.imageUrl = json['imageUrl'] as String;
    return person;
  }
}

class PeopleTab extends StatefulWidget {
  @override
  _PeopleTabState createState() => _PeopleTabState();
}

class _PeopleTabState extends State<PeopleTab> {
  late List<Person> _persons;
  late List<Person> _filteredPersons;

  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _persons = [];
    _filteredPersons = [];
    _searchController = TextEditingController();
    _loadDataFromServer();
  }

  Future<void> _loadDataFromServer() async {
    final response = await http.get(Uri.parse('https://jsonblob.com/api/1194647805573849088'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(utf8.decode(response.bodyBytes));

      setState(() {
        _persons = jsonList.map((json) => Person.fromJson(json)).toList();
        _filteredPersons = List.from(_persons);
      });
    } else {
      throw Exception('Failed to load data from the server');
    }
  }

  void _search(String searchText) {
    setState(() {
      _filteredPersons = _persons
          .where((person) =>
      person.fullName.toLowerCase().contains(searchText.toLowerCase()) ||
          person.group.toLowerCase().contains(searchText.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF141416),
      appBar: AppBar(
        backgroundColor: Color(0xFF141416),
        toolbarHeight: 55.0,
        title: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight - 20.0),
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(vertical: 10.0),
            child: Stack(
              alignment: Alignment.centerRight,
              children: [
                Container(
                  height: 40.0,
                  width: MediaQuery.of(context).size.width - 60.0,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                ),
                Positioned(
                  right: 10.0,
                  child: InkWell(
                    onTap: () {
                      String searchText = _searchController.text;
                      _search(searchText);
                    },
                    child: Icon(Icons.search, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: _filteredPersons != null
          ? ListView.builder(
        itemCount: _filteredPersons.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ClipOval(
                      child: Image.asset(
                        _filteredPersons[index].imageUrl,
                        width: 40.0,
                        height: 40.0,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(width: 8.0),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(right: 26.0),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 26.0),
                          child: Text(
                            '${_filteredPersons[index].fullName}',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Text(
                      '${_filteredPersons[index].group}',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12.0,
                      ),
                    ),
                  ],
                ),
              ),
              if (index < _filteredPersons.length - 1)
                Divider(
                  color: Colors.grey,
                  thickness: 0.5,
                  indent: 16.0,
                  endIndent: 16.0,
                  height: 1,
                ),
            ],
          );
        },
      )
          : Center(child: CircularProgressIndicator()),
    );
  }
}