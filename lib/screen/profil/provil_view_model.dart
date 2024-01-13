import 'package:flutter/material.dart';
import 'package:penyewaan_gedung_triharjo/model/user_model.dart';
import 'package:penyewaan_gedung_triharjo/service/profil.dart';

class ProfilViewModel extends ChangeNotifier {
  UserResult? _detailUser;
  UserResult? get detailUser => _detailUser;

  Future getProfilDetail() async {
    try {
      final response = await ProfilService.getDetailUser();

      if (response.statusCode == 200) {
        final responseData = response.data['result'];
        _detailUser = UserResult.fromJson(responseData as Map<String, dynamic>);
        notifyListeners();
      } else {
        throw Exception(
            'Gagal memuat detail user. Error code : ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Gagal memuat detail user : $error');
    }
  }
}
