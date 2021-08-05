import 'package:get/get.dart';
import 'package:quiz_test/Services/word_dao.dart';

class LoadController extends GetxController {
  List words = [].obs;
  List wordsNew = [].obs;
  List wordstransfer = [];
  List wordstransfer1 = [];
  List wordstransfer2 = [];
  List wordstransferAll = [].obs;
  RxBool isLoading = true.obs;
  final WordsDao _wordsDao = WordsDao();
  // static LoadController get to => Get.find();
  @override
  void onInit() {
    fetchWords();

    super.onInit();
  }

  fetchWords() async {
    try {
      words = await _wordsDao.getAllSortedByContent();
    } finally {
      isLoading.value = false;
    }
  }

  selectWords() {
    words.forEach((item) {
      if (item.status == false) {
        if (wordstransfer.length < 5) {
          wordstransfer.add(item);
        }
        wordstransferAll = wordstransfer;
      }
    });
    if (wordstransferAll.length != 5) {
      words.forEach(((item) {
        if (item.notcorrect == true) {
          if (wordstransfer1.length < (5 - wordstransfer.length)) {
            wordstransfer1.add(item);
            // }
            wordstransferAll = [...wordstransfer, ...wordstransfer1];
          }
        }
      }));
    }

    if (wordstransferAll.length != 5) {
      words.forEach((item) {
        if (item.correct == true) {
          if (wordstransfer2.length <
              (5 - wordstransfer.length - wordstransfer1.length)) {
            wordstransfer2.add(item);
          }
        }
        ;
      });
    }

    wordstransferAll = [...wordstransfer, ...wordstransfer1, ...wordstransfer2];

    if (wordstransferAll.length == 5) {
      words.forEach((item) {
        for (int i = 0; i < wordstransferAll.length; i++)
          if (item != wordstransferAll[i]) {
            wordsNew.add(item);
          }
      });
    }

    print('итог без ${wordsNew.length}'); //итог
    print(
        'общий выбор ,если есть свободные ${wordstransfer.length}'); //общий выбор ,если есть свободные
    print(
        'выбор, если есть ошибочные ${wordstransfer1.length}'); // выбор, если есть ошибочные
    print(
        'выбор добавчный,с правильными ${wordstransfer2.length}'); // выбор добавчный,с правильными
    print('итог ${wordstransferAll.length}'); //итог
    Get.toNamed('/Home/choice', arguments: [wordstransferAll, words]);
  }
}
