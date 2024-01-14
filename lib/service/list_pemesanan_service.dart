import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:penyewaan_gedung_triharjo/const/init/const/api.dart';
import 'package:penyewaan_gedung_triharjo/const/init/untils/shared_preference.dart';

class ListPemesananService {
  static Future<List<Map<String, dynamic>>> fetchListPemesananData() async {
    String? token = await getToken();
    try {
      final dio = Dio();
      final response = await dio.get("$triharjoAPI/user/payment",
          options: Options(headers: {
            "accept": "application/json",
            "Content-Type": "application/json",
            "Authorization": "Bearer $token",
          }));

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data["result"];
        return data
            .map<Map<String, dynamic>>(
                (item) => Map<String, dynamic>.from(item))
            .toList();
      } else {
        throw Exception('Failed to load List Pemesanan Data');
      }
    } catch (error) {
      log("$error");
      throw Exception('Error: $error');
    }
  }
}