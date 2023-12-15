import 'package:flutter/material.dart';

class FormPilihan2Widget extends StatefulWidget {
  const FormPilihan2Widget({super.key});

  @override
  State<FormPilihan2Widget> createState() => _FormPilihan2WidgetState();
}

class _FormPilihan2WidgetState extends State<FormPilihan2Widget> {
  String selectedOption = 'Warga Triharjo';
  List<String> options = [
    'Organisasi',
    'Warga Triharjo',
    'Warga Luar Triharjo',
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DropdownButtonFormField(
          // controller: passwordController,
          value: selectedOption,
          items: options.map((String option) {
            return DropdownMenuItem(
              value: option,
              child: Text(option),
            );
          }).toList(),
          onChanged: (newValue) {
            setState(() {
              selectedOption = newValue!;
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
        DropdownButtonFormField(
          // controller: passwordController,
          value: selectedOption,
          items: options.map((String option) {
            return DropdownMenuItem(
              value: option,
              child: Text(option),
            );
          }).toList(),
          onChanged: (newValue) {
            setState(() {
              selectedOption = newValue!;
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
        DropdownButtonFormField(
          // controller: passwordController,
          value: selectedOption,
          items: options.map((String option) {
            return DropdownMenuItem(
              value: option,
              child: Text(option),
            );
          }).toList(),
          onChanged: (newValue) {
            setState(() {
              selectedOption = newValue!;
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
        DropdownButtonFormField(
          // controller: passwordController,
          value: selectedOption,
          items: options.map((String option) {
            return DropdownMenuItem(
              value: option,
              child: Text(option),
            );
          }).toList(),
          onChanged: (newValue) {
            setState(() {
              selectedOption = newValue!;
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
                  'Pilih Tanggal',
                )),
          ),
        ),
      ],
    );
  }
}
