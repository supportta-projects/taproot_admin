// Blue text

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
//
//

void logInfo(msg) {
  String? jsonData;
  try {
    jsonData = jsonEncode(msg);
  } catch (e) {
    jsonData = msg.toString();
  }
  if (kDebugMode) {
    log('\x1B[34m$jsonData\x1B[0m');
  }
}

// Green text
void logSuccess(msg) {
  String? jsonData;
  try {
    jsonData = jsonEncode(msg);
  } catch (e) {
    jsonData = msg.toString();
  }
  if (kDebugMode) {
    log('\x1B[32m$jsonData\x1B[0m');
  }
}

// Yellow text
void logWarning(msg) {
  String? jsonData;
  try {
    jsonData = jsonEncode(msg);
  } catch (e) {
    jsonData = msg.toString();
  }
  if (kDebugMode) {
    log('\x1B[33m$jsonData\x1B[0m');
  }
}

// Red text
void logError(msg) {
  String? jsonData;
  try {
    jsonData = jsonEncode(msg);
  } catch (e) {
    jsonData = msg.toString();
  }
  if (kDebugMode) {
    log('\x1B[31m$jsonData\x1B[0m');
  }
}
