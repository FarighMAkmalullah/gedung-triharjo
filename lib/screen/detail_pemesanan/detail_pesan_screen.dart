import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:penyewaan_gedung_triharjo/screen/dashboard/list_event_view_model.dart';
import 'package:penyewaan_gedung_triharjo/screen/detail_pemesanan/widget/form_pilihan_1_widget.dart';
import 'package:penyewaan_gedung_triharjo/screen/detail_pemesanan/widget/form_pilihan_2_widget.dart';
import 'package:provider/provider.dart';

class DetailPemesananScreen extends StatefulWidget {
  final String imageAssets;
  final String title;
  final List listSyarat;
  const DetailPemesananScreen({
    super.key,
    required this.imageAssets,
    required this.listSyarat,
    required this.title,
  });

  @override
  State<DetailPemesananScreen> createState() => _DetailPemesananScreenState();
}

class _DetailPemesananScreenState extends State<DetailPemesananScreen> {
  bool isVisible = false;

  //Bikin int jadi Currency
  String formatAmount(int amount) {
    final NumberFormat formatter = NumberFormat.decimalPattern('id');
    return formatter.format(amount);
  }

  @override
  Widget build(BuildContext context) {
    // final eventViewModel = Provider.of<EventViewModel>(context, listen: false);
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            Stack(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Image.asset(
                    widget.imageAssets,
                    fit: BoxFit.cover,
                    height: 300,
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: SizedBox(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                if (mounted) {
                                  Navigator.pop(context);
                                }
                              },
                              child: Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(200),
                                  color: Colors.black38,
                                ),
                                child: const Center(
                                  child: Icon(
                                    Icons.arrow_back,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(200),
                                color: Colors.black38,
                              ),
                              child: const Center(
                                child: Icon(
                                  Icons.share,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned.fill(
                  top: 270,
                  child: Container(
                    decoration: const BoxDecoration(
                        color: Color(0xFFF0F2F6),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25),
                          topRight: Radius.circular(25),
                        )),
                    height: 30,
                  ),
                )
              ],
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                color: Color(0xFFF0F2F6),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.title,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        const Row(
                          children: [
                            Text(
                              "List Harga",
                              style: TextStyle(
                                color: Color(0xFF3E70F2),
                              ),
                            ),
                            Icon(
                              Icons.chevron_right,
                              color: Color(0xFF3E70F2),
                            )
                          ],
                        ),
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      child: Text(
                          'Pemesanan seluruh Aula Balai Kelurahan gedung Triharjo. Jangka waktu pemesanan 1 hari.'),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          isVisible = !isVisible;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(10, 5, 5, 5),
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
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Syarat dan Kententuan Pemesanan',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Icon(
                                  Icons.arrow_drop_down,
                                  size: 40,
                                ),
                              ],
                            ),
                            ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: widget.listSyarat.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Visibility(
                                  visible: isVisible,
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 8, 8, 8),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Icon(Icons.arrow_right, size: 16),
                                        const SizedBox(width: 8),
                                        Expanded(
                                          child: Text(widget.listSyarat[index]
                                              ['listSyarat']),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Consumer<EventViewModel>(
                          builder: (context, eventViewModel, child) {
                            if (widget.title == 'Aula Balai Kelurahan') {
                              return eventViewModel.hargaAula != 0
                                  ? Text(
                                      'Rp ${formatAmount(eventViewModel.hargaAula)} / Hari',
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    )
                                  : const Text('Pilih Tipe Dahulu');
                            } else if (widget.title == 'Lapangan Olahraga') {
                              return eventViewModel.hargaLapangan != 0
                                  ? Text(
                                      'Rp ${formatAmount(eventViewModel.hargaLapangan)} / Hari',
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    )
                                  : const Text('Pilih Tipe Dahulu');
                            } else {
                              return eventViewModel.hargaGedungOlahraga != 0
                                  ? Text(
                                      'Rp ${eventViewModel.hargaGedungOlahraga} / Hari',
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    )
                                  : const Text('Pilih Tipe Dahulu');
                            }
                          },
                        ),
                        const Text(
                          'Warga Triharjo',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    widget.title == 'Gedung Olahraga'
                        ? const FormPilihan2Widget()
                        : FormPilihan1Widget(
                            title: widget.title,
                          ),
                    const SizedBox(
                      height: 25,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 45),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Tanggal yang sudah dipesan',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      return const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('29-30 Desember'),
                          Divider(
                            color: Colors.black,
                          ),
                        ],
                      );
                    },
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
