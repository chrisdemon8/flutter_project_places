import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class FileStorage {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/favplace.json');
  }

  Future<Map<String, dynamic>> readFav() async {
    try {
      final file = await _localFile;

      // Read the file
      final contents = await file.readAsString();

      return jsonDecode(contents);
    } catch (e) {
      // If encountering an error, return 0
      return {};
    }
  }

  Future<File> writeFav(Map<String, dynamic> key) async {
    final file = await _localFile;


    // Write the file
    return file.writeAsString(jsonEncode(key));
  }
}
