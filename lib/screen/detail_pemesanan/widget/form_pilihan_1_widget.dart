// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:penyewaan_gedung_triharjo/model/event_model.dart';
import 'package:penyewaan_gedung_triharjo/screen/checking_pemesanan/checking_pemesanan_widget.dart';
import 'package:penyewaan_gedung_triharjo/screen/dashboard/list_event_view_model.dart';
import 'package:penyewaan_gedung_triharjo/service/pesan.dart';
import 'package:provider/provider.dart';

class FormPilihan1Widget extends StatefulWidget {
  final String title;
  const FormPilihan1Widget({
    super.key,
    required this.title,
  });

  @override
  State<FormPilihan1Widget> createState() => _FormPilihan1WidgetState();
}

class _FormPilihan1WidgetState extends State<FormPilihan1Widget> {
  late Event eventData;

  bool isLoading = false;

  DateTimeRange? selectedDateRange;
  @override
  void initState() {
    super.initState();
    final eventViewModel = Provider.of<EventViewModel>(context, listen: false);
    if (widget.title == "Aula Balai Kelurahan") {
      eventData = eventViewModel.getEventById(8);
      options = [
        'Perorangan',
        'Organisasi',
      ];
    } else if (widget.title == "Lapangan Olahraga") {
      eventData = eventViewModel.getEventById(9);
      options = [
        'Perorangan',
      ];
    }
    selectedOption = options.isNotEmpty ? options[0] : '';
  }

  List<String> options = [
    'Organisasi',
    'Warga Triharjo',
    'Warga Luar Triharjo',
  ];

  List<String> optionsBank = [
    'BRI',
  ];

  DateTime? startDate;
  late int numberOfDays;
  late String formatDateAwal;
  void processSelectedDateRange(DateTimeRange selectedDateRange) {
    startDate = selectedDateRange.start;
    String formattedStartDate = DateFormat('yyyy-MM-dd').format(startDate!);
    formatDateAwal = formattedStartDate;
    numberOfDays =
        selectedDateRange.end.difference(selectedDateRange.start).inDays + 1;
  }

  String selectedOption = 'Perorangan';
  String selectedBank = 'BRI';

  Future<void> makePemesanan() async {
    setState(() {
      isLoading = true;
    });
    try {
      var res = await AddPemesananService().pemesananAdd(
        idEvent: eventData.idEvent,
        dateMulai: formatDateAwal,
        jumlahHari: "$numberOfDays",
        tipeHarga: selectedOption.toLowerCase(),
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
      log('Jumlah Hari $numberOfDays');
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
    final eventViewModel = Provider.of<EventViewModel>(context, listen: false);
    return Column(
      children: [
        DropdownButtonFormField(
          value: selectedOption,
          validator: (String? value) {
            if (value!.isEmpty) {
              return "can't empty";
            } else {
              return null;
            }
          },
          items: options.map((String option) {
            return DropdownMenuItem(
              value: option,
              child: Text(option),
            );
          }).toList(),
          onChanged: (newValue) {
            if (widget.title == "Aula Balai Kelurahan") {
              if (newValue == 'Perorangan') {
                eventViewModel.gantiHargaAula(eventData.perorangan);
              } else if (newValue == 'Organisasi') {
                eventViewModel.gantiHargaAula(eventData.organisasi);
              }
              setState(
                () {
                  options = [
                    'Organisasi',
                    'Perorangan',
                  ];
                  selectedOption = newValue!;
                },
              );
            } else if (widget.title == "Lapangan Olahraga") {
              if (newValue == 'Perorangan') {
                eventViewModel.gantiHargaLapangan(eventData.perorangan);
              }
              setState(
                () {
                  options = [
                    'Organisasi',
                    'Perorangan',
                  ];
                  selectedOption = newValue!;
                },
              );
            }
          },
          // controller: passwordController,

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
        FractionallySizedBox(
          widthFactor: 1.0,
          child: SizedBox(
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                _selectDateRange(context);
              },
              style: ElevatedButton.styleFrom(
                elevation: 0,
              ),
              child: isLoading
                  ? const CircularProgressIndicator()
                  : const Text(
                      'Pilih Tanggal',
                    ),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _selectDateRange(BuildContext context) async {
    final initialDateRange = selectedDateRange ??
        DateTimeRange(
          start: DateTime.now(),
          end: DateTime.now(),
        );

    final newDateRange = await showDateRangePicker(
      context: context,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.dark(
              surface: Colors.white,
              primary: Colors.blue,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Colors.black,
              ),
            ),
          ),
          child: child!,
        );
      },
      initialDateRange: initialDateRange,
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 2),
      helpText: 'Start - End Date',
      cancelText: 'CANCEL',
      confirmText: 'OK',
      saveText: 'SAVE',
      errorFormatText: 'Invalid format.',
      errorInvalidText: 'Out of range.',
      errorInvalidRangeText: 'Invalid range.',
      fieldStartHintText: 'Start Date',
      fieldEndLabelText: 'End Date',
    );

    if (newDateRange != null && newDateRange != selectedDateRange) {
      setState(() {
        selectedDateRange = newDateRange;
      });
      processSelectedDateRange(selectedDateRange!);
      makePemesanan();
    }
  }
}
