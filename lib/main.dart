import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(debugShowCheckedModeBanner: false, home: Home()),
  );
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

int i = 6;

class _HomeState extends State<Home> {
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  String s1, s2;
  Map<int, List<String>> options = {
    0: ['\₹1200', 'Shoes'],
    1: ['\₹500', 'Groceries'],
    2: ['\₹2000', 'Travel'],
    3: ['\₹1000', 'Books'],
    4: ['\₹350', 'Movie'],
    5: ['\₹200', 'Snacks'],
  };

  Widget items(String str1, String str2) {
    return Card(
      margin: EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: <Widget>[
            Text(
              str1,
              style: TextStyle(
                fontSize: 28.0,
                color: Colors.red[300],
              ),
            ),
            SizedBox(width: 50),
            Text(
              str2,
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.purple[600],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // SingleChildScrollView()
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                margin: EdgeInsets.fromLTRB(16.0, 0.0, 0.0, 0.0),
                child: Text('My expenses',
                    style: TextStyle(
                      fontSize: 18.0,
                    )),
              ),
            ),
            for (int i = 0; i < options.length; i++)
              items(options[i][0], options[i][1]),
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
                      options[i] = ['₹' + s1, s2];
                      i++;
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
                if (s1.isNotEmpty && s2.isNotEmpty) {
                  setState(() {
                    options[i] = ['₹' + s1, s2];
                    i++;
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
    // This trailing comma makes auto-formatting nicer for build methods.
  }
}
