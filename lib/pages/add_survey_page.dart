import 'package:flutter/material.dart';
import '../survey.dart';
import '../database_helper.dart';

class AddSurveyPage extends StatefulWidget {
  @override
  _AddSurveyPageState createState() => _AddSurveyPageState();
}

class _AddSurveyPageState extends State<AddSurveyPage> {
  final _formKey = GlobalKey<FormState>();
  String name = '';
  int age = 0;
  String address = '';
  String description = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Tambah Survey')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Nama'),
                onChanged: (value) {
                  name = value;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Umur'),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  age = int.parse(value);
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Alamat'),
                onChanged: (value) {
                  address = value;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Deskripsi'),
                onChanged: (value) {
                  description = value;
                },
              ),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    Survey newSurvey = Survey(name: name, age: age, address: address, description: description);
                    await DatabaseHelper().insertSurvey(newSurvey);
                    Navigator.pop(context);
                  }
                },
                child: Text('Simpan'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
