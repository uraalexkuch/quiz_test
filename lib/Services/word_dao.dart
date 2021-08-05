import 'package:quiz_test/Models/word.dart';
import 'package:sembast/sembast.dart';

import './app_database.dart';

class WordsDao {
  static const String WORD_STORE_NAME = 'words';
  // A Store with int keys and Map<String, dynamic> values.
  // This Store acts like a persistent map, values of which are User objects converted to Map
  final _wordStore = intMapStoreFactory.store('my_words');

  // Private getter to shorten the amount of code needed to get the
  // singleton instance of an opened database.
  Future<Database> get _db async => await AppDatabase.instance.database;

  Future insert(Words word) async {
    await _wordStore.add(await _db, word.toMap());
  }

  Future update(Words word) async {
    // For filtering by key (ID), RegEx, greater than, and many other criteria,
    // we use a Finder.
    final finder = Finder(filter: Filter.byKey(word.id));
    await _wordStore.update(
      await _db,
      word.toMap(),
      finder: finder,
    );
  }

  Future delete(Words word) async {
    final finder = Finder(filter: Filter.byKey(word.id));
    await _wordStore.delete(
      await _db,
      finder: finder,
    );
  }

  Future<List<Words>> getAllSortedByContent() async {
    // Finder object can also sort data.
    final finder = Finder(sortOrders: [
      SortOrder('content'),
    ]);

    final recordSnapshots = await _wordStore.find(
      await _db,
      finder: finder,
    );
    //  print(recordSnapshots);
    // Making a List<User> out of List<RecordSnapshot>
    return recordSnapshots.map((snapshot) {
      final word = Words.fromMap(snapshot.value);
      // An ID is a key of a record from the database.
      word.id = snapshot.key;
      //print(word.id);
      return word;
    }).toList();
  }
}
