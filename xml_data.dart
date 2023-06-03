import 'dart:io';

import 'package:prog2/data.dart';
import 'package:xml/xml.dart';

typedef record = Map<String, dynamic>;

class XMLData implements Data {
  Map<String, dynamic> mapcontentTag = {};
  List<String> field = [];
  dynamic content = [];
  String contentXml = '';

  @override
  void load(xmlfile) {
    if (!xmlfile.contains('.xml')) throw FormatException("Invalid Format");
    final document = File(xmlfile).readAsStringSync();
    contentXml = document;
    data = document;
  }

  @override
  set data(String data) {
    final xmldata = XmlDocument.parse(data);
    final xmlFile = xmldata.rootElement.childElements;
    print(xmlFile.first.attributes[0].name);
    for (var attr in xmlFile) {
      //print(attr);
      print(attr.attributes);
    }

    for (XmlElement tagContent in xmlFile) {
      for (XmlElement element in tagContent.childElements) {
        mapcontentTag[element.name.toString()] = element.innerText;
      }
      content.add(mapcontentTag.values.toString());
      field = mapcontentTag.keys.toList();
    }
  }

  @override
  String get data {
    if (!hasData) return '';
    String strValues = '';
    for (int i = 0; i < content.length; i++) {
      strValues += (content[i].toString());
      strValues += '\n';
    }
    return strValues;
  }

  @override
  List<String> get fields => field;

  @override
  bool get hasData => content.isNotEmpty;

  @override
  void clear() {
    content = "";
  }

  @override
  void save(String fileName) {
    final outFile = File(fileName);
    outFile.createSync(recursive: true);
    outFile.writeAsStringSync(contentXml);
    print('Status: Saved successfully');
  }
}
