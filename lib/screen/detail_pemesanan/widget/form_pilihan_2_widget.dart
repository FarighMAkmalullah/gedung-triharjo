// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:penyewaan_gedung_triharjo/screen/checking_pemesanan/checking_pemesanan_widget.dart';
import 'package:penyewaan_gedung_triharjo/service/pesan.dart';

class FormPilihan2Widget extends StatefulWidget {
  const FormPilihan2Widget({super.key});

  @override
  State<FormPilihan2Widget> createState() => _FormPilihan2WidgetState();
}

class _FormPilihan2WidgetState extends State<FormPilihan2Widget> {
  List<String> chipValues = [
    '07:00 - 09:00',
    '09:00 - 11:00',
    '11:00 - 13:00',
    '13:00 - 15:00',
    '15:00 - 17:00',
    '17:00 - 19:00',
    '19:00 - 21:00',
    '21:00 - 23:00',
  ];
  List<String> selectedChips = [];
  final TextEditingController _dateController = TextEditingController();
  List<DateTime?> _singleDatePickerValueWithDefaultValue = [
    DateTime.now(),
  ];
  final currentDate = DateTime.now();
  String? selectedValue;
  String? selectedLangganan = 'Berlangganan';
  String? selectedKeperluan;
  String? selectedTipe;
  String? selectedTipe2;
  String? selectedTipeBerlangganan;
  List<String> optionsLangganan = [
    'Berlangganan',
    'Gedung',
  ];
  List<String> optionsKeperluan = [
    'Hajatan / pernikahan',
    'Pameran/Expo',
    'Turnamen/Pertandingan',
    'Rapat/Pertemuan',
  ];
  List<String> optionsBerlangganan = [
    'Line Badminton Bulanan',
    'Line Badminton Sesi',
    'Unit 1 Gedung',
  ];
  List<String> optionsTipe = [
    'Organisasi',
    'Perorangan',
  ];

  List<String> optionsTipe2 = [
    'Perorangan',
  ];

