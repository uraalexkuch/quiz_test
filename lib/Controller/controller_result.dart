import 'package:get/get.dart';

class ResultController extends GetxController {
  final resultScore = Get.arguments;

  @override
  void onInit() {
    super.onInit();
  }

  percent() {
    double percent = resultScore / 5 * 100;

    return percent;
  }

  resultPhrase() {
    String resultText;
    //   final percent = resultScore / 5 * 100;
    if (percent() >= 60) {
      resultText = 'Поздравляем!\n Отличные знания!';
    } else {
      resultText = "Можете лучше....";
    }
    return resultText;
  }
}
