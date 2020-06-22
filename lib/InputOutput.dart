import 'dart:io';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

class InputOutput {
  // For checking if the user has already signed in or not. 
  Future<File> createFile(FirebaseUser user) async {
    try {
      final file = await localFile;
      final uid = user.uid;
      return file.writeAsString('$uid');
    } catch (e) {
      return e;
    }
  }

  Future<String> readFile(FirebaseUser user) async {
    try {
      final file = await localFile;
      return file.readAsString();
    } catch (e) {
      return 'FileNotFound';
    }
  }

  Future<String> get localPath async {
  final directory = await getApplicationDocumentsDirectory();
  print('the mother fucking path: '+ directory.path);
  return directory.path;
  }

  Future<File> get localFile async {
  final path = await localPath;
  return new File('$path/coronaVirusAppdb.txt');
  }
}

InputOutput inputOutput = InputOutput(); 