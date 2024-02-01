// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:penyewaan_gedung_triharjo/screen/detail_list_order/detail_list_order_view_model.dart';
import 'package:penyewaan_gedung_triharjo/screen/error/error_widget.dart';
import 'package:provider/provider.dart';
import 'package:penyewaan_gedung_triharjo/service/admin_confirmation_order_service.dart';

class DetailListOrderScreen extends StatefulWidget {
  final String codeBooking;
  const DetailListOrderScreen({
    super.key,
    required this.codeBooking,
  });

  @override
  State<DetailListOrderScreen> createState() => _DetailListOrderScreenState();
}

class _DetailListOrderScreenState extends State<DetailListOrderScreen> {
  bool detailPemesanan = true;
  bool isLoading = false;
  late Future detailPemesananFuture;
  @override
  void initState() {
    super.initState();
    final detailViewModel =
        Provider.of<DetailListOrderViewModel>(context, listen: false);
    detailPemesananFuture =
        detailViewModel.getPemesananDetail(codeBooking: widget.codeBooking);
  }

  String tanggalBooking(value) {
    DateTime dateTime = DateTime.parse(value);
    dateTime = dateTime.toLocal();
    return "${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List Pemesanan'),
        centerTitle: true,
      ),
      body: FutureBuilder(
          future: detailPemesananFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              final detailViewModel =
                  Provider.of<DetailListOrderViewModel>(context, listen: false);
              return Center(
                child: ErrorWidgetScreen(onRefreshPressed: () {
                  detailViewModel.getPemesananDetail(
                      codeBooking: widget.codeBooking);
                }),
              );
            } else if (snapshot.connectionState == ConnectionState.done) {
              return Consumer<DetailListOrderViewModel>(
                  builder: (context, provider, _) {
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(16),
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.grey,
                                offset: Offset(0, 0),
                                blurRadius: 4,
                                spreadRadius: 1,
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    color: const Color(0xFFD9D9D9),
                                    borderRadius: BorderRadius.circular(100)),
                                padding: const EdgeInsets.all(25),
                                child: Image.asset(
                                  'assets/icon/bottom_bar/user_white.png',
                                  fit: BoxFit.fill,
                                  height: 35,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    provider.detailPemesanan!.nama,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text('ID : ${widget.codeBooking}'),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 5),
                                    decoration: BoxDecoration(
                                      color: provider.detailPemesanan!.status ==
                                              "success"
                                          ? Colors.green
                                          : Colors.red,
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                    child: Text(
                                      provider.detailPemesanan!.status ==
                                              "success"
                                          ? 'Sudah Lunas'
                                          : 'Belum Dibayar',
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              detailPemesanan = !detailPemesanan;
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.grey,
                                  offset: Offset(0, 0),
                                  blurRadius: 4,
                                  spreadRadius: 1,
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 5, 5, 5),
                                  child: Column(
                                    children: [
                                      const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Detail Pemesanan',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Icon(
                                            Icons.arrow_drop_down,
                                            size: 40,
                                          ),
                                        ],
                                      ),
                                      Visibility(
                                        visible: detailPemesanan,
                                        child: Column(
                                          children: [
                                            const Divider(
                                              thickness: 1,
                                              height: 1,
                                              color: Color(0xFFA9A9A9),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 15),
                                              child: Center(
                                                child: Text(
                                                  provider
                                                      .detailPemesanan!.event,
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16),
                                                ),
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                const Text(
                                                  'No KTP',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Text(
                                                  provider
                                                      .detailPemesanan!.noKTP,
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                const Text(
                                                  'Nama',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Text(provider
                                                    .detailPemesanan!.nama),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                const Text(
                                                  'Email',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Text(provider
                                                    .detailPemesanan!.email),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                const Text(
                                                  'No Whatsapp',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Text(provider
                                                    .detailPemesanan!.noTelp),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            const Divider(
                                              thickness: 1,
                                              height: 1,
                                              color: Color(0xFFA9A9A9),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            const Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  'Tanggal Booking',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  tanggalBooking(
                                                      "${provider.detailPemesanan!.dateMulai}"),
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                const Icon(Icons.date_range),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Visibility(
                                  visible: detailPemesanan,
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 20, horizontal: 20),
                                    decoration: const BoxDecoration(
                                      color: Color(0xFFD9D9D9),
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(5),
                                        bottomRight: Radius.circular(5),
                                      ),
                                    ),
                                    child: Column(
                                      children: [
                                        const Text('Alamat'),
                                        Text(provider.detailPemesanan!.alamat),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Visibility(
                          visible:
                              provider.detailPemesanan!.status != "success",
                          child: FractionallySizedBox(
                            widthFactor: 1.0,
                            child: ElevatedButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      backgroundColor: const Color(0xFF3972C8),
                                      title: const Text(
                                        'Konfirmasi Pemesanan',
                                        style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                      content: RichText(
                                        text: TextSpan(
                                          style: const TextStyle(
                                              color: Colors.white),
                                          children: <TextSpan>[
                                            const TextSpan(
                                              text:
                                                  'Apakah Anda yakin ingin konformasi pesanan : \n \n',
                                              style: TextStyle(fontSize: 16.0),
                                            ),
                                            TextSpan(
                                              text:
                                                  'Booking Code : ${provider.detailPemesanan!.bookingCode} \n',
                                              style: const TextStyle(
                                                  fontSize: 16.0),
                                            ),
                                            TextSpan(
                                              text:
                                                  'Event : ${provider.detailPemesanan!.event}',
                                              style: const TextStyle(
                                                  fontSize: 16.0),
                                            ),
                                            TextSpan(
                                              text:
                                                  'Total Pembayaran : ${provider.detailPemesanan!.totalPembayaran} \n \n',
                                              style: const TextStyle(
                                                  fontSize: 16.0),
                                            ),
                                            const TextSpan(
                                              text:
                                                  'Anda tidak bisa hapus pesanan setelah konformasi',
                                              style: TextStyle(fontSize: 16.0),
                                            ),
                                          ],
                                        ),
                                      ),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: isLoading
                                              ? null
                                              : () async {
                                                  setState(() {
                                                    isLoading = true;
                                                  });
                                                  log('$isLoading');
                                                  try {
                                                    var res =
                                                        await AdminConfirmationService()
                                                            .confirmationPemesanan(
                                                      bookingCode: int.parse(
                                                          provider
                                                              .detailPemesanan!
                                                              .bookingCode),
                                                    );
                                                    if (res.containsKey(
                                                            "result") &&
                                                        res != null) {
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                        SnackBar(
                                                          content: Text(
                                                              "Berhasil Konfirmasi Pemesanan ${provider.detailPemesanan!.bookingCode}"),
                                                        ),
                                                      );

                                                      Navigator.pop(context);

                                                      setState(() {
                                                        isLoading = false;
                                                      });
                                                    } else if (res
                                                        .containsKey("error")) {
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                        SnackBar(
                                                          content: Text(
                                                              "${res["error"]}"),
                                                        ),
                                                      );
                                                      Navigator.pop(context);

                                                      setState(() {
                                                        isLoading = false;
                                                      });
                                                    }
                                                  } catch (e) {
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                      SnackBar(
                                                        content: Text("$e"),
                                                      ),
                                                    );

                                                    setState(() {
                                                      isLoading = false;
                                                    });
                                                    Navigator.pop(context);
                                                  }
                                                },
                                          child: isLoading
                                              ? const Text(
                                                  'Loading',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                )
                                              : const Text(
                                                  'Ya',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white),
                                                ),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text(
                                            'Tidak',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.red[100],
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              child: const Text('Konfirmasi Pembayaran'),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              });
            } else {
              final detailViewModel =
                  Provider.of<DetailListOrderViewModel>(context, listen: false);
              return Center(
                child: ErrorWidgetScreen(onRefreshPressed: () {
                  detailViewModel.getPemesananDetail(
                      codeBooking: widget.codeBooking);
                }),
              );
            }
          }),
    );
  }
}
