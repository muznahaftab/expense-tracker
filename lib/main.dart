import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(
    MaterialApp(debugShowCheckedModeBanner: false, home: Home()),
  );
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  String s1, s2;
  List<String> myList = [];
  SharedPreferences prefs;

  @override
  void initState() {
    initSharedPrefs();
    super.initState();
  }

  initSharedPrefs() async {
    prefs = await SharedPreferences.getInstance();
    loadData();
  }

  void saveData() {
    prefs.setStringList('list', myList);
  }

  void loadData() {
    myList = prefs.getStringList('list');
    setState(() {});
  }

  Widget items(String str) {
    return Center(
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
                title: Text(
                  str,
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.purple[600],
                  ),
                ),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  color: Colors.redAccent[700],
                  onPressed: () {
                    setState(() {
                      myList.remove(str);
                      saveData();
                    });
                  },
                )),
          ],
        ),
      ),
      // ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text('Expense tracker'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          scrollDirection: Axis.vertical,
          children: <Widget>[
            for (int i = 0; i < myList.length; i++) items(myList[i]),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: nameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Add item',
                ),
                onSubmitted: (String s) {
                  s2 = s;
                },
                textInputAction: TextInputAction.next,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: priceController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Price',
                ),
                onSubmitted: (String s) {
                  s1 = s;
                  if (s1.isNotEmpty && s2.isNotEmpty) {
                    setState(() {
                      String str = "₹" + s1 + " " + s2;
                      myList.add(str);
                      saveData();
                      s1 = s2 = "";
                      nameController.clear();
                      priceController.clear();
                    });
                  }
                },
              ),
            ),
            RaisedButton(
              textColor: Colors.white,
              color: Colors.blue,
              child: Text('Add'),
              onPressed: () {
                if (s2.isEmpty) s2 = nameController.text.toString();
                if (s1.isEmpty) s1 = priceController.text.toString();
                if (s1.isNotEmpty && s2.isNotEmpty) {
                  setState(() {
                    String str = "₹" + s1 + " " + s2;
                    myList.add(str);
                    saveData();
                    s1 = s2 = "";
                    nameController.clear();
                    priceController.clear();
                  });
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
