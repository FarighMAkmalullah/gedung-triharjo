// ignore_for_file: use_build_context_synchronously, unnecessary_brace_in_string_interps

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:penyewaan_gedung_triharjo/model/list_pemesanan_model.dart';
import 'package:penyewaan_gedung_triharjo/screen/checking_pemesanan/checking_pemesanan_widget.dart';
import 'package:penyewaan_gedung_triharjo/screen/detail_list_order/detail_list_order_screen.dart';
import 'package:penyewaan_gedung_triharjo/screen/error/error_widget.dart';
import 'package:penyewaan_gedung_triharjo/screen/history/history_view_model.dart';
import 'package:penyewaan_gedung_triharjo/screen/list_order/list_order_view_model.dart';
import 'package:penyewaan_gedung_triharjo/service/delete_pemesanan.dart';
import 'package:provider/provider.dart';

class ListOrderScreen extends StatefulWidget {
  const ListOrderScreen({super.key});

  @override
  State<ListOrderScreen> createState() => _ListOrderScreenState();
}

class _ListOrderScreenState extends State<ListOrderScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<ListOrderViewModel>(context, listen: false).streamHistoryData();
  }

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'List Order',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: const Color(0xFF3E70F2),
        ),
        body: StreamBuilder(
          stream: Provider.of<ListOrderViewModel>(context, listen: false)
              .historyStream,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: ErrorWidgetScreen(onRefreshPressed: () {
                  Provider.of<ListOrderViewModel>(context, listen: false)
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
                      margin: EdgeInsets.fromLTRB(
                          16, 16, 16, index == historyData.length - 1 ? 16 : 0),
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
                                    'assets/icon/bottom_bar/user.png',
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
                                      Text('ID : ${detailHistory.bookingCode}')
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
                                    backgroundColor: Colors.transparent,
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      side:
                                          const BorderSide(color: Colors.blue),
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            DetailListOrderScreen(
                                                codeBooking:
                                                    detailHistory.bookingCode),
                                      ),
                                    );
                                  },
                                  child: const Text(
                                    'Lihat Detail',
                                    style: TextStyle(color: Color(0xFF3E70F2)),
                                  ),
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
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: const Text(
                                              'Konfirmasi Hapus',
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            content: const Text(
                                                'Data tidak akan bisa dikembalikan. Apakah Anda yakin ingin menghapus?'),
                                            actions: <Widget>[
                                              TextButton(
                                                onPressed: isLoading
                                                    ? null
                                                    : () async {
                                                        setState(() {
                                                          isLoading = true;
                                                        });
                                                        log('${isLoading}');
                                                        try {
                                                          var res = await DeleteService()
                                                              .deletePemesanan(
                                                                  bookingCode:
                                                                      int.parse(
                                                                          detailHistory
                                                                              .bookingCode));
                                                          if (res.containsKey(
                                                                  "result") &&
                                                              res != null) {
                                                            ScaffoldMessenger
                                                                    .of(context)
                                                                .showSnackBar(
                                                              const SnackBar(
                                                                content: Text(
                                                                    "Berhasil hapus data Pemesanan"),
                                                              ),
                                                            );

                                                            Navigator.pop(
                                                                context);

                                                            setState(() {
                                                              isLoading = false;
                                                            });
                                                          } else if (res
                                                              .containsKey(
                                                                  "error")) {
                                                            ScaffoldMessenger
                                                                    .of(context)
                                                                .showSnackBar(
                                                              SnackBar(
                                                                content: Text(
                                                                    "${res["error"]}"),
                                                              ),
                                                            );
                                                            Navigator.pop(
                                                                context);

                                                            setState(() {
                                                              isLoading = false;
                                                            });
                                                          }
                                                        } catch (e) {
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(
                                                            SnackBar(
                                                              content:
                                                                  Text("${e}"),
                                                            ),
                                                          );

                                                          setState(() {
                                                            isLoading = false;
                                                          });
                                                          Navigator.pop(
                                                              context);
                                                        }
                                                      },
                                                child: isLoading
                                                    ? const Text(
                                                        'Loading',
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      )
                                                    : const Text(
                                                        'Ya',
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: const Text(
                                                  'Tidak',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.blue,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                    child: const Text(
                                      'Hapus Pesanan',
                                      style: TextStyle(
                                        color: Color(0xFFCE1818),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Visibility(
                            visible: detailHistory.status != "success",
                            child: const SizedBox(
                              height: 5,
                            ),
                          ),
                          Visibility(
                            visible: detailHistory.status != "success",
                            child: FractionallySizedBox(
                              widthFactor: 1.0,
                              child: ElevatedButton(
                                onPressed: () {},
                                child: const Text('Konfirmasi Pembayaran'),
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  },
                );
              }
            }
          },
        ),
      ),
    );
  }
}
