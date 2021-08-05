import 'dart:async';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

class AppDatabase {
  // Singleton instance
  static final AppDatabase _singleton = AppDatabase._();

  // Singleton accessor
  static AppDatabase get instance => _singleton;

  // Completer is used for transforming synchronous code into asynchronous code.
  Completer<Database>? _dbOpenCompleter = null;

  // A private constructor. Allows us to create instances of AppDatabase
  // only from within the AppDatabase class itself.
  AppDatabase._();

  // Database object accessor
  Future<Database> get database async {
    // If completer is null, AppDatabaseClass is newly instantiated, so database is not yet opened
    if (_dbOpenCompleter == null) {
      _dbOpenCompleter = Completer();
      // Calling _openDatabase will also complete the completer with database instance
      _openDatabase();
    }
    // If the database is already opened, awaiting the future will happen instantly.
    // Otherwise, awaiting the returned future will take some time - until complete() is called
    // on the Completer in _openDatabase() below.
    return _dbOpenCompleter!.future;
  }

  Future _openDatabase() async {
    // Get a platform-specific directory where persistent app data can be stored
    final appDocumentDir = await getApplicationDocumentsDirectory();
    // Path with the form: /platform-specific-directory/demo.db
    final dbPath = join(appDocumentDir.path, 'word.db');
    final store = intMapStoreFactory.store('my_words');
    final database = await databaseFactoryIo.openDatabase(dbPath, version: 1,
        onVersionChanged: (db, oldVersion, newVersion) async {
      // If the db does not exist, create some data
      if (oldVersion == 0) {
        await store.add(db, {
          'img': 'covers/angular.png',
          'content': 'sun',
          'status': false,
          'correct': false,
          'notcorrect': false
        });
        await store.add(db, {
          'img': 'covers/angular.png',
          'content': 'house',
          'status': false,
          'correct': false,
          'notcorrect': false
        });
        await store.add(db, {
          'img': 'covers/cloud-functions.png',
          'content': 'home',
          'status': false,
          'correct': false,
          'notcorrect': false
        });
        await store.add(db, {
          'img': 'covers/firestore.png',
          'content': 'bird',
          'status': true,
          'correct': false,
          'notcorrect': true
        });
        await store.add(db, {
          'img': 'covers/flutter.png',
          'content': 'dog',
          'status': true,
          'correct': true,
          'notcorrect': false
        });
        await store.add(db, {
          'img': 'covers/flutter-layout.png',
          'content': 'cat',
          'status': true,
          'correct': true,
          'notcorrect': false
        });
        await store.add(db, {
          'img': 'covers/js.png',
          'content': 'mouse',
          'status': false,
          'correct': false,
          'notcorrect': false
        });
        await store.add(db, {
          'img': 'covers/angular.png',
          'content': 'moon',
          'status': true,
          'correct': false,
          'notcorrect': true
        });
        await store.add(db, {
          'img': 'covers/rxjs.png',
          'content': 'house',
          'status': true,
          'correct': false,
          'notcorrect': true
        });
        await store.add(db, {
          'img': 'covers/ts.png',
          'content': 'house1',
          'status': false,
          'correct': false,
          'notcorrect': false
        });
        await store.add(db, {
          'img': 'covers/angular.png',
          'content': 'house2',
          'status': false,
          'correct': false,
          'notcorrect': false
        });
        await store.add(db, {
          'img': 'covers/angular.png',
          'content': 'house3',
          'status': false,
          'correct': false,
          'notcorrect': false
        });
        await store.add(db, {
          'img': 'covers/angular.png',
          'content': 'house4',
          'status': true,
          'correct': false,
          'notcorrect': true
        });
        await store.add(db, {
          'img': 'covers/angular.png',
          'content': 'big',
          'status': true,
          'correct': false,
          'notcorrect': true
        });
        await store.add(db, {
          'img': 'covers/angular.png',
          'content': 'money',
          'status': true,
          'correct': false,
          'notcorrect': true
        });
        await store.add(db, {
          'img': 'covers/angular.png',
          'content': 'house5',
          'status': true,
          'correct': false,
          'notcorrect': true
        });
        /* await store.add(db, {
          'img': 'covers/angular.png',
          'content': 'child',
          'status': true,
          'correct': true,
          'notcorrect': false
        });
        await store.add(db, {
          'img': 'covers/angular.png',
          'content': 'mother',
          'status': true,
          'correct': true,
          'notcorrect': false
        });
        await store.add(db, {
          'img': 'covers/angular.png',
          'content': 'father',
          'status': true,
          'correct': false,
          'notcorrect': true
        });
        await store.add(db, {
          'img': 'covers/angular.png',
          'content': 'sky',
          'status': false,
          'correct': false,
          'notcorrect': false
        });
        await store.add(db, {
          'img': 'covers/angular.png',
          'content': 'daughter',
          'status': false,
          'correct': false,
          'notcorrect': false
        });
        await store.add(db, {
          'img': 'covers/angular.png',
          'content': 'peace',
          'status': false,
          'correct': false,
          'notcorrect': false
        });
        await store.add(db, {
          'img': 'covers/angular.png',
          'content': 'house',
          'status': false,
          'correct': false,
          'notcorrect': false
        });
        await store.add(db, {
          'img': 'covers/angular.png',
          'content': 'country',
          'status': false,
          'correct': false,
          'notcorrect': false
        });
        await store.add(db, {
          'img': 'covers/angular.png',
          'content': 'rain',
          'status': false,
          'correct': false,
          'notcorrect': false
        });
        await store.add(db, {
          'img': 'covers/angular.png',
          'content': 'airplane',
          'status': true,
          'correct': true,
          'notcorrect': false
        });
        await store.add(db, {
          'img': 'covers/angular.png',
          'content': 'a train',
          'status': true,
          'correct': false,
          'notcorrect': true
        });
        await store.add(db, {
          'img': 'covers/angular.png',
          'content': 'ship',
          'status': false,
          'correct': false,
          'notcorrect': false
        });
        await store.add(db, {
          'img': 'covers/angular.png',
          'content': 'car',
          'status': false,
          'correct': false,
          'notcorrect': false
        });
        await store.add(db, {
          'img': 'covers/angular.png',
          'content': 'horse',
          'status': false,
          'correct': false,
          'notcorrect': false
        });*/
      }
    });

    // Any code awaiting the Completer's future will now start executing
    _dbOpenCompleter!.complete(database);
  }
}
