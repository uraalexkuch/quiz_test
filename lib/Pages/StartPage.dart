import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:quiz_test/Controller/controller_load.dart';

import 'package:responsive_sizer/responsive_sizer.dart';

class StartPage extends StatelessWidget {
  LoadController controller = LoadController();
  @override
  Widget build(BuildContext context) {
    controller.onInit();
    return ResponsiveSizer(builder: (context, orientation, deviceType) {
      return SafeArea(
          left: true,
          top: true,
          right: true,
          bottom: true,
          child: Scaffold(
              appBar: AppBar(
                title: Center(child: Text('Словарь')),
              ),
              body: Obx(() => !controller.isLoading.value
                  ? Column(
                      children: [
                        Container(
                          height: 70.h,
                          decoration: BoxDecoration(
                            color: HexColor("#DCDCDC"),
                          ),
                          child: ListView.builder(
                              itemCount: controller.words.length,
                              itemBuilder: (context, index) {
                                final displayedwords = controller.words[index];
                                return Card(
                                    color: !displayedwords.status
                                        ? HexColor("#FFFFFF")
                                        : displayedwords.correct
                                            ? HexColor("#228B22")
                                            : HexColor("#FF0000"),
                                    child: ListTile(
                                        title: Text(displayedwords.content),
                                        subtitle: Text(displayedwords.content),
                                        leading: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                              width: 20.w,
                                              height: 15.h,
                                              child: Image.asset(
                                                  displayedwords.img)),
                                        ),
                                        trailing: Icon(Icons.volume_up_sharp)));
                              }),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            margin: const EdgeInsets.only(top: 20.0),
                            width: 100.w,
                            child: RaisedButton(
                              elevation: 10.0,
                              onPressed: () {
                                controller.selectWords();
                              },
                              child: Text('Начать урок',
                                  style: TextStyle(
                                      color: HexColor('#FFFFFF'),
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center),
                              padding: const EdgeInsets.all(15),
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(35.0)),
                              ),
                              color: HexColor("#005BAA"),
                              focusColor: HexColor('#FFD947'),
                              splashColor: HexColor('#FFD947'),
                            ),
                          ),
                        )
                      ],
                    )
                  : Center(child: CircularProgressIndicator.adaptive()))));
    });
  }
}
