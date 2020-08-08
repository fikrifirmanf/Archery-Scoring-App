import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scoring_panahan/auth/bloc.dart';
import 'package:scoring_panahan/bloc/home_bloc/bloc.dart';
import 'package:scoring_panahan/models/panitia_models.dart';
import 'package:scoring_panahan/models/peserta_models.dart';
import 'package:scoring_panahan/repository/home_repo.dart';
import 'package:scoring_panahan/screen/detail_page.dart';
import 'package:scoring_panahan/screen/test_page.dart';
import 'package:scoring_panahan/widget/message_widget.dart';

class Home extends StatelessWidget {
  final HomeRepository homeRepository = HomeRepository();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.all(10),
            child: GestureDetector(
              onTap: () {
                BlocProvider.of<AuthBloc>(context).add(LoggedOut());
              },
              child: Icon(Icons.exit_to_app, color: Colors.white),
            ),
          )
        ],
        title: Text('Scoring Panahan'),
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

                    return _buildListView(context, pesertaModel, panitiaModel);
                  }
                },
              ),
            ),
          )),
    );
  }

  Widget _buildListView(
      BuildContext context, PesertaModel pm, PanitiaModel panitiaM) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    var p = pm.peserta;
    var pan = panitiaM.panitia[0];
    List<int> sesi = p.map((e) => e.sesi).toList();
    List<int> sesiDetail = sesi.toSet().toList();
    List<int> jarak = p.map((e) => e.jarak).toList();
    List<String> kategori = p.map((e) => e.kategori).toList();
    List<int> jarakDetail = jarak.toSet().toList();
    List<String> noTarget = p.map((e) => e.noTarget).toList();
    String noTargetDetail = noTarget.toSet().toString();
    String kategoriDetail = kategori.toSet().toString();
    List<String> kelas = p.map((e) => e.kelas).toList();
    String kelasDetail = kelas.toSet().toString();

    return ListView(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.0,
                  ),
                  child: Text(
                    'Username : ' + pan.username,
                    style: TextStyle(color: Colors.grey, fontSize: 18.0),
                  )),
              Divider(),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 16.0,
                ),
                child: (kategoriDetail != '')
                    ? Text(
                        'Kategori : ' +
                            kategoriDetail
                                .replaceAll('{', '')
                                .replaceAll('}', ''),
                        style: TextStyle(color: Colors.grey, fontSize: 18.0),
                      )
                    : Text(
                        'KATEGORI',
                        style: TextStyle(color: Colors.grey, fontSize: 18.0),
                      ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 16.0,
                ),
                child: (noTargetDetail != '')
                    ? Text(
                        'No target : ' +
                            noTargetDetail
                                .replaceAll('{', '')
                                .replaceAll('}', ''),
                        style: TextStyle(color: Colors.grey, fontSize: 18.0),
                      )
                    : Text(
                        'No Target',
                        style: TextStyle(color: Colors.grey, fontSize: 18.0),
                      ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 16.0,
                ),
                child: (kelasDetail != '')
                    ? Text(
                        'Tingkat : ' +
                            kelasDetail.replaceAll('{', '').replaceAll('}', ''),
                        style: TextStyle(color: Colors.grey, fontSize: 18.0),
                      )
                    : Text(
                        'No Target',
                        style: TextStyle(color: Colors.grey, fontSize: 18.0),
                      ),
              ),
            ],
          ),
        ),
        Divider(),
        ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: (kategoriDetail != '{Nasional}')
                ? sesiDetail.length
                : jarakDetail.length,
            itemBuilder: (context, i) {
              return Stack(children: [
                GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DetailPage(
                                  sesi: sesiDetail[i],
                                  jarak: jarakDetail[i],
                                ))),
                    child: Container(
                        margin: EdgeInsets.symmetric(
                          vertical: 8.0,
                          horizontal: 16.0,
                        ),
                        width: width,
                        height: height / 5,
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
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Center(
                            child: (kategoriDetail != '{Nasional}')
                                ? Text(
                                    'Jarak ${sesiDetail[i]}',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 28),
                                  )
                                : Text(
                                    'Jarak ${jarakDetail[i]} m',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 28),
                                  ))))
              ]);
            }),
      ],
    );
  }
}
