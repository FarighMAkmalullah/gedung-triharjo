import 'package:flutter/material.dart';

class PesanCarauselWidget extends StatefulWidget {
  const PesanCarauselWidget({super.key});

  @override
  State<PesanCarauselWidget> createState() => _PesanCarauselWidgetState();
}

class _PesanCarauselWidgetState extends State<PesanCarauselWidget> {
  Map<String, dynamic> carouselList = {
    'carousel': [
      {
        'title': 'Aula Balai Kelurahan',
        'image': 'assets/image/dashboard/aula.png',
      },
      {
        'title': 'Gedung Olahraga',
        'image': 'assets/image/dashboard/gedung.png',
      },
      {
        'title': 'Lapangan Olahraga',
        'image': 'assets/image/dashboard/lapangan.png',
      },
    ]
  };
  @override
  Widget build(BuildContext context) {
    var list = carouselList['carousel'];
    return SizedBox(
      height: 220,
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: list?.length ?? 0,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            margin: EdgeInsets.only(
              left: 16,
              right: index == list?.length - 1 ? 16 : 0,
              top: 5,
              bottom: 5,
            ),
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('${list?[index]['image']}'),
                  fit: BoxFit.fill),
              borderRadius: BorderRadius.circular(
                20,
              ),
              boxShadow: const [
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(0, 0),
                  blurRadius: 4,
                  spreadRadius: 1,
                ),
              ],
            ),
            width: 190,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  list?[index]['title'] ?? '',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                FractionallySizedBox(
                  widthFactor: 1.0,
                  child: SizedBox(
                    height: 30,
                    child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          'Pesan Sekarang',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        )),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
