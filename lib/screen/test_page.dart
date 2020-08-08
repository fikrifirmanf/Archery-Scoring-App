import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:scoring_panahan/bloc/skor_bloc/bloc.dart';
import 'package:scoring_panahan/widget/key_keyboard.dart';
import 'package:scoring_panahan/widget/keyboard_widget.dart';
import 'package:solid_bottom_sheet/solid_bottom_sheet.dart';

class TestPage extends StatefulWidget {
  String sesi, seri, uuidRules, uuidPeserta, noTarget, namaPeserta;
  int jmlPanah;
  TestPage({
    this.sesi,
    this.seri,
    this.uuidRules,
    this.uuidPeserta,
    this.noTarget,
    this.jmlPanah,
    this.namaPeserta,
  });
  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  List<int> _myList = List();
  TextEditingController _myController = TextEditingController();
  SolidController _controller = SolidController();
  String _result = "";
  String _inputList = "";
  List<int> _hsl = List();
  String _seri;

  setSum(int value) {
    int sum = 0;
    _myList.add(value);
    for (int i = 0; i < _myList.length; i++) {
      sum += _myList[i];
      if (i == 0)
        _inputList = "${_myList[i]}";
      else
        _inputList = _inputList + "${_myList[i]}";
    }
    _result = '$sum';
  }

  @override
  void initState() {
    super.initState();
    _myList.clear();
  }

