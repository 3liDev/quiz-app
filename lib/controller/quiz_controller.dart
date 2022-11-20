import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz/models/question_model.dart';
import 'package:quiz/views/result_screen/result_screen.dart';
import 'package:quiz/views/welcome_screen.dart';

class QuizController extends GetxController {
  String name = "";

  final List<QuestionModel> _questionList = [
    QuestionModel(
      id: 1,
      question: "Best Channel for Flutter ",
      answer: 2,
      options: [
        'Sec it',
        'Sec it developer',
        'sec it developers',
        'mesh sec it '
      ],
    ),
    QuestionModel(
      id: 2,
      question: "Best State Mangment Ststem is ",
      answer: 1,
      options: ['BloC', 'GetX', 'Provider', 'riverPod'],
    ),
    QuestionModel(
      id: 3,
      question: "Best Flutter dev",
      answer: 2,
      options: ['sherif', 'sherif ahmed', 'ahmed sherif', 'doc sherif'],
    ),
    QuestionModel(
      id: 4,
      question: "Ali is",
      answer: 2,
      options: ['all', 'Doc', 'eng', 'Doc/Eng'],
    ),
    QuestionModel(
      id: 5,
      question: "Best phone in Syria",
      answer: 2,
      options: ['Sony', 'LG', 'Nokia', 'All of the above'],
    ),
    QuestionModel(
      id: 6,
      question: "short Name of Joher",
      answer: 1,
      options: ['ahmed ali', 'jhr', 'Haytham', 'NONE OF ABOVE'],
    ),
    QuestionModel(
      id: 7,
      question: "Ali love",
      answer: 3,
      options: ['Pharma', 'Micro', 'Medicnal', 'NONE OF ABOVE'],
    ),
    QuestionModel(
      id: 8,
      question: "hello",
      answer: 0,
      options: ['hello', 'hi', 'hola', 'Suiiiiiiiiiiii'],
    ),
    QuestionModel(
      id: 9,
      question: "Best Channel for Flutter ",
      answer: 3,
      options: [
        'flutter',
        'Flutter developer',
        'Dart developers',
        'NONE OF ABOVE '
      ],
    ),
    QuestionModel(
      id: 10,
      question: "Best State Mangment Ststem is ",
      answer: 1,
      options: ['BloC', 'GetX', 'Provider', 'riverPod'],
    ),
  ];

  bool _isPressed = false;
  double _numberOfQuestion = 1;
  int? _selectedAnswer;
  int _countOfCorrectAnswer = 0;
  final RxInt _second = 15.obs;

  int get countOfQuestion => _questionList.length;
  List<QuestionModel> get questionList => [..._questionList];
  bool get isPressed => _isPressed;
  double get numberOfQuestion => _numberOfQuestion;
  int? get selectedAnswer => _selectedAnswer;
  int get countOfCorrectAnswer => _countOfCorrectAnswer;
  RxInt get second => _second;

  int? _correctAnswer;
  final Map<int, bool> _questionIsAnswer = {};
  Timer? _timer;
  final maxSecond = 15;

  late PageController pageController;

  @override
  void onInit() {
    pageController = PageController(initialPage: 0);
    resetAnswer();
    super.onInit();
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }

  double get scoreResult {
    return countOfCorrectAnswer * 100 / _questionList.length;
  }

  void checkAnswer(QuestionModel questionModel, int selectedAnswer) {
    _isPressed = true;
    _selectedAnswer = selectedAnswer;
    _correctAnswer = questionModel.answer;
    if (_correctAnswer == _selectedAnswer) {
      _countOfCorrectAnswer++;
    }
    stopTimer();
    _questionIsAnswer.update(questionModel.id, (value) => true);
    Future.delayed(const Duration(microseconds: 500))
        .then((value) => nextQuestion());

    update();
  }

  bool checkIsQuestionAnswer(int questionId) {
    return _questionIsAnswer.entries
        .firstWhere((element) => element.key == questionId)
        .value;
  }

  void resetAnswer() {
    for (var element in _questionList) {
      _questionIsAnswer.addAll({element.id: false});
    }
    update();
  }

  Color getColor(int answerIndex) {
    if (_isPressed) {
      if (answerIndex == _correctAnswer) {
        return Colors.green;
      } else if (answerIndex == _selectedAnswer &&
          _correctAnswer != _selectedAnswer) {
        return Colors.red;
      }
    }

    return Colors.white;
  }

  IconData getIcon(int answerIndex) {
    if (_isPressed) {
      if (answerIndex == _correctAnswer) {
        return Icons.done;
      } else if (answerIndex == _selectedAnswer &&
          _correctAnswer != _selectedAnswer) {
        return Icons.close;
      }
    }

    return Icons.close;
  }

  nextQuestion() {
    if (_timer != null || _timer!.isActive) {
      stopTimer();
    }
    if (pageController.page == _questionList.length - 1) {
      Get.offAndToNamed(ResultScreen.routeName);
    } else {
      _isPressed = false;
      pageController.nextPage(
          duration: const Duration(milliseconds: 500), curve: Curves.linear);
      startTimer();
    }

    _numberOfQuestion = pageController.page! + 2;
    update();
  }

  void startTimer() {
    resetTimer();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_second.value > 0) {
        _second.value--;
      } else {
        stopTimer();
        nextQuestion();
      }
    });
  }

  void startAgain() {
    _correctAnswer = null;
    _countOfCorrectAnswer = 0;
    _selectedAnswer = null;
    resetAnswer();
    Get.offAllNamed(WelcomeScreen.routeName);
  }

  void stopTimer() => _timer!.cancel();
  void resetTimer() => _second.value = maxSecond;
}
