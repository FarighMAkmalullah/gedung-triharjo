import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';

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
  String? selectedLangganan;
  String? selectedKeperluan;
  String? selectedTipe;
  List<String> optionsLangganan = [
    'Berlangganan',
    'Tidak Berlangganan',
  ];
  List<String> optionsKeperluan = [
    'Hajatan / pernikahan',
    'Pameran/Expo',
    'Turnamen/Pertandingan',
    'Rapat/Pertemuan',
  ];
  List<String> optionsTipe = [
    'Organisasi',
    'Warga Triharjo',
    'Warga Luar Triharjo',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DropdownButtonFormField(
          // controller: passwordController,
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
        const SizedBox(
          height: 20,
        ),
        DropdownButtonFormField(
          // controller: passwordController,
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
        const SizedBox(
          height: 20,
        ),
        DropdownButtonFormField(
          // controller: passwordController,
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
        const Text(
          'Pilih Sesi',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
        ),
        const SizedBox(
          height: 20,
        ),
        Column(
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
        const SizedBox(
          height: 20,
        ),
        FractionallySizedBox(
          widthFactor: 1.0,
          child: SizedBox(
            height: 50,
            child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                ),
                child: const Text(
                  'Pesan Sekarang',
                )),
          ),
        ),
      ],
    );
  }
}