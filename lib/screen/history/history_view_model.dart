import 'dart:async';
import 'package:flutter/material.dart';
import 'package:penyewaan_gedung_triharjo/model/list_pemesanan_model.dart';
import 'package:penyewaan_gedung_triharjo/service/list_pemesanan_service.dart';
import 'package:rxdart/rxdart.dart';

class HistoryViewModel extends ChangeNotifier {
  final historyController = BehaviorSubject<List<DetailPemesananModel>>();
  late Timer timer1;
  Stream<List<DetailPemesananModel>> get historyStream =>
      historyController.stream;

  bool _isTimerActive = false;

  StreamSubscription<List<DetailPemesananModel>>? subscription;

  void streamHistoryData() async {
    if (!_isTimerActive) {
      timer1 = Timer.periodic(const Duration(milliseconds: 1000), (timer) {
        if (!historyController.isClosed) {
          getHistoryData();
        } else {
          timer.cancel();
        }
      });
      _isTimerActive = true;
    }
  }

  Future<void> getHistoryData() async {
    try {
      final List<DetailPemesananModel> historyData =
          await ListPemesananService.fetchListPemesananData();
      historyController.add(historyData);
    } catch (error) {
      throw Exception('Error loading history data: $error');
    }
  }

  void cancelTimer() {
    if (_isTimerActive) {
      timer1.cancel();
      _isTimerActive = false;
    }
  }

  @override
  void dispose() {
    super.dispose();
    historyController.close();
    subscription?.cancel();
  }
}
