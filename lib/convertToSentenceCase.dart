import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart' show toBeginningOfSentenceCase;

String? convertToSentenceCase(String? data) {
  return toBeginningOfSentenceCase(data);
}

main() {
  debugPrint(convertToSentenceCase("hello world"));

  /*
  * input: hello world
  * output: Hello world
  * */
}
