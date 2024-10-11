import 'package:flutter/material.dart';
import '../survey.dart';
import '../database_helper.dart';

class SurveyDetailPage extends StatefulWidget {
  final Survey survey;
  SurveyDetailPage({required this.survey});

  @override
  _SurveyDetailPageState createState() => _SurveyDetailPageState();
}

class _SurveyDetailPageState extends State<SurveyDetailPage> {
  final _formKey = GlobalKey<FormState>();
  late String name;
  late int age;
  late String address;
  late String description;

  @override
  void initState() {
    super.initState();
    name = widget.survey.name;
    age = widget.survey.age;
    address = widget.survey.address;
    description = widget.survey.description;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Survey'),
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () async {
              await DatabaseHelper().deleteSurvey(widget.survey.id!);
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: name,
                decoration: InputDecoration(labelText: 'Nama'),
                onChanged: (value) {
                  name = value;
                },
              ),
              TextFormField(
                initialValue: age.toString(),
                decoration: InputDecoration(labelText: 'Umur'),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  age = int.parse(value);
                },
              ),
              TextFormField(
                initialValue: address,
                decoration: InputDecoration(labelText: 'Alamat'),
                onChanged: (value) {
                  address = value;
                },
              ),
              TextFormField(
                initialValue: description,
                decoration: InputDecoration(labelText: 'Deskripsi'),
                onChanged: (value) {
                  description = value;
                },
              ),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    Survey updatedSurvey = Survey(
                      id: widget.survey.id,
                      name: name,
                      age: age,
                      address: address,
                      description: description,
                    );
                    await DatabaseHelper().updateSurvey(updatedSurvey);
                    Navigator.pop(context);
                  }
                },
                child: Text('Simpan Perubahan'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
