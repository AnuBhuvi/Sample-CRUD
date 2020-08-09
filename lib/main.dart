import 'package:after_layout/after_layout.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tryagain/Services/databaseService.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/addMember': (_) => MyCustomForm(),
        '/memberData': (_) => FormData(),
      },
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            RaisedButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/addMember');
              },
              child: Text('Form'),
            ),
            RaisedButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/memberData');
              },
              child: Text('Form Data'),
            )
          ],
        ),
      ),
    );
  }
}

//create a Form Widget
class MyCustomForm extends StatefulWidget {
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

class MyCustomFormState extends State<MyCustomForm> {
  final _formkey = GlobalKey<FormState>();

  Map<String, dynamic> memberData = {
    'memtype': 'Basic',
  };

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Member Details')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formkey,
            child: Column(
              children: <Widget>[
                TextFormField(
                  onChanged: (val) {
                    setState(() {
                      memberData['name'] = val;
                    });
                  },
                  decoration: const InputDecoration(
                    icon: const Icon(Icons.account_box),
                    hintText: 'Enter your Name',
                    labelText: 'Name',
                  ),
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  onChanged: (val) {
                    setState(() {
                      memberData['age'] = val;
                    });
                  },
                  decoration: const InputDecoration(
                    icon: const Icon(Icons.view_agenda),
                    hintText: 'Enter your Age',
                    labelText: 'Age',
                  ),
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  onChanged: (val) {
                    setState(() {
                      memberData['phone'] = val;
                    });
                  },
                  decoration: const InputDecoration(
                    icon: const Icon(Icons.phone),
                    hintText: 'Enter your phone number',
                    labelText: 'Contact Number',
                  ),
                ),
                TextField(
                  onChanged: (val) {
                    setState(() {
                      memberData['mailid'] = val;
                    });
                  },
                  decoration: const InputDecoration(
                    icon: const Icon(Icons.email),
                    hintText: 'Enter the email id',
                    labelText: 'Email Id',
                  ),
                ),
                TextField(
                  onChanged: (val) {
                    setState(() {
                      memberData['location'] = val;
                    });
                  },
                  decoration: const InputDecoration(
                    icon: const Icon(Icons.add_location),
                    hintText: 'Enter the Location',
                    labelText: 'Place',
                  ),
                ),
                DropdownButton<String>(
                  value: memberData['memtype'],
                  icon: Icon(Icons.arrow_drop_down),
                  onChanged: (String val) {
                    setState(() {
                      memberData['memtype'] = val;
                    });
                  },
                  items: <String>[
                    'Basic',
                    'Premium',
                    'Silver',
                    'Platinum',
                    'Gold'
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                new Container(
                    //padding: const EdgeInsets.only(left: 150.0, top: 40.0),
                    child: new RaisedButton(
                  child: const Text('Submit'),
                  onPressed: () {
                    // print(memberData);
                    MemberCollection().addMember(memberData);
                  },
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class FormData extends StatefulWidget {
  @override
  _FormDataState createState() => _FormDataState();
}

class _FormDataState extends State<FormData> with AfterLayoutMixin {
  List<Widget> members = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: members,
      ),
    );
  }

  @override
  Future<void> afterFirstLayout(BuildContext context) async {
    List<DocumentSnapshot> ldss = await MemberCollection().getMembers();

    setState(() {
      members = ldss
          .map((e) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(e.data.toString()),
              ))
          .toList();
    });
  }
}

// class FormData extends StatefulWidget {
//   @override
//   _FormDataState createState() => _FormDataState();
// }

// class _FormDataState extends State<FormData> with AfterLayoutMixin {
//   List<Widget> members = [];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: StreamBuilder<List<DocumentSnapshot>>(
//           stream:
//               MemberCollection().getMembers()?.map((event) => event.documents),
//           builder: (context, snapshot) {
//             if (snapshot.data != null) {
//               print('Hello');
//               return ListView(
//                 children: snapshot.data
//                     .map((e) => Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Text(e.data.toString()),
//                         ))
//                     .toList(),
//               );
//             } else {
//               print('bye');
//               return Container();
//             }
//           }),
//     );
//   }

//   @override
//   Future<void> afterFirstLayout(BuildContext context) async {
//     MemberCollection().getMembers();

//     // setState(() {
//     //   members = ldss
//     //       .map((e) => Padding(
//     //             padding: const EdgeInsets.all(8.0),
//     //             child: Text(e.data.toString()),
//     //           ))
//     //       .toList();
//     // });
//   }
// }
