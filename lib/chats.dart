import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ChatPerson {
  late String fullName;
  late String imageUrl;

  ChatPerson();

  factory ChatPerson.fromJson(Map<String, dynamic> json) {
    final chatperson = ChatPerson();
    chatperson.fullName = json['fullName'] as String;
    chatperson.imageUrl = json['imageUrl'] as String;
    return chatperson;
  }
}

typedef OnIndexChangedCallback = void Function(int index);

class ChatsTab extends StatefulWidget {
  final OnIndexChangedCallback? onIndexChanged;

  const ChatsTab({super.key, this.onIndexChanged});

  @override
  _ChatsTabState createState() => _ChatsTabState();
}

class _ChatsTabState extends State<ChatsTab> {
  late List<ChatPerson> _persons;
  late List<ChatPerson> _filteredPersons;

  late TextEditingController _searchController;

  void _handleIndexChanged(int index) {
    widget.onIndexChanged?.call(index);
  }

  @override
  void initState() {
    super.initState();
    _persons = [];
    _filteredPersons = [];
    _searchController = TextEditingController();
    _loadDataFromServer();
  }

  Future<void> _loadDataFromServer() async {
    final response = await http
        .get(Uri.parse('http://jsonblob.com/api/1202535515458232320'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonList =
          json.decode(utf8.decode(response.bodyBytes));

      setState(() {
        _persons = jsonList.map((json) => ChatPerson.fromJson(json)).toList();
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
      backgroundColor: const Color(0xFF161616),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(135.0),
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Positioned(
              bottom: 75,
              child: SizedBox(
                height: 40.0,
                width: MediaQuery.of(context).size.width - 60.0,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 0.0),
                    child: GestureDetector(
                      onTap: () {
                        FocusScope.of(context).unfocus();
                        _handleIndexChanged(0);
                      },
                      child: const Image(
                        image: AssetImage('lib/assets/back.png'),
                        fit: BoxFit.contain,
                        width: 24,
                        height: 24,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 75,
              child: SizedBox(
                height: 40.0,
                width: MediaQuery.of(context).size.width - 60.0,
                child: const Padding(
                  padding: EdgeInsets.only(left: 125.0),
                  child: Text(
                    'Чаты',
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
              bottom: 75,
              child: SizedBox(
                height: 40.0,
                width: MediaQuery.of(context).size.width - 60.0,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 315.0),
                    child: GestureDetector(
                      onTap: () {
                        FocusScope.of(context).unfocus();
                        _handleIndexChanged(0);
                      },
                      child: const Image(
                        image: AssetImage('lib/assets/Vector.png'),
                        fit: BoxFit.contain,
                        width: 22,
                        height: 22,
                      ),
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
                  color: const Color(0xFF292929),
                  borderRadius: BorderRadius.circular(25.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(right: 10.0, left: 10.0),
                  child: TextField(
                    controller: _searchController,
                    onChanged: (searchText) {
                      _search(searchText);
                    },
                    decoration: const InputDecoration(
                      contentPadding:
                          EdgeInsets.only(left: 47.0, bottom: 10, right: 34.0),
                      hintText: 'Введите имя и фамилию',
                      hintStyle: TextStyle(
                        fontSize: 14.0,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.normal,
                        color: Color(0xFFA0A0A0),
                      ),
                      border: InputBorder.none,
                    ),
                    style: const TextStyle(
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
                child: SizedBox(
                  height: 40.0,
                  width: MediaQuery.of(context).size.width - 32.0,
                  child: const Row(
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
              padding: const EdgeInsets.only(),
              child: ListView.builder(
                itemCount: _filteredPersons.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(right: 16.0, left: 16.0),
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
                            const SizedBox(width: 14.0),
                            Expanded(
                              child: Container(
                                margin: const EdgeInsets.only(right: 86.0),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 23.0),
                                  child: Column(
                                    children: [
                                      Text(
                                        _filteredPersons[index].fullName,
                                        style: const TextStyle(
                                          color: Color(0xFFFFFFFF),
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      Text(
                                        _filteredPersons[index].fullName,
                                        style: const TextStyle(
                                          color: Color(0xFFFFFFFF),
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(right: 5.0, top: 1.5),
                              child: Column(
                                children: [
                                  const Text(
                                    '13:04',
                                    style: TextStyle(
                                      color: Color(0xFFFFFFFF),
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  const SizedBox(width: 5.0),
                                  Container(
                                    width: 24.0,
                                    height: 24.0,
                                    decoration: const BoxDecoration(
                                      color: Color(0xFF6D55FF),
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Center(
                                      child: Text(
                                        '2',
                                        style: TextStyle(
                                          color: Color(0xFFFFFFFF),
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 16.0, right: 16.0),
                      ),
                    ],
                  );
                },
              ),
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
