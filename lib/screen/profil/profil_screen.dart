import 'package:flutter/material.dart';
import 'package:penyewaan_gedung_triharjo/const/init/untils/shared_preference.dart';
import 'package:penyewaan_gedung_triharjo/screen/profil/provil_view_model.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfilScreen extends StatefulWidget {
  const ProfilScreen({super.key});

  @override
  State<ProfilScreen> createState() => _ProfilScreenState();
}

class _ProfilScreenState extends State<ProfilScreen> {
  late Future detailProfilFuture;

  // String token = await getToken();

  @override
  void initState() {
    // TODO: implement initState
    final detailViewModel =
        Provider.of<ProfilViewModel>(context, listen: false);

    detailProfilFuture = detailViewModel.getProfilDetail();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // return Container();
    return Consumer<ProfilViewModel>(builder: (context, provider, _) {
      return FutureBuilder(
          future: detailProfilFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.connectionState == ConnectionState.done) {
              return SafeArea(
                child: Scaffold(
                  body: ListView(
                    children: [
                      Stack(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 160,
                            decoration: const BoxDecoration(
                              color: Color(0xFF3E70F2),
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(30),
                              ),
                            ),
                          ),
                          Column(
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(16.0),
                                child: Row(
                                  children: [
                                    Text(
                                      'Profil',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 25,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 35,
                              ),
                              Container(
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFD9D9D9),
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: const Icon(
                                  Icons.person,
                                  size: 80,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              const Text(
                                'USER',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                ),
                                child: Column(
                                  children: [
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    TextFormField(
                                      readOnly: true,
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      controller: TextEditingController(
                                          text: provider.detailUser?.nama),
                                      decoration: const InputDecoration(
                                        labelText: 'Nama Lengkap',
                                        hintStyle: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16,
                                        ),
                                        hintText: 'Nama Lengkap',
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.always,
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.black,
                                          ),
                                        ),
                                        labelStyle: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    TextFormField(
                                      readOnly: true,
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      controller: TextEditingController(
                                          text: provider.detailUser?.email),
                                      decoration: const InputDecoration(
                                        labelText: 'Email',
                                        hintStyle: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16,
                                        ),
                                        hintText: 'Email',
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.always,
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.black,
                                          ),
                                        ),
                                        labelStyle: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    TextFormField(
                                      readOnly: true,
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      controller: TextEditingController(
                                          text: provider.detailUser?.noTelp),
                                      decoration: const InputDecoration(
                                        labelText: 'No Whatsapp',
                                        hintStyle: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16,
                                        ),
                                        hintText: 'No Whatsapp',
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.always,
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.black,
                                          ),
                                        ),
                                        labelStyle: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    TextFormField(
                                      readOnly: true,
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      controller: TextEditingController(
                                          text: provider.detailUser?.noKTP),
                                      decoration: const InputDecoration(
                                        labelText: 'No KTP',
                                        hintStyle: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16,
                                        ),
                                        hintText: 'No KTP',
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.always,
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.black,
                                          ),
                                        ),
                                        labelStyle: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    TextFormField(
                                      readOnly: true,
                                      maxLines: 5,
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      controller: TextEditingController(
                                          text:
                                              '${provider.detailUser?.alamatLengkap}'),
                                      decoration: const InputDecoration(
                                        labelText: 'Alamat',
                                        hintStyle: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16,
                                        ),
                                        hintText: 'Alamat',
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.always,
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.black,
                                          ),
                                        ),
                                        labelStyle: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: SizedBox(
                                            height: 50,
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.white,
                                                elevation: 0,
                                                side: const BorderSide(
                                                  color: Color(0xFF4472EB),
                                                  width: 3,
                                                ),
                                              ),
                                              onPressed: () {},
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  const Text(
                                                    'Edit',
                                                    style: TextStyle(
                                                      color: Color(0xFF4472EB),
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 15,
                                                  ),
                                                  Image.asset(
                                                    'assets/icon/profil/edit.png',
                                                    height: 25,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 15,
                                        ),
                                        Expanded(
                                          child: SizedBox(
                                            height: 50,
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.white,
                                                elevation: 0,
                                                side: const BorderSide(
                                                  color: Color(0xFFB91919),
                                                  width: 3,
                                                ),
                                              ),
                                              onPressed: () {
                                                removeToken();
                                                Navigator
                                                    .pushNamedAndRemoveUntil(
                                                        context,
                                                        '/',
                                                        (route) => false);
                                              },
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  const Text(
                                                    'Logout',
                                                    style: TextStyle(
                                                      color: Color(0xFFB91919),
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 15,
                                                  ),
                                                  Image.asset(
                                                    'assets/icon/profil/logout.png',
                                                    height: 25,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    FractionallySizedBox(
                                      widthFactor: 1.0,
                                      child: SizedBox(
                                        height: 50,
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.white,
                                            elevation: 0,
                                            side: const BorderSide(
                                              color: Colors.black,
                                              width: 1,
                                            ),
                                          ),
                                          onPressed: () {},
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Image.asset(
                                                'assets/icon/onboarding/google.png',
                                                height: 25,
                                              ),
                                              const SizedBox(
                                                width: 15,
                                              ),
                                              const Text(
                                                "Connect Akun Google",
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 100,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
              );
            } else {
              return const Center(
                child: Text("Error"),
              );
            }
          });
    });
  }
}