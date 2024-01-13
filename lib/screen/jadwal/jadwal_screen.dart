import 'package:flutter/material.dart';

class JadwalScreen extends StatefulWidget {
  const JadwalScreen({super.key});

  @override
  State<JadwalScreen> createState() => _JadwalScreenState();
}

class _JadwalScreenState extends State<JadwalScreen> {
  int? officeId;
  DateTimeRange? selectedDateRange;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _selectDateRange(context);
    });
  }

  Future<void> _selectDateRange(BuildContext context) async {
    // final args = ModalRoute.of(context)?.settings.arguments as JadwalScreen;

    final pickedDateRange = await showDateRangePicker(
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
            child: child!);
      },
      initialDateRange: DateTimeRange(
        start: DateTime.now(),
        end: DateTime.now(),
      ),
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

    // if (pickedDateRange != null) {
    //   var res = await BookingAvailabilityService().checkDate(
    //     context,
    //     officeId: args.officeId,
    //     startDate: convertDateTime(pickedDateRange.start.toString()),
    //     endDate: convertDateTime(pickedDateRange.end.toString()),
    //   );
    //   var getStatus = res?.meta.code;
    //   if (getStatus == 201) {
    //     modalBottomSheet(context,
    //         img: 'assets/images/modal_bottom/retro_mac.png',
    //         title: 'All set!',
    //         desc: 'Tanggal yang kamu pilih tersedia!', path: () {
    //       setState(() {
    //         selectedDateRange = pickedDateRange;
    //       });
    //       Navigator.pop(context, selectedDateRange);
    //     }, buttonText: 'Selanjutnya');
    //   }
    //   if (getStatus == 500) {
    //     return modalBottomSheet(context,
    //         img: 'assets/images/modal_bottom/retro_mac_error.png',
    //         title: 'Waduh?!',
    //         desc: 'Gagal mengumpulkan informasi! Silahkan coba lagi', path: () {
    //       Navigator.pushReplacementNamed(
    //         context,
    //         '/bottom-nav',
    //       );
    //     }, buttonText: 'Pilih tanggal lain');
    //   }
    // }
  }

  @override
  Widget build(BuildContext context) {
    // final args = ModalRoute.of(context)?.settings.arguments as JadwalScreen;
    return Container();
  }
}
