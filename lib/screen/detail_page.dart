import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scoring_panahan/auth/bloc.dart';
import 'package:scoring_panahan/bloc/home_bloc/bloc.dart';
import 'package:scoring_panahan/models/peserta_models.dart';
import 'package:scoring_panahan/repository/home_repo.dart';
import 'package:scoring_panahan/screen/test_page.dart';
import 'package:scoring_panahan/widget/message_widget.dart';

class DetailPage extends StatelessWidget {
  int sesi;
  int jarak;
  DetailPage({this.sesi, this.jarak});
  final HomeRepository homeRepository = HomeRepository();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: (jarak != null)
            ? Text('Sesi $sesi Jarak $jarak')
            : Text('Sesi $sesi'),
        flexibleSpace: Container(
          decoration: new BoxDecoration(
            gradient: new LinearGradient(
                colors: [
                  const Color(0xFFDB6AF4),
                  const Color(0xFFAC4BF1),
                ],
                begin: const FractionalOffset(0.0, 0.0),
                end: const FractionalOffset(1.0, 0.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp),
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
          top: false,
          child: BlocProvider<HomeBloc>(
            create: (context) =>
                HomeBloc(homeRepository: homeRepository)..add(FetchHome()),
            child: BlocListener<HomeBloc, HomeState>(
              listener: (context, state) {
                if (state is HomeFetchedState) {
                  print('Berhasil konek');
                }
              },
              child: BlocBuilder<HomeBloc, HomeState>(
                builder: (context, state) {
                  if (state is HomeUninitializedState) {
                    return Scaffold(
                      body: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  } else if (state is HomeErrorState) {
                    return MessagePageWidget(
                      image: Image.asset(
                        'assets/img/failed.png',
                        height: 80,
                      ),
                      title: 'Terjadi kesalahan',
                      subtitle: 'ketika mengambil data',
                    );
                  } else if (state is HomeFetchingState) {
                    return Scaffold(
                      backgroundColor: Colors.white,
                      body: Center(
                        child: CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.purple)),
                      ),
                    );
                  } else {
                    final currentState = state as HomeFetchedState;
                    final pesertaModel = currentState.pesertaModel;
                    final panitiaModel = currentState.panitiaModel;

                    return _buildListView(context, pesertaModel);
                  }
                },
              ),
            ),
          )),
    );
  }

  Widget _buildListView(BuildContext context, PesertaModel pm) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    var p = pm.peserta;
    return ListView.builder(
        itemCount: pm.peserta.length,
        itemBuilder: (context, i) {
          return (p[i].sesi == sesi)
              ? Stack(children: [
                  GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TestPage(
                                  sesi: p[i].sesi.toString(),
                                  seri: p[i].jmlSeri.toString(),
                                  uuidRules: p[i].uuidRules,
                                  uuidPeserta: p[i].uuidPeserta,
                                  noTarget: p[i].noTarget,
                                  jmlPanah: p[i].jmlPanah,
                                  namaPeserta: p[i].namaPeserta,
                                ))),
                    child: Container(
                      margin: EdgeInsets.symmetric(
                        vertical: 8.0,
                        horizontal: 16.0,
                      ),
                      width: width,
                      decoration: BoxDecoration(
                        gradient: new LinearGradient(
                            colors: [
                              const Color(0xFF82C3F1),
                              const Color(0xFF7DA0F3),
                            ],
                            begin: const FractionalOffset(0.0, 0.0),
                            end: const FractionalOffset(1.0, 0.0),
                            stops: [0.0, 1.0],
                            tileMode: TileMode.clamp),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 16.0,
                          horizontal: 16.0,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            CircleAvatar(
                              radius: 30.0,
                              backgroundImage:
                                  AssetImage('assets/img/logo.png'),
                              backgroundColor: Colors.transparent,
                            ),
                            SizedBox(
                              width: 16.0,
                            ),
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(p[i].namaPeserta,
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold)),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Text('Team : ' + p[i].team,
                                      maxLines: 2,
                                      style: TextStyle(
                                        color: Colors.white,
                                      )),
                                  Text('Babak : ' + p[i].nama,
                                      style: TextStyle(
                                        color: Colors.white,
                                      )),
                                  Text('Kategori : ' + p[i].kategori,
                                      style: TextStyle(
                                        color: Colors.white,
                                      )),
                                  SizedBox(
                                    height: 8,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 16.0,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 32,
                    top: 20,
                    child: Text(
                      p[i].noTarget,
                      style: TextStyle(
                          fontSize: 24.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Positioned(
                    right: 32,
                    bottom: 20,
                    child: (p[i].kategori == 'Nasional')
                        ? Text(
                            p[i].jarak.toString(),
                            style: TextStyle(
                                fontSize: 24.0,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          )
                        : Text(
                            p[i].sesi.toString(),
                            style: TextStyle(
                                fontSize: 24.0,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                  )
                ])
              : SizedBox.shrink();
        });
  }
}
