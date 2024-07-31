import 'package:auth_user/quiz/questions.dart';
import 'package:flutter/material.dart';

class QuizScreen extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  late QuizController _quizController;

  @override
  void initState() {
    super.initState();
    _quizController = QuizController();
    _quizController.startTimer(_updateTime, _onTimeOut);
  }

  void _updateTime() {
    setState(() {});
  }

  void _onTimeOut() {
    if (_quizController.currentQuestionIndex <
        _quizController.questions.length - 1) {
      setState(() {
        _quizController.nextQuestion();
        _quizController.startTimer(_updateTime, _onTimeOut);
      });
    } else {
      _endQuiz();
    }
  }

  void _endQuiz() {
    setState(() {
      _quizController.stopTimer();
    });
    _showResultDialog();
  }

  void _showResultDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Quiz Finished'),
        content: Text(
            'Your score: ${_quizController.score}/${_quizController.questions.length}'),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                _quizController.resetQuiz();
                _quizController.startTimer(_updateTime, _onTimeOut);
              });
              Navigator.of(context).pop();
            },
            child: Text('Restart'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _quizController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz App'),
      ),
      body: _quizController.currentQuestionIndex <
              _quizController.questions.length
          ? Padding(
              padding: EdgeInsets.all(width * 0.2),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Time left: ${_quizController.timeLeft}',
                    style: const TextStyle(fontSize: 24),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    _quizController
                        .questions[_quizController.currentQuestionIndex]
                        .questionText,
                    style: const TextStyle(fontSize: 24),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  ..._quizController
                      .questions[_quizController.currentQuestionIndex].answers
                      .map((answer) {
                    return ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _quizController.answerQuestion(answer);
                          if (_quizController.currentQuestionIndex <
                              _quizController.questions.length) {
                            _quizController.startTimer(_updateTime, _onTimeOut);
                          }
                        });
                      },
                      child: Text(answer),
                    );
                  })
                ],
              ),
            )
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Quiz Completed!',
                    style: TextStyle(fontSize: 24),
                  ),
                  Text(
                    'Your score: ${_quizController.score}/${_quizController.questions.length}',
                    style: const TextStyle(fontSize: 24),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _quizController.resetQuiz();
                        _quizController.startTimer(_updateTime, _onTimeOut);
                      });
                    },
                    child: const Text('Restart'),
                  ),
                ],
              ),
            ),
    );
  }
}
