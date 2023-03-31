class QuestionModel {
  final String question;
  final List<String> answers;
  String comments;
  String? selectedAnswer;

  QuestionModel({required this.answers, required this.comments, required this.question,this.selectedAnswer});
}
