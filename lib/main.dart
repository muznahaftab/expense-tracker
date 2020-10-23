import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: Home()));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

int i = 7;

class _HomeState extends State<Home> {
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  // @override
  // void dispose() {
  //   // Clean up the controller when the widget is disposed.
  //   myController.dispose();
  //   super.dispose();
  // }
  String s1, s2;
  Map<int, List<String>> options = {
    0: ['\₹30', 'Shoes'],
    1: ['\₹20', 'Groceries'],
    2: ['\₹20', 'Travel'],
    3: ['\₹15', 'Bag'],
    4: ['\₹12', 'Books'],
    5: ['\₹6', 'Movie'],
    6: ['\₹5', 'Snacks'],
  };

  Widget items(String str1, String str2) {
    return Card(
      margin: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: <Widget>[
            Text(str1,
                style: TextStyle(
                  fontSize: 28.0,
                  color: Colors.red[300],
                )),
            SizedBox(width: 50),
            Text(str2,
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.purple[600],
                )),
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
                margin: EdgeInsets.fromLTRB(16.0, 32.0, 16.0, 16.0),
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
                },
              ),
            ),
            RaisedButton(
              textColor: Colors.white,
              color: Colors.blue,
              child: Text('Add'),
              onPressed: () {
                options[i] = ['₹' + s1, s2];
                i++;
                setState(() {});
                nameController.clear();
                priceController.clear();
              },
            ),
          ],
        ),
      ),
    );
    // This trailing comma makes auto-formatting nicer for build methods.
  }
}
