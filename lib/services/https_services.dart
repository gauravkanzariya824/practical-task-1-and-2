// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'package:task1/global/global_message.dart';


class HttpServices {
  static String API_BASE_URL = "https://jsonplaceholder.typicode.com/";

  static Map<String, String> requestHeaders = {
    HttpHeaders.contentTypeHeader: 'application/json',
    "Request-From": Platform.isAndroid ? "Android" : "Ios",
    HttpHeaders.acceptLanguageHeader: 'en',
  };

  static Future<Response> httpGetWithoutToken(String url) async {
    final bool isConnected = await InternetConnectionChecker().hasConnection;

    if (isConnected) {
      print("get call -   ${API_BASE_URL + url}");
      return http.get(
        Uri.parse(API_BASE_URL + url),
        headers: requestHeaders,
      );
    } else {
      throw GlobalMessages.internalnotConnected;
    }
  }


  static Future<Response> httpPatch(String url, dynamic data,
      {BuildContext? context}) async {
    final bool isConnected = await InternetConnectionChecker().hasConnection;

    if (isConnected) {
      print("patch call -   ${API_BASE_URL + url}");
      return http.patch(
        Uri.parse(API_BASE_URL + url),
        body: jsonEncode(data),
        headers: requestHeaders,
      );
    } else {
      throw GlobalMessages.internalnotConnected;
    }
  }


  static Future<Response> httpDelete(String url) async {
    final bool isConnected = await InternetConnectionChecker().hasConnection;

    if (isConnected) {
      print("delete call -   ${API_BASE_URL + url}");
      return http.delete(
        Uri.parse(API_BASE_URL + url),
        headers: {"Content-Type": "application/json"},
      );
    } else {
      throw GlobalMessages.internalnotConnected;
    }
  }
  static Future<Response> httpPostWithoutToken(String url, dynamic data) async {
    final bool isConnected = await InternetConnectionChecker().hasConnection;

    if (isConnected) {
      return http.post(
        Uri.parse(API_BASE_URL + url),
        body: jsonEncode(data),
        headers: requestHeaders,
      );
    } else {
      throw GlobalMessages.internalnotConnected;
    }
  }

}
