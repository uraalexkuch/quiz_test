import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:quiz_test/Models/word.dart';
import 'package:quiz_test/Models/word.dart';
import 'package:quiz_test/Models/word.dart';
import 'package:quiz_test/Models/word.dart';
import "dart:math";
import 'package:quiz_test/Services/word_dao.dart';
import 'package:sembast/sembast.dart';

enum colorType {
  start,
  correct,
  notcorrect,
}

class ChoiceController extends GetxController
    with SingleGetTickerProviderMixin {
  late AnimationController _animationController;
  late Animation _animation;
  Animation get animation => this._animation;
  final value = Get.arguments;
  List wordsSelect = [].obs;
  List wordsSelectAll = [].obs;
  List words = [];
  List valueChoice = [];
  RxBool c = false.obs;
  int i = 0;
  int wrongCalc = 0;
  RxString wordMain = ''.obs;
  dynamic wordList;
  HexColor ColorSide = HexColor('#FFFFFF');
  dynamic a = colorType.start;
  RxBool isLoading = false.obs;
  int correctAns = 0;
  final WordsDao _wordsDao = WordsDao();

  @override
  void onInit() {
    ColorSide = HexColor('#FFFFFF');
    words = value[1];
    valueChoice = value[0];
    shefWord(c);
    getAnswerForRandom(wordList);
    _animationController = AnimationController(
      duration: Duration(seconds: 60),
      vsync: this,
    );

    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController)
      ..addListener(() {
        // update like setState
        update();
      });
    super.onInit();
  }

  @override
  void onClose() {
    _animationController.dispose();

    super.onClose();
  }

  shefWord(c) {
    if (c == false) {
      valueChoice[0];
    } else if (c == true) {
      if (i < valueChoice.length) {
        i++;
      }
    }
    if (i == 5) {
      return Timer(Duration(milliseconds: 300), () {
        Get.toNamed('/Home/result', arguments: correctAns);
        print("wait2");
      });
    }
    wrongCalc = 0;
    wordMain.value = valueChoice[i].content;
    wordList = valueChoice[i];
    return wordList;
  }

  getAnswerForRandom(wordList) async {
    print(wordList.content);
    words.forEach((item) {
      if (item != wordList) {
        if (wordsSelect.length < 3) {
          wordsSelect.add(item);
        }
      }
    });

    wordsSelectAll = [
      ...[wordList],
      ...wordsSelect
    ];

    wordsSelectAll;

    wordsSelectAll.shuffle();
  }

  answers(wordsSelectAll) {
    final answer = wordsSelectAll;
    if (answer == valueChoice[i]) {
      correctAns = correctAns + 1;
      print("yes");
      isLoading.value = true;
      choiceBorder(isLoading);
      c.value = true;
      final wordUpdate = answer;
      updateWordsCorrect(wordUpdate);
      Timer(Duration(milliseconds: 300), () {
        shefWord(c);
        getAnswerForRandom(wordList);
      });
    } else {
      print("wrong");

      choiceBorder(isLoading);
      if (wrongCalc == 0) {
        isLoading.value = false;
        choiceBorder(isLoading);
        showDialog();
        wrongCalc = wrongCalc + 1;
      } else {
        final wordUpdate = answer;
        updateWordsNotorrect(wordUpdate);
        Timer(Duration(milliseconds: 300), () {
          c.value = true;
          shefWord(c);
          getAnswerForRandom(wordList);
        });
      }
    }
  }

  choiceBorder(isLoading) {
    ColorSide = isLoading.value ? HexColor('#228B22') : HexColor('#FF0000');
  }

  zvet(colorType a) => {
        a == null
            ? HexColor('#FF0000')
            : a == colorType.correct
                ? HexColor('#228B22')
                : a == colorType.notcorrect
                    ? HexColor('#228B22')
                    : HexColor('#FF0000'),

        /* switch (a) {
          case colorType.start:
            HexColor('#FF0000');
            print(HexColor('#FF0000'));
            break;

          case colorType.correct:
            HexColor('#228B22');
            print(HexColor('#228B22'));
            break;
          case colorType.notcorrect:
            HexColor('#FF0000');
            print("3");
            break;

          default:
            HexColor('#FF0000');
            break;
        }*/
      };

  void showDialog() async {
    await Get.dialog(AlertDialog(
      title: Text('Внимание!',
          style: TextStyle(
              color: Colors.red, fontSize: 16, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center),
      content: Text('Еще одна попытка)))'),
      actions: [
        TextButton(
            onPressed: () => Get.back(), // Close the dialog
            child: Text('Закрыть'))
      ],
    ));
  }

  deleteWords(wordUpdate) async {
    await _wordsDao.delete(wordUpdate);
    _wordsDao.getAllSortedByContent();
    print("таки удалилось((");
  } // на будущее))

  addWords() async {
    final wordFin = Words(
      correct: true,
      notcorrect: false,
      img: 'covers/cloud-functions.png',
      status: true,
      content: 'home2',
    );
    await _wordsDao.insert(wordFin);
    _wordsDao.getAllSortedByContent();
    print("таки  добавилось))");
  } // на будущее))

  updateWordsCorrect(wordUpdate) async {
    final newWord = Words(
      correct: true,
      notcorrect: false,
      img: wordUpdate.img,
      status: true,
      content: wordUpdate.content,
    );
    newWord.id = wordUpdate.id;
    await _wordsDao.update(newWord);
    _wordsDao.getAllSortedByContent();
    print("обновилось");
  }

  updateWordsNotorrect(wordUpdate) async {
    final newWord = Words(
      correct: false,
      notcorrect: true,
      img: wordUpdate.img,
      status: true,
      content: wordUpdate.content,
    );
    newWord.id = wordUpdate.id;
    await _wordsDao.update(newWord);
    _wordsDao.getAllSortedByContent();
    print("обновилось");
  }
}
