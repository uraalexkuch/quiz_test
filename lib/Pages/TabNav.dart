import 'package:flutter/material.dart';
import 'package:quiz_test/Pages/Choice.dart';
import 'package:google_fonts/google_fonts.dart';

class TabNav extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.headphones_outlined)),
                Tab(icon: Icon(Icons.description_outlined)),
                Tab(icon: Icon(Icons.edit_outlined)),
                Tab(icon: Icon(Icons.mic_none_outlined)),
              ],
            ),
            title: Center(child: Text('Найди слово')),
          ),
          body: TabBarView(
            children: [
              Choice(),
              Choice(),
              Choice(),
              Choice(),
            ],
          ),
        ));
  }
}
