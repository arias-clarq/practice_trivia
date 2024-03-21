class Trivia{
  final String question;
  final String correctAnswer;
  final String incorrectAnswer;
  final String category;

  Trivia({
    required this.question,
    required this.correctAnswer,
    required this.incorrectAnswer,
    required this.category
  });

  factory Trivia.fromJson(Map<String, dynamic> json){
    return Trivia(
        question: json['results'][0]['question'],
        correctAnswer: json['results'][0]['correct_answer'],
        incorrectAnswer: json['results'][0]['incorrect_answers'][0],
        category: json['results'][0]['category']
    );
  }
}