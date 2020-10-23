import 'package:flutter/material.dart';

class FormScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return FormScreenState();    
  }
}

class FormScreenState extends State<FormScreen> {
  // initialize the variables
  String _name;
  bool _ownsCar = false;
  int _carAge;
  String _summary = 'Summary goes here';

  // initialize form key, used for states etc.
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // initialize Widgets for widget tree
  Widget _buildName(){
    return TextFormField(
      decoration: InputDecoration(labelText: 'Name'),
      validator: (String value){
        if(value.isEmpty){
          return 'Name is Required';
        }
      },
      onSaved: (String value){
        _name = value;
      },
    );
  }
  
  Widget _buildOwnsCar(){ 
    return Checkbox(
      value: _ownsCar, 
      onChanged: (bool value) {
        setState(() {
          _ownsCar = value;
        });
      }
    );
  }
  
  Widget _buildCarAge(){
    if(_ownsCar){
      return TextFormField(
        decoration: InputDecoration(labelText: 'Age of Car'),
        keyboardType: TextInputType.number,
        validator: (String value){
          if(value.isEmpty ) {
            return 'Car age is Required';
          }

          if(int.tryParse(value) > 10 || int.tryParse(value) <= 0){
            return 'Car age needs to be more than 0 and less than 10';
          }

          if(!RegExp(
            r"^[0-9]*$")
            .hasMatch(value)){
              return 'Please enter a valid age';
            }
        },
        onSaved: (String value){
          _carAge = int.tryParse(value);
        },
      );
    }
    else{
      return Text("You don't have a car");
    }
   
  }

  Widget _buildSummary(){
    return Text(_summary);
  }
  
  // build the widget tree
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Task 6')),
      body: Container(
        margin: EdgeInsets.all(24),
        child: Form(
          key: _formKey,                                // remember to initialize the key!
          child: Column(
          mainAxisAlignment: MainAxisAlignment.center,  // make everything centered
          children: <Widget>[
            _buildName(),
            Text('Do you own a car?'),
            _buildOwnsCar(),
            _buildCarAge(),

            // RaisedButton has the functionality from the submit
            RaisedButton(
              child: Text(
                'Submit', 
                style: TextStyle(color: Colors.blue, fontSize: 16)
                ),
              onPressed: () { // when submit is pressed
                // this validates everything according to their settings 
                if(!_formKey.currentState.validate()){
                  return;
                }
                // activates "onSaved" method in functions
                _formKey.currentState.save();
                
                // print values to the user - this doesn't work correctly as it does
                if(_ownsCar){
                  setState(() {
                    _summary = "Your name is: " + _name + " And your car's age is: " + _carAge.toString();
                  });
                }
                else{
                  setState(() {
                    _summary = "Your name is: " + _name + " And you don't have a car";
                  });
                }
              },
            ),
            SizedBox(height: 50),
            _buildSummary()            
          ],
        )),
        ),
    ); 
  }
}