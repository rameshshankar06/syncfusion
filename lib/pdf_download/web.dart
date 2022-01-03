import 'dart:html';
import 'dart:convert';

Future<void> saveAndLaunchFile(List<int> bytes, String fileName) async {
  AnchorElement(
      href:
          "data:application/octet-stream;charset=utf-16le;base64,${base64.encode(bytes)}")
    ..setAttribute("download", fileName)
    ..click();
}