  final focus = FocusNode();
  void _showDialogMasuk() async {
    // flutter defined function
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
            title: new Text("Sukses!"), content: Text('Input skor sukses!'));
      },
    ).then((val) {
      Navigator.pop(context);
    });
  }

  void _showDialogGagalk() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Oops!"),
          content: new Text("Mungkin anda sudah input"),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 20) / 3;
    final double itemWidth = size.width / 3;
    return BlocListener<SkorBloc, SkorState>(
      listener: (context, state) {
        if (state is Loading) {
          Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        if (state is Success) {
          print('suksesesse');

          _showDialogMasuk();
        } else if (state is Failed) {
          _showDialogGagalk();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.noTarget + ' ' + widget.namaPeserta),
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
        bottomSheet: (_myList.length >= widget.jmlPanah)
            ? SizedBox.shrink()
            : SolidBottomSheet(
                autoSwiped: true,
                showOnAppear: true,
                maxHeight: MediaQuery.of(context).size.height / 3.45,
                controller: _controller,
                draggableBody: true,
                body: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Container(
                        padding: EdgeInsets.only(top: 16),
                        decoration: new BoxDecoration(
                          border: Border(),
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
                        child: GridView.count(
                            crossAxisCount: 4,
                            childAspectRatio: (itemHeight / itemWidth),
                            controller:
                                ScrollController(keepScrollOffset: false),
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            children: [
                              GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      setSum(10);
                                      if (_myList.length > widget.jmlPanah) {
                                        _myList.removeLast();
                                      }
                                      print(_myList);
                                    });
                                  },
                                  child: KeyKeyboard(symbol: Keys.x)),
                              GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      setSum(int.parse((Keys.ten.toString())));
                                      if (_myList.length > widget.jmlPanah) {
                                        _myList.removeLast();
                                      }
                                      print(_myList);
                                    });
                                  },
                                  child: KeyKeyboard(symbol: Keys.ten)),
                              GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      setSum(int.parse((Keys.nine.toString())));
                                      if (_myList.length > widget.jmlPanah) {
                                        _myList.removeLast();
                                      }
                                      print(_myList);
                                    });
                                  },
                                  child: KeyKeyboard(symbol: Keys.nine)),
                              GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      setSum(
                                          int.parse((Keys.eight.toString())));
                                      if (_myList.length > widget.jmlPanah) {
                                        _myList.removeLast();
                                      }
                                      print(_myList);
                                    });
                                  },
                                  child: KeyKeyboard(symbol: Keys.eight)),
                              GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      setSum(
                                          int.parse((Keys.seven.toString())));
                                      if (_myList.length > widget.jmlPanah) {
                                        _myList.removeLast();
                                      }
                                      print(_myList);
                                    });
                                  },
                                  child: KeyKeyboard(symbol: Keys.seven)),
                              GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      setSum(int.parse((Keys.six.toString())));
                                      if (_myList.length > widget.jmlPanah) {
                                        _myList.removeLast();
                                      }
                                      print(_myList);
                                    });
                                  },
                                  child: KeyKeyboard(symbol: Keys.six)),
                              GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      setSum(int.parse((Keys.five.toString())));
                                      if (_myList.length > widget.jmlPanah) {
                                        _myList.removeLast();
                                      }
                                      print(_myList);
                                    });
                                  },
                                  child: KeyKeyboard(symbol: Keys.five)),
                              GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      setSum(int.parse((Keys.four.toString())));
                                      if (_myList.length > widget.jmlPanah) {
                                        _myList.removeLast();
                                      }
                                      print(_myList);
                                    });
                                  },
                                  child: KeyKeyboard(symbol: Keys.four)),
                              GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      setSum(
                                          int.parse((Keys.three.toString())));
                                      if (_myList.length > widget.jmlPanah) {
                                        _myList.removeLast();
                                      }
                                      print(_myList);
                                    });
                                  },
                                  child: KeyKeyboard(symbol: Keys.three)),
                              GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      setSum(int.parse((Keys.two.toString())));
                                      if (_myList.length > widget.jmlPanah) {
                                        _myList.removeLast();
                                      }
                                      print(_myList);
                                    });
                                  },
                                  child: KeyKeyboard(symbol: Keys.two)),
                              GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      setSum(int.parse((Keys.one.toString())));
                                      if (_myList.length > widget.jmlPanah) {
                                        _myList.removeLast();
                                      }
                                      print(_myList);
                                    });
                                  },
                                  child: KeyKeyboard(symbol: Keys.one)),
                              GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      setSum(0);
                                      if (_myList.length > widget.jmlPanah) {
                                        _myList.removeLast();
                                      }
                                      print(_myList);
                                    });
                                  },
                                  child: KeyKeyboard(symbol: Keys.m)),
                            ])),
                  ],
                ),
              ),
        body: SafeArea(
          top: false,
          child: ListView(
            padding: EdgeInsets.symmetric(
              vertical: 16.0,
              horizontal: 16.0,
            ),
            children: <Widget>[
              Center(
                child: Column(
                  children: <Widget>[
                    Text('Skor (${widget.jmlPanah})x panah'),
                    SizedBox(height: 8.0),
                    Container(
                      height: 40,
                      child: (_myList.length <= 0)
                          ? ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: widget.jmlPanah,
                              itemBuilder: (context, i) {
                                return Center(
                                    child: Container(
                                  width: 40,
                                  height: 40,
                                  margin: EdgeInsets.symmetric(
                                    vertical: 4.0,
                                    horizontal: 8.0,
                                  ),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(color: Colors.grey)),
                                  child: Center(
                                    child: Text(
                                      "",
                                      style: TextStyle(fontSize: 25.0),
                                    ),
                                  ),
                                ));
                              })
                          : ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: _myList.length,
                              itemBuilder: (context, i) {
                                return Center(
                                    child: Container(
                                  width: 40,
                                  height: 40,
                                  margin: EdgeInsets.symmetric(
                                    vertical: 4.0,
                                    horizontal: 8.0,
                                  ),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(color: Colors.grey)),
                                  child: Center(
                                    child: Text(
                                      _myList[i].toString(),
                                      style: TextStyle(fontSize: 25.0),
                                    ),
                                  ),
                                ));
                              }),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8.0),
              Center(
                child: Text("Total"),
              ),
              Center(
                child: Container(
                  child: Text(
                    (_result == "" || _myList.isEmpty) ? '0' : _result,
                    style: TextStyle(fontSize: 40.0),
                  ),
                ),
              ),
              SizedBox(height: 8.0),
              Center(
                child: Text("Pilih Seri"),
              ),
              SizedBox(height: 8.0),
              CustomRadioButton(
                buttonColor: Colors.blue,
                buttonLables: List.generate(
                    int.parse(widget.seri), (e) => (e + 1).toString()),
                buttonValues: List.generate(
                    int.parse(widget.seri), (e) => (e + 1).toString()),
                horizontal: false,
                enableShape: true,
                elevation: 3,
                hight: 50,
                width: 120,
                radioButtonValue: (value) {
                  setState(() {
                    _seri = value;
                  });
                },
                selectedColor: Colors.yellow[600],
              ),
              SizedBox(
                height: 16,
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _myList.removeLast();
                  });
                },
                child: Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: 8.0,
                  ),
                  decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(20)),
                  height: 50,
                  width: 50,
                  child: Icon(
                    Icons.backspace,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              (_myList.length != widget.jmlPanah || _seri == null)
                  ? SizedBox.shrink()
                  : ButtonTheme(
                      height: 50,
                      minWidth: 50,
                      child: MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        color: Color(0xFFDB6AF4),
                        onPressed: () {
                          print('Total $_seri : ' + _result);
                          print('Sesi  : ' + widget.sesi);
                          print('Uuid Pes  : ' + widget.uuidPeserta);
                          print('Uuid Rules  : ' + widget.uuidRules);

                          BlocProvider.of<SkorBloc>(context)
                              .add(InsertSkorEvent(
                            sesi: widget.sesi,
                            seri: _seri,
                            uuidRules: widget.uuidRules,
                            uuidPeserta: widget.uuidPeserta,
                            totalSeri: int.parse(_result),
                          ));
                        },
                        child: Text(
                          'Kirim seri ${_seri}',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
