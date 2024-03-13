import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Person {
  late String fullName;
  late String imageUrl;

  Person();

  factory Person.fromJson(Map<String, dynamic> json) {
    final person = Person();
    person.fullName = json['fullName'] as String;
    person.imageUrl = json['imageUrl'] as String;
    return person;
  }
}

typedef void OnIndexChangedCallback(int index);

class PeopleTab extends StatefulWidget {

  final OnIndexChangedCallback? onIndexChanged;

  PeopleTab({this.onIndexChanged});

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
    final response = await http.get(Uri.parse('http://jsonblob.com/api/1202535515458232320'));

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
      person.fullName.toLowerCase().contains(searchText.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xFF161616),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(135.0),
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Positioned(
              bottom: 75,
              child: Container(
                height: 40.0,
                width: MediaQuery.of(context).size.width - 25.0,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 0.0),
                    child: GestureDetector(
                      onTap: () {
                        widget.onIndexChanged?.call(0);
                      },
                      child: Image(
                        image: AssetImage('lib/assets/back.png'),
                        fit: BoxFit.contain,
                        width: 31,
                        height: 31,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 75,
              child: Container(
                height: 40.0,
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    'Друзья',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF6D55FF),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 20,
              child: Container(
                height: 40.0,
                width: MediaQuery.of(context).size.width - 32.0,
                decoration: BoxDecoration(
                  color: Color(0xFF292929),
                  borderRadius: BorderRadius.circular(25.0),
                ),
                child: Padding(
                  padding: EdgeInsets.only(right: 10.0, left: 10.0),
                  child: TextField(
                    controller: _searchController,
                    onChanged: (searchText) {
                      _search(searchText);
                    },
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(left: 47.0, bottom: 10, right: 34.0),
                      hintText: 'Введите имя и фамилию',
                      hintStyle: TextStyle(
                        fontSize: 14.0,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.normal,
                        color: Color(0xFFA0A0A0),
                      ),
                      border: InputBorder.none,
                    ),
                    style: TextStyle(
                      fontSize: 14.0,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.normal,
                      color: Color(0xFFFFFFFF),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 20,
              child: IgnorePointer(
                child: Container(
                  height: 40.0,
                  width: MediaQuery.of(context).size.width - 32.0,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.only(left: 12),
                          child: Image(
                            image: AssetImage('lib/assets/search.png'),
                            fit: BoxFit.contain,
                            width: 24,
                            height: 24,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: _filteredPersons != null
          ? Padding(
        padding: EdgeInsets.only(),
          child: ListView.builder(
        itemCount: _filteredPersons.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Container(
                padding: EdgeInsets.only(right: 16.0, left: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ClipOval(
                      child: Image.asset(
                        _filteredPersons[index].imageUrl,
                        width: 43.0,
                        height: 43.0,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(width: 14.0),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(right: 26.0),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 23.0),
                          child: Text(
                            '${_filteredPersons[index].fullName}',
                            style: TextStyle(
                              color: Color(0xFFFFFFFF),
                              fontSize: 15.0,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    ),
                      Padding(
                      padding: EdgeInsets.only(right: 25.0, top: 1.5),
                    child: Image(
                        image: AssetImage('lib/assets/addFriend.png'),
                        fit: BoxFit.contain,
                        width: 19,
                        height: 19,
                      ),
                      ),
                    Image(
                      image: AssetImage('lib/assets/chat.png'),
                      fit: BoxFit.contain,
                      width: 19,
                      height: 19,
                    ),
                  ],
                ),
              ),
                Container(
                  margin: EdgeInsets.only(left: 16.0, right: 16.0),
                ),
            ],
          );
        },
      ),
      )
          : Center(child: CircularProgressIndicator()),
    );

  }
}