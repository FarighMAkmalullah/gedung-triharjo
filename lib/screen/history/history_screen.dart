import 'package:flutter/material.dart';
import 'package:penyewaan_gedung_triharjo/model/list_pemesanan_model.dart';
import 'package:penyewaan_gedung_triharjo/screen/checking_pemesanan/checking_pemesanan_widget.dart';
import 'package:penyewaan_gedung_triharjo/screen/error/error_widget.dart';
import 'package:penyewaan_gedung_triharjo/screen/history/history_view_model.dart';
import 'package:provider/provider.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<HistoryViewModel>(context, listen: false).streamHistoryData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: const Text(
              'History Order',
              style: TextStyle(color: Colors.white),
            ),
            centerTitle: true,
            elevation: 0,
            backgroundColor: const Color(0xFF3E70F2),
          ),
          body: StreamBuilder(
            stream: Provider.of<HistoryViewModel>(context, listen: false)
                .historyStream,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: ErrorWidgetScreen(onRefreshPressed: () {
                    Provider.of<HistoryViewModel>(context, listen: false)
                        .historyStream;
                  }),
                );
              } else {
                List<DetailPemesananModel> historyData = snapshot.data ?? [];
                if (historyData.isEmpty) {
                  return const Center(
                    child: Text('Belum ada Pemesanan'),
                  );
                } else {
                  return ListView.builder(
                    itemCount: historyData.length,
                    itemBuilder: (context, index) {
                      var detailHistory = historyData[index];
                      return Container(
                        margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.grey,
                              offset: Offset(0, 0),
                              blurRadius: 4,
                              spreadRadius: 1,
                            ),
                          ],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.asset(
                                      'assets/icon/history/purchase.png',
                                      fit: BoxFit.fill,
                                      height: 50,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          detailHistory.event,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                            'ID : ${detailHistory.bookingCode}')
                                      ],
                                    ),
                                  ],
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 5),
                                  decoration: BoxDecoration(
                                    color: detailHistory.status == "success"
                                        ? Colors.green
                                        : Colors.red,
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  child: Text(
                                    detailHistory.status == "success"
                                        ? 'Lunas'
                                        : 'Belum',
                                    style: const TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFF3E70F2),
                                      elevation: 0,
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              CheckingPemesanan(
                                                  codeBooking: detailHistory
                                                      .bookingCode),
                                        ),
                                      );
                                    },
                                    child: const Text('Lihat Detail'),
                                  ),
                                ),
                                Visibility(
                                  visible: detailHistory.status != "success",
                                  child: const SizedBox(
                                    width: 15,
                                  ),
                                ),
                                Visibility(
                                  visible: detailHistory.status != "success",
                                  child: Expanded(
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.transparent,
                                        elevation: 0,
                                        side: const BorderSide(
                                          color: Color(0xFFCE1818),
                                          width: 1,
                                        ),
                                      ),
                                      onPressed: () {},
                                      child: const Text(
                                        'Cancel',
                                        style: TextStyle(
                                          color: Color(0xFFCE1818),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      );
                    },
                  );
                }
              }
            },
          )),
    );
  }
}
