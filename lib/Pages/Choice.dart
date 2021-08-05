import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:quiz_test/Controller/controller_choice.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class Choice extends StatelessWidget {
  ChoiceController controller = ChoiceController();

  @override
  Widget build(BuildContext context) {
    controller.onInit();
    return ResponsiveSizer(
        builder: (context, orientation, deviceType) => Obx(() => SafeArea(
            left: true,
            top: true,
            right: true,
            bottom: true,
            child: Column(children: [
              Center(
                child: Container(
                    margin: EdgeInsets.only(top: 5.h, bottom: 5.h),
                    width: 30.w,
                    height: 20.w,
                    decoration: BoxDecoration(
                      color: HexColor("#DCDCDC"),
                    ),
                    child: Card(
                        child: Center(child: Text(controller.wordMain.value)))),
              ),
              Container(
                  height: 70.h,
                  child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 300,
                          childAspectRatio: 2 / 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10),
                      itemCount: 4,
                      itemBuilder: (BuildContext ctx, index) {
                        //final _isSelected = _selectedIndexs.contains(i);
                        return GestureDetector(
                            onTap: () {
                              controller
                                  .answers(controller.wordsSelectAll[index]);
                            },
                            child: Container(
                                height: 100.h,
                                child: Card(
                                    shape: RoundedRectangleBorder(
                                        side: BorderSide(
                                            color: controller.ColorSide,
                                            width: 5.sp),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(25.sp),
                                        )),
                                    elevation: 20.sp,
                                    child: Column(
                                      children: [
                                        Container(
                                            width: 100.w,
                                            height: 23.h,
                                            child: ClipRRect(
                                                borderRadius: BorderRadius.only(
                                                    topRight:
                                                        Radius.circular(25.sp),
                                                    topLeft:
                                                        Radius.circular(25.sp)),
                                                child: Image.asset(
                                                  controller
                                                      .wordsSelectAll[index]
                                                      .img,
                                                  fit: BoxFit.fill,
                                                ))),
                                        Container(
                                          width: 100.w,
                                          height: 5.h,
                                          child: Center(
                                            child: Text(controller
                                                .wordsSelectAll[index].content),
                                          ),
                                        ),
                                      ],
                                    ))));
                      }))
            ]))));
  }
}
