import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz/controller/quiz_controller.dart';
import 'package:quiz/models/question_model.dart';
import 'package:quiz/widgets/answer_options.dart';

class QuestionCard extends StatelessWidget {
  final QuestionModel questionModel;

  const QuestionCard({
    Key? key,
    required this.questionModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 300,
        margin: const EdgeInsets.symmetric(horizontal: 5.0),
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(25.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                questionModel.question,
                style: Theme.of(context).textTheme.headline6,
              ),
              //const SizedBox(height: 15),
              const Spacer(
                flex: 1,
              ),
              ...List.generate(
                  questionModel.options.length,
                  (index) => Column(
                        children: [
                          AnswerOptions(
                              questionsId: questionModel.id,
                              text: questionModel.options[index],
                              index: index,
                              onPressed: () => Get.find<QuizController>()
                                  .checkAnswer(questionModel, index)),
                          const SizedBox(
                            height: 5,
                          )
                        ],
                      )),
              const Spacer(
                flex: 2,
              ),
            ],
          ),
        ));
  }
}
