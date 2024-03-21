import 'dart:convert';

import '../model/Trivia.dart';
import 'package:http/http.dart' as http;
class TriviaService{
  static const API_URL = 'https://opentdb.com/api.php?amount=1&type=boolean';

  Future<Trivia> getTrivia(int category) async{
    final response = await http.get(
        Uri.parse('$API_URL?amount=1&category=$category&type=boolean')
    );

    if(response.statusCode == 200){
      return Trivia.fromJson(jsonDecode(response.body));
    }else{
      throw Exception('Failed to load data');
    }
  }
}