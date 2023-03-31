import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LocalStorageProvider {
  late FlutterSecureStorage _storage;
  static final LocalStorageProvider _instance = LocalStorageProvider._internal();

  factory LocalStorageProvider() {
    _instance._storage = const FlutterSecureStorage();
    return _instance;
  }

  LocalStorageProvider._internal();

  AndroidOptions _getAndroidOptions() => const AndroidOptions(
        encryptedSharedPreferences: true,
      );
  final iOptions = const IOSOptions();

  Future saveByKey(String key, {String? data}) async {
    await _storage.write(key: key, value: data, aOptions: _getAndroidOptions(), iOptions: iOptions);
  }

  Future<void> deleteByKey(String key) async {
    await _storage.delete(key: key, aOptions: _getAndroidOptions(), iOptions: iOptions);
  }

  Future<dynamic> retrieveDataByKey(String key) async {
    return await _storage.read(key: key, aOptions: _getAndroidOptions(), iOptions: iOptions,);
  }
 Future<String?> readDataByKey(String key) async {
   var readData =
     await _storage.read(key: key, aOptions: _getAndroidOptions(), iOptions: iOptions);
 return readData;
  }

  Future<void> deleteStorage() async {
      await _storage.deleteAll(aOptions: _getAndroidOptions(), iOptions: iOptions);
  }
}
