import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:quiz_test/Controller/controller_result.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class Result extends StatelessWidget {
  ResultController controller = ResultController();

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
                title: Center(child: Text('Результат')),
              ),
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Center(
                      child: Text("${controller.resultPhrase()}",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 22.sp,
                          ),
                          textAlign: TextAlign.center),
                    ),
                    SizedBox(height: 10.h),
                    Center(
                      child: Text("Ваша результативность:",
                          style: TextStyle(
                            color: Colors.indigo,
                            fontWeight: FontWeight.bold,
                            fontSize: 20.sp,
                          ),
                          textAlign: TextAlign.center),
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      "${controller.percent()} % ",
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                        fontSize: 10.h,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    RaisedButton(
                      elevation: 10.0.sp,
                      onPressed: () {
                        Get.offNamed('/Home');
                      },
                      child: Text('Начать заново',
                          style: TextStyle(
                              color: HexColor('#FFFFFF'),
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center),
                      padding: const EdgeInsets.all(15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(35.0)),
                      ),
                      color: HexColor("#005BAA"),
                      focusColor: HexColor('#FFD947'),
                      splashColor: HexColor('#FFD947'),
                    ),
                  ],
                ),
              )));
    });
  }
}
