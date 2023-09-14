import 'package:client_itc/core/constant/color.dart';
import 'package:flutter/material.dart';

class SearchWidget extends StatefulWidget {
  const SearchWidget({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  List<Map<dynamic, dynamic>> serch = [
    {
      'id': 1,
      'name': '',
    },
   
  ];

  List<Map<dynamic, dynamic>> foundlocatin = [];
  @override
  void initState() {
    foundlocatin = serch;
    super.initState();
  }

  void runFilter(String enteredKeyword) {
    List<Map<dynamic, dynamic>> result = [];
    if (enteredKeyword.isEmpty) {
      result = serch;
    } else {
      result = serch
          .where((location) =>
              location['name'].contains(enteredKeyword.toLowerCase()))
          .toList();
    }
    setState(() {
      foundlocatin = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;

    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          SizedBox(
            height: h * .02,
          ),
          TextField(
            onChanged: (value) => runFilter(value),
            decoration: const InputDecoration(
                labelText: 'Search', suffixIcon: Icon(Icons.search)),
          ),
          SizedBox(
            height: h * .02,
          ),
          SizedBox(
            height: h * .7,
            child: ListView.builder(
              itemCount: foundlocatin.length,
              itemBuilder: (context, index) => Card(
                key: ValueKey(foundlocatin[index]['id']),
                color: AppColor.blue,
                elevation: 5,
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: ListTile(
                  title: Text(
                    foundlocatin[index]['name'].toString(),
                    style: const TextStyle(
                      fontSize: 20,
                      color: AppColor.primaryColor,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                            offset: Offset(5, 5),
                            color: Colors.black38,
                            blurRadius: 5),
                      ],
                    ),
                  ),
                  subtitle: Text(
                    foundlocatin[index]['discription'].toString(),
                    style: const TextStyle(
                        fontSize: 15,
                        color: AppColor.primaryColor,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
