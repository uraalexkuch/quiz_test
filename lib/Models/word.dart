import 'dart:math';

import 'package:flutter/material.dart';

class Words {
  int id = 0;

  final String? img;
  final String? content;
  final dynamic status;
  final dynamic correct;
  final dynamic notcorrect;

  Words({this.img, this.content, this.status, this.correct, this.notcorrect});

  Map<String, dynamic> toMap() {
    return {
      'img': img,
      'content': content,
      'status': status,
      'correct': correct,
      'notcorrect': notcorrect
    };
  }

  static Words fromMap(Map<String, dynamic> map) {
    return Words(
        img: map['img'],
        content: map['content'],
        status: map['status'],
        correct: map['correct'],
        notcorrect: map['notcorrect']);
  }
}
