import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../auth.dart';
// CheckStatus

class CheckStatus extends StatefulWidget {
  const CheckStatus({ Key key }) : super(key: key);

  @override
  _CheckStatus createState() => _CheckStatus ();
}


class Status {
  int id;
  String status;

  Status(this.id, this.status);

  static List<Status> getStatus() {
    return<Status>[
      Status(1, 'Healthy'),
      Status(2, 'partically Sick (few symptoms showing)'),
      Status(4, 'Asymptomatic'),
      Status(5, 'Corona Infected'),
    ];
  }

}

class _CheckStatus extends State<CheckStatus> {
  
  List<Status> _status = Status.getStatus();
  List<DropdownMenuItem<Status>> _dropDownMenuItems;
  Status _selectedStatus;

  List<String> symptopmsList = [
  'The Most common symptoms are: ',
  '- fever', '- dry cough', '- tiredness',
  '',
  'Some of the less Common symptoms are: ',
  '- aches and pains', '- sore throat', '- diarrhoea',
  '',
  'Some of the serious symptoms are ',
  '- difficulty breathing or shortness of breath',
  '- chest pain or pressure',
  '- loss of speech or movement'];

  @override
  void initState() {
    _dropDownMenuItems = buildDropDownMenuItems(_status);
    _selectedStatus = _dropDownMenuItems[0].value;
    super.initState();
  }

  List <DropdownMenuItem<Status>> buildDropDownMenuItems(List status){
    List <DropdownMenuItem<Status>> items = List();
    for(Status _status in status){
      items.add(
        DropdownMenuItem(value: _status, child: Text(_status.status),
      ));
    }
    return items;
  }

  onChangedDropDownItem(Status selectedStatus){
    setState(() {
      _selectedStatus = selectedStatus;
    });
    authService.googleSignIn(); 
    authService.status = selectedStatus.status;
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: new Scaffold(
        body: new Container(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 50.0,),
                Text('Please select your status for corona'),
                SizedBox(height: 15.0), 
                DropdownButton(
                  value: _selectedStatus,
                  items: _dropDownMenuItems,
                  onChanged: onChangedDropDownItem,
                ),
                SizedBox(height: 15.0,),
                Text('Selected item: ${_selectedStatus.status}'),
                SizedBox(height: 10.0,),
                Divider(
                  color: Colors.yellow[400]
                ),
                SizedBox(height: 10.0,),
                for(String i in symptopmsList)
                 Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                    height: MediaQuery.of(context).size.height/23,
                    child: Text('     '+i),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}