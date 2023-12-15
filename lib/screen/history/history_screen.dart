import 'package:flutter/material.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  Map historyList = {
    'history': [
      {
        'title': 'Aula Balai Kelurahan',
        'id_pemesanan': 12345678,
        'lunas': true,
      },
      {
        'title': 'Lapangan Olahraga',
        'id_pemesanan': 12345678,
        'lunas': false,
      },
    ]
  };
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('History Order'),
          centerTitle: true,
          elevation: 0,
          backgroundColor: const Color(0xFF3E70F2),
        ),
        body: ListView.builder(
          itemCount: historyList['history'].length,
          itemBuilder: (context, index) {
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                historyList['history'][index]['title'],
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                  'ID : ${historyList['history'][index]['id_pemesanan']}')
                            ],
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 5),
                        decoration: BoxDecoration(
                          color: historyList['history'][index]['lunas']
                              ? Colors.green
                              : Colors.red,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Text(
                          historyList['history'][index]['lunas']
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
                          onPressed: () {},
                          child: const Text('Lihat Detail'),
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Expanded(
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
                    ],
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