  bool isLoading = false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _dateController.dispose();
  }

  List<String> optionsBank = [
    'BRI',
  ];

  String selectedBank = 'BRI';

  Future<void> makePemesanan(int value) async {
    setState(() {
      isLoading = true;
    });
    try {
      var res = await AddPemesananService().pemesananAdd(
        idEvent: value,
        dateMulai: _dateController.text,
        jumlahHari: "1",
        tipeHarga: selectedTipe!.toLowerCase(),
        paymentType: selectedBank.toLowerCase(),
      );

      if (res.containsKey('result') && res != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) =>
                CheckingPemesanan(codeBooking: res["result"]["bookingCode"]),
          ),
        );

        setState(() {
          isLoading = false;
        });
      } else if (res.containsKey('error') && res != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
          res['error'],
          style: const TextStyle(color: Colors.white),
        )));

        log('Error during pemesanan: ${res['error']}');
        setState(() {
          isLoading = false;
        });
      }
      log('Pemesanan berhasil dilakukan!');
      log('Response: $res');
      log('Jumlah Hari');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
        "$e",
        style: const TextStyle(color: Colors.white),
      )));
      log('Error during pemesanan: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DropdownButtonFormField(
          value: selectedLangganan,
          validator: (String? value) {
            if (value!.isEmpty) {
              return "can't empty";
            } else {
              return null;
            }
          },
          items: optionsLangganan.map((String option) {
            return DropdownMenuItem(
              value: option,
              child: Text(option),
            );
          }).toList(),
          onChanged: (newValue) {
            setState(() {
              selectedLangganan = newValue!;
            });
          },
          decoration: InputDecoration(
            suffixIcon: const Icon(Icons.access_time),
            labelText: 'Pilih Langganan',
            filled: true,
            fillColor: Colors.white,
            floatingLabelBehavior: FloatingLabelBehavior.never,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        Visibility(
          visible: selectedLangganan == 'Gedung',
          child: const SizedBox(
            height: 20,
          ),
        ),
        Visibility(
          visible: selectedLangganan == 'Gedung',
          child: DropdownButtonFormField(
            value: selectedKeperluan,
            items: optionsKeperluan.map((String option) {
              return DropdownMenuItem(
                value: option,
                child: Text(option),
              );
            }).toList(),
            onChanged: (newValue) {
              setState(() {
                selectedKeperluan = newValue!;
              });
            },
            decoration: InputDecoration(
              suffixIcon: const Icon(Icons.dataset),
              labelText: 'Pilih Keperluan',
              filled: true,
              fillColor: Colors.white,
              floatingLabelBehavior: FloatingLabelBehavior.never,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
        Visibility(
          visible: selectedLangganan == 'Berlangganan',
          child: const SizedBox(
            height: 20,
          ),
        ),
        Visibility(
          visible: selectedLangganan == 'Berlangganan',
          child: DropdownButtonFormField(
            value: selectedTipeBerlangganan,
            items: optionsBerlangganan.map((String option) {
              return DropdownMenuItem(
                value: option,
                child: Text(option),
              );
            }).toList(),
            onChanged: (newValue) {
              setState(() {
                selectedTipeBerlangganan = newValue!;
              });
            },
            decoration: InputDecoration(
              suffixIcon: const Icon(Icons.dataset),
              labelText: 'Pilih Tipe Berlangganan',
              filled: true,
              fillColor: Colors.white,
              floatingLabelBehavior: FloatingLabelBehavior.never,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
        Visibility(
          visible: selectedLangganan == 'Gedung',
          child: const SizedBox(
            height: 20,
          ),
        ),
        Visibility(
          visible: selectedLangganan == 'Gedung',
          child: DropdownButtonFormField(
            value: selectedTipe,
            items: optionsTipe.map((String option) {
              return DropdownMenuItem(
                value: option,
                child: Text(option),
              );
            }).toList(),
            onChanged: (newValue) {
              setState(() {
                selectedTipe = newValue!;
              });
            },
            decoration: InputDecoration(
              suffixIcon: const Icon(Icons.list),
              labelText: 'Pilih Tipe',
              filled: true,
              fillColor: Colors.white,
              floatingLabelBehavior: FloatingLabelBehavior.never,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
        Visibility(
          visible: selectedLangganan == 'Berlangganan',
          child: const SizedBox(
            height: 20,
          ),
        ),
        Visibility(
          visible: selectedLangganan == 'Berlangganan',
          child: DropdownButtonFormField(
            value: selectedTipe2,
            items: optionsTipe2.map((String option) {
              return DropdownMenuItem(
                value: option,
                child: Text(option),
              );
            }).toList(),
            onChanged: (newValue) {
              setState(() {
                selectedTipe2 = newValue!;
              });
            },
            decoration: InputDecoration(
              suffixIcon: const Icon(Icons.list),
              labelText: 'Pilih Tipe 2',
              filled: true,
              fillColor: Colors.white,
              floatingLabelBehavior: FloatingLabelBehavior.never,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        TextFormField(
          controller: _dateController,
          readOnly: true,
          autofocus: true,
          onTap: () async {
            showDialog(
              context: context,
              builder: (BuildContext contet) {
                return Dialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: CalendarDatePicker2(
                      config: CalendarDatePicker2Config(
                        firstDate: DateTime(1990),
                        lastDate: DateTime(currentDate.year + 5),
                        currentDate: DateTime.now(),
                      ),
                      value: _singleDatePickerValueWithDefaultValue,
                      onValueChanged: (value) {
                        DateTime? dateBirth = value[0];
                        if (dateBirth != null) {
                          setState(() {
                            _singleDatePickerValueWithDefaultValue = value;
                            _dateController.text =
                                DateFormat('yyyy-MM-dd').format(dateBirth);
                          });
                        }
                        Navigator.pop(context);
                      },
                    ),
                  ),
                );
              },
            );
          },
          decoration: InputDecoration(
            suffixIcon: const Icon(Icons.date_range),
            labelText: 'Pilih Tanggal',
            filled: true,
            fillColor: Colors.white,
            floatingLabelBehavior: FloatingLabelBehavior.never,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        DropdownButtonFormField(
          value: selectedBank,
          items: optionsBank.map((String option) {
            return DropdownMenuItem(
              value: option,
              child: Text(option),
            );
          }).toList(),
          onChanged: (newValue) {
            setState(() {
              selectedBank = newValue!;
            });
          },
          decoration: InputDecoration(
            suffixIcon: const Icon(Icons.comment_bank),
            labelText: 'Pilih Bank',
            filled: true,
            fillColor: Colors.white,
            floatingLabelBehavior: FloatingLabelBehavior.never,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Visibility(
          visible: selectedLangganan == 'Berlangganan' &&
              selectedTipeBerlangganan == 'Line Badminton Sesi',
          child: const Text(
            'Pilih Sesi',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
          ),
        ),
        Visibility(
          visible: selectedLangganan == 'Berlangganan' &&
              selectedTipeBerlangganan == 'Line Badminton Sesi',
          child: const SizedBox(
            height: 20,
          ),
        ),
        Visibility(
          visible: selectedLangganan == 'Berlangganan' &&
              selectedTipeBerlangganan == 'Line Badminton Sesi',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 5.0,
                  crossAxisSpacing: 8.0,
                  childAspectRatio: 3.0,
                ),
                itemCount: chipValues.length,
                itemBuilder: (BuildContext context, int index) {
                  return ChoiceChip(
                    label: Text(chipValues[index]),
                    selectedColor: Colors.blue,
                    labelStyle: TextStyle(
                      color: selectedChips.contains(chipValues[index])
                          ? Colors.white
                          : Colors.black,
                    ),
                    selected: selectedChips.contains(chipValues[index]),
                    onSelected: (bool selected) {
                      setState(() {
                        if (selected) {
                          selectedChips.add(chipValues[index]);
                        } else {
                          selectedChips.remove(chipValues[index]);
                        }
                      });
                    },
                  );
                },
              ),
              const SizedBox(
                height: 15,
              ),
              selectedChips.isEmpty
                  ? Container()
                  : Text('Anda Memilih Sesi: ${selectedChips.join(', ')}'),
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        FractionallySizedBox(
          widthFactor: 1.0,
          child: SizedBox(
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                if (selectedLangganan == 'Berlangganan') {
                  if (selectedTipeBerlangganan == null) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text(
                      'Tipe Berlangganan Harus Diisi',
                      style: TextStyle(color: Colors.white),
                    )));
                  } else if (selectedTipe2 == null) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text(
                      'Pilih Tipe Harus diisi',
                      style: TextStyle(color: Colors.white),
                    )));
                  } else if (_dateController.text == '') {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text(
                      'Tanggal Harus diisi',
                      style: TextStyle(color: Colors.white),
                    )));
                  } else {}
                } else if (selectedLangganan == 'Gedung') {
                  if (selectedKeperluan == null) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text(
                      'Pilih Keperluan Harus diisi',
                      style: TextStyle(color: Colors.white),
                    )));
                  } else if (selectedTipe == null) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text(
                      'Pilih Tipe Harus diisi',
                      style: TextStyle(color: Colors.white),
                    )));
                  } else if (_dateController.text == '') {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text(
                      'Tanggal Harus diisi',
                      style: TextStyle(color: Colors.white),
                    )));
                  } else {
                    if (selectedKeperluan == 'Hajatan / pernikahan') {
                      makePemesanan(1);
                    } else if (selectedKeperluan == 'Pameran/Expo') {
                      makePemesanan(2);
                    } else if (selectedKeperluan == 'Turnamen/Pertandingan') {
                      makePemesanan(3);
                    } else if (selectedKeperluan == 'Rapat/Pertemuan') {
                      makePemesanan(4);
                    }
                  }
                }
              },
              style: ElevatedButton.styleFrom(
                elevation: 0,
              ),
              child: isLoading
                  ? const CircularProgressIndicator()
                  : const Text(
                      'Pesan Sekarang',
                    ),
            ),
          ),
        ),
      ],
    );
  }
}
