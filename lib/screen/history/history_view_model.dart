import 'dart:async';
import 'package:flutter/material.dart';
import 'package:penyewaan_gedung_triharjo/model/list_pemesanan_model.dart';
import 'package:penyewaan_gedung_triharjo/service/list_pemesanan_service.dart';

class HistoryViewModel extends ChangeNotifier {
  List<DetailPemesananModel> _listHistory = [];
  List<DetailPemesananModel> get historyData => _listHistory;

  final _historyController = StreamController<List<DetailPemesananModel>>();
  Stream<List<DetailPemesananModel>> get historyStream =>
      _historyController.stream;

  Future<void> getHistoryData() async {
    try {
      final List<Map<String, dynamic>> historyData =
          await ListPemesananService.fetchListPemesananData();

      _listHistory = historyData
          .map((item) => DetailPemesananModel.fromJson(item))
          .toList();

      _historyController.add(_listHistory);
    } catch (error) {
      throw Exception('Gagal memuat semua data history: $error');
    }
    notifyListeners();
  }

  void clearAllHistory() {
    _listHistory.clear();
    _historyController.add(_listHistory);
  }

  @override
  void dispose() {
    _historyController.close();
    super.dispose();
  }
}
