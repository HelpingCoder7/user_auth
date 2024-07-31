import 'dart:async';

class Question {
  final String questionText;
  final List<String> answers;
  final String correctAnswer;

  Question(
      {required this.questionText,
      required this.answers,
      required this.correctAnswer});
}

class QuizController {
  final List<Question> _questions = [
    Question(
      questionText: 'In which year were the first modern Olympic Games held?',
      answers: ['1896', '1900', '1912', '1920'],
      correctAnswer: '1896',
    ),
    Question(
      questionText: 'Which city hosted the 2012 Summer Olympics?',
      answers: ['Beijing', 'London', 'Rio de Janeiro', 'Tokyo'],
      correctAnswer: 'London',
    ),
    Question(
      questionText: 'Which country has won the most Olympic gold medals?',
      answers: ['United States', 'China', 'Russia', 'Germany'],
      correctAnswer: 'United States',
    ),
    Question(
      questionText: 'Who is the most decorated Olympian of all time?',
      answers: [
        'Usain Bolt',
        'Michael Phelps',
        'Larisa Latynina',
        'Carl Lewis'
      ],
      correctAnswer: 'Michael Phelps',
    ),
    Question(
      questionText:
          'In which sport did Nadia Comăneci score a perfect 10 in the Olympics?',
      answers: [
        'Diving',
        'Gymnastics',
        'Figure Skating',
        'Synchronized Swimming'
      ],
      correctAnswer: 'Gymnastics',
    ),
    Question(
      questionText: 'Which city will host the 2024 Summer Olympics?',
      answers: ['Los Angeles', 'Paris', 'Rome', 'Tokyo'],
      correctAnswer: 'Paris',
    ),
    Question(
      questionText: 'What is the Olympic motto?',
      answers: [
        'Faster, Higher, Stronger',
        'Unity, Strength, Honor',
        'Sport for Peace',
        'Win at All Costs'
      ],
      correctAnswer: 'Faster, Higher, Stronger',
    ),
    Question(
      questionText: 'How many rings are there in the Olympic symbol?',
      answers: ['3', '4', '5', '6'],
      correctAnswer: '5',
    ),
    Question(
      questionText: 'Who was the first woman to win an Olympic gold medal?',
      answers: [
        'Nadia Comăneci',
        'Charlotte Cooper',
        'Mary Rand',
        'Mildred Didrikson'
      ],
      correctAnswer: 'Charlotte Cooper',
    ),
    Question(
      questionText: 'Which country hosted the 2016 Summer Olympics?',
      answers: ['Brazil', 'China', 'Japan', 'Greece'],
      correctAnswer: 'Brazil',
    ),
  ];

  int _currentQuestionIndex = 0;
  int _score = 0;
  int _timeLeft = 10;
  Timer? _timer;

  List<Question> get questions => _questions;
  int get currentQuestionIndex => _currentQuestionIndex;
  int get score => _score;
  int get timeLeft => _timeLeft;

  void startTimer(Function onTimerUpdate, Function onTimeOut) {
    _timeLeft = 10;
    _timer?.cancel();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      _timeLeft--;
      onTimerUpdate();
      if (_timeLeft == 0) {
        nextQuestion();
        onTimeOut();
      }
    });
  }

  void stopTimer() {
    _timer?.cancel();
  }

  void nextQuestion() {
    if (_currentQuestionIndex < _questions.length - 1) {
      _currentQuestionIndex++;
    } else {
      stopTimer();
    }
  }

  void answerQuestion(String selectedAnswer) {
    if (_questions[_currentQuestionIndex].correctAnswer == selectedAnswer) {
      _score++;
    }
    nextQuestion();
  }

  void resetQuiz() {
    _currentQuestionIndex = 0;
    _score = 0;
    _timeLeft = 10;
    stopTimer();
  }

  void dispose() {
    stopTimer();
  }
}
