import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:path_provider/path_provider.dart';


Future<void> downloadString(String content, String fileName) async {
  final file = await writeFile(content);
  log('File saved to: ${file.path}');
}

Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();
  return directory.path;
}

Future<File> get _localFile async {
  final path = await _localPath;
  return File('$path/report.txt');
}

Future<File> writeFile(String content) async {
  final file = await _localFile;
  final bytes = utf8.encode(content);
  await file.writeAsBytes(bytes);
  return file;
}
