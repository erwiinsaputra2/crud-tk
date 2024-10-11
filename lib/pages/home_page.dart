import 'package:flutter/material.dart';
import '../database_helper.dart';
import '../survey.dart';
import 'add_survey_page.dart';
import 'survey_detail_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Survey> surveys = [];

  @override
  void initState() {
    super.initState();
    _loadSurveys();
  }

  void _loadSurveys() async {
    final data = await DatabaseHelper().getSurveys();
    setState(() {
      surveys = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Daftar Survey')),
      body: ListView.builder(
        itemCount: surveys.length,
        itemBuilder: (context, index) {
          final survey = surveys[index];
          return ListTile(
            title: Text(survey.name),
            subtitle: Text(survey.address),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SurveyDetailPage(survey: survey)),
              ).then((_) => _loadSurveys());
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddSurveyPage()),
          ).then((_) => _loadSurveys());
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
