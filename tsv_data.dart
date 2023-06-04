import 'dart:io';
import 'package:prog2/delimited_data.dart';

class TSVData implements DelimitedData {
  List<String> fieldsTSV = [];
  dynamic listofvalues = [];

  @override
  String get separator => '"\t"';

  @override
  void load(tsvfile) {
    if (!tsvfile.contains('.tsv')) throw FormatException("Invalid Format");
    tsvfile = File(tsvfile).readAsStringSync();
    data = tsvfile;
  }

  @override
  set data(String data) {
    final values = data.split('\n');
    for (var value in values) {
      listofvalues.add(value.split('\t'));
    }
    fieldsTSV = listofvalues[0];
  }

  @override
  String get data {
    if (!hasData) return '';
    String strValues = '';
    for (int i = 0; i < listofvalues.length; i++) {
      strValues += (listofvalues[i]
          .toString()
          .replaceAll(' ', '\t')
          .replaceAll('[', '')
          .replaceAll(']', '')
          .replaceAll(',', ''));

      strValues += '\n';
    }
    return strValues;
  }

  @override
  List<String> get fields {
    return fieldsTSV;
  }

  @override
  void save(String fileName) {
    String strValues = '';
    for (int i = 0; i < listofvalues.length; i++) {
      strValues += (listofvalues[i]
          .toString()
          .replaceAll(' ', '\t')
          .replaceAll('[', '')
          .replaceAll(']', '')
          .replaceAll(',', ''));
      strValues += '\n';
    }

    final outFile = File(fileName);
    outFile.createSync(recursive: true);
    outFile.writeAsStringSync(strValues);
    print('Status: Saved successfully');
  }

  @override
  void clear() {
    listofvalues = "";
  }

  @override
  bool get hasData => listofvalues.isNotEmpty;
}
