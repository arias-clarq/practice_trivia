import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'model/Trivia.dart';
import 'service/TriviaService.dart';
import 'package:html_unescape/html_unescape.dart';

class StartTrivia extends StatefulWidget{
  @override
  _StartTriviaState createState() => _StartTriviaState();

}

class _StartTriviaState extends State<StartTrivia> {
  final _triviaService = TriviaService();
  Trivia? _trivia;
  String? question;
  String? categoryTitle;

  Future<void> getTrivia(int category) async{
    try{
      final data = await _triviaService.getTrivia(category);
      setState(() {
        _trivia = data;
        question = HtmlUnescape().convert(_trivia!.question);
        categoryTitle = HtmlUnescape().convert(_trivia!.category);
        print('Question: ${_trivia?.question}');
        print('Correct: ${_trivia?.correctAnswer}');
        print('InCorrect: ${_trivia?.incorrectAnswer}');
        print('Category: ${_trivia?.category}');
      });
    }catch(e){
      print(e);
    }

  }

  @override
  void initState() {
    getTrivia(28);
    super.initState();
  }

  void _showAnswer(bool isCorrect){
    showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: Text('Result'),
            content: Text(
              isCorrect ? 'your answer is correct' : 'your answers is incorrect'
            ),
            actions: <Widget>[
              TextButton(onPressed: (){
                getTrivia(28);
                Navigator.of(context).pop();
              }, child: Text('Retry'))
            ],
          );
        });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF2C2c2c),
      appBar: AppBar(
        backgroundColor: Color(0xff8eaccd),
        centerTitle: true,
        title: Text(categoryTitle ?? 'TriviaTime', style: TextStyle(color: Colors.white),),
      ),
      body: Column(
          // mainAxisAlignment : MainAxisAlignment.center,
        children: [
          Container(
            height: 50,
            width: double.maxFinite,
            margin: EdgeInsets.all(20),
            padding: EdgeInsets.all(10),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color(0xfff9cccc),
            ),

            child: Text('Select Category', style: TextStyle(color: Colors.black54),),
          ),
          Container(
            margin: EdgeInsets.all(20),
            padding: EdgeInsets.all(20),
            height: 200,
            width: double.maxFinite,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Color(0xFFD7E5CA),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(question ?? 'loading...'),
          ),
          SizedBox(
            height: 5,
          ),
          Container(
              height: 50,
              width: double.maxFinite,
            margin: EdgeInsets.symmetric(horizontal: 20),
              padding: EdgeInsets.all(10),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color(0xffF9F3CC),
              ),

              child: ElevatedButton(
                onPressed: (){
                bool isCorrect = _trivia?.correctAnswer.toLowerCase() == 'true';
                _showAnswer(isCorrect);
                },
                child: Text('True'),
              ),
            ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 50,
            width: double.maxFinite,
            margin: EdgeInsets.symmetric(horizontal: 20),
            padding: EdgeInsets.all(10),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color(0xffd2e0fb),
            ),

            child: ElevatedButton(
              onPressed: (){
                bool isCorrect = _trivia?.correctAnswer.toLowerCase() == 'false';
                _showAnswer(isCorrect);
              },
              child: Text('False'),
            ),
          ),

        ],
      ),
    );
  }
}