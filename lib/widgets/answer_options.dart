import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz/controller/quiz_controller.dart';

class AnswerOptions extends StatelessWidget {
  final String text;
  final int index, questionsId;
  final Function() onPressed;

  const AnswerOptions(
      {Key? key,
      required this.text,
      required this.index,
      required this.questionsId,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<QuizController>(
        init: QuizController(),
        builder: (controller) => InkWell(
              onTap: controller.checkIsQuestionAnswer(questionsId)
                  ? null
                  : onPressed,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                        width: 3, color: controller.getColor(index))),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RichText(
                          text: TextSpan(
                              text: "${index + 1}.",
                              style: Theme.of(context).textTheme.headline6,
                              children: [
                            TextSpan(
                              text: text,
                              style: Theme.of(context).textTheme.headline6,
                            )
                          ])),
                      if (controller.checkIsQuestionAnswer(questionsId) &&
                          controller.selectedAnswer == index)
                        Container(
                          width: 15,
                          height: 15,
                          padding: EdgeInsets.zero,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: controller.getColor(index),
                              border: Border.all(color: Colors.white, width: 3),
                              shape: BoxShape.circle),
                          child: Icon(
                            controller.getIcon(index),
                            color: Colors.white,
                          ),
                        )
                    ],
                  ),
                ),
              ),
            ));
  }
}
