import 'dart:io';
import 'dart:convert';

import 'package:image_picker/image_picker.dart';

import '../backend/api_requests/api_calls.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:html/dom.dart' as dom;

import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:async/async.dart';

import '../menu_mekanik/menu_mekanik_widget.dart';
import '../repai_repor_m_e_k_a_n_i_k/repai_repor_m_e_k_a_n_i_k_widget.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class Chatv2Widget extends StatefulWidget {
  const Chatv2Widget({
    Key? key,
    this.ticketid,
  }) : super(key: key);

  final String? ticketid;

  @override
  _Chatv2WidgetState createState() => _Chatv2WidgetState();
}

class _Chatv2WidgetState extends State<Chatv2Widget> {
  ScrollController _scrollController = ScrollController();
  String photoVar = '';
  TextEditingController? keteranganController;
  ApiCallResponse? responseTicketHistory;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  Completer<ApiCallResponse>? _apiRequestCompleter;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  IO.Socket? socket;
  String urlSocket = '192.168.1.17:3030';

  @override
  void initState() {
    super.initState();
    //IO Socket
    connect();
    //Var for Post
    keteranganController = TextEditingController();

    // On page load action.
    // print(FFAppState().authtoken);
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      responseTicketHistory = await GetHistoryApiIDTicketCall.call(
        authtoken: FFAppState().authtoken,
        id: FFAppState().IDTICKETSS,
      );
    });
  }

  void connect() async {
    // socket = IO.io("http://103.179.86.78:3030", <String,dynamic>{
    //   "transports" : ["websocket"],
    //   "autoConnect" : false,
    // });
    IO.Socket socket = IO.io(
        "http://192.168.1.17:3030",
        IO.OptionBuilder()
            .setTransports(['websocket']) // for Flutter or Dart VM
            .disableAutoConnect() // disable auto-connection
            .build());
    socket.connect();
    socket.onConnect((data) => print('Connected->WebSocket->Chats'));
    socket.onDisconnect((data) => print('disconect'));
    // print(socket.connected);
    socket.on("connect",
        (data) => socket.emit('masukRoom', "${FFAppState().IDTICKETSS}"));
    socket.on('BerhasilJoin', (data) async {
      print('Joins - $data');

    });
    socket.on('getNotif', (data) async {
      print('Notifs - $data');
      setState(() => _apiRequestCompleter = null);
      await waitForApiRequestCompleter();
      _scrollController.animateTo(
        0.0,
        curve: Curves.easeOut,
        duration: const Duration(milliseconds: 60),
      );
    });
    socket.on("chatReceived", (data) async {
      print('Dapat Data');
      print(data);
      setState(() => _apiRequestCompleter = null);
      await waitForApiRequestCompleter();
      _scrollController.animateTo(
        0.0,
        curve: Curves.easeOut,
        duration: const Duration(milliseconds: 60),
      );
    });
    // socket.emit("postChat", {'data': "success"});
    // print()
  }

  void sentMessage() async {
    IO.Socket socket = IO.io(
        "http://192.168.1.17:3030",
        IO.OptionBuilder()
            .setTransports(['websocket']) // for Flutter or Dart VM
            .disableAutoConnect() // disable auto-connection
            .build());
    // socket.onConnect((data) => print('Connected'));
    // socket.onDisconnect((data) => print('disconect'));
    print(socket.connected);
    socket.on("chatReceived", (data) => print(data));
    socket.emit("postChat",
        {'data': "success", 'namaRoom': "Ticket - ${FFAppState().IDTICKETSS}"});
    socket.emit("pushNotif", {
      'data': "pushNotif",
      'userId': "${FFAppState().idUsers}",
      'userRole': "${FFAppState().role}"
    });

    print("Sent With Post Socket");
  }

  void dispose() {
    keteranganController?.dispose();
    super.dispose();
  }

  final ImagePicker picker = ImagePicker();
  File? _image;
  dynamic bytes;

  addImage() async {
    final ImagePicker picker = ImagePicker();
    final File imagePicked = File(
        (await picker.pickImage(source: ImageSource.gallery, imageQuality: 50))!
            .path);
    setState(() {
      // _image = File(imagePicked!.path);
      // // _image = File(imagePicked!.path);
      // bytes = File(imagePicked.path).readAsBytesSync();

      photoVar = imagePicked!.path;
      _image = File(photoVar);
      // upload(File(imagePicked!.path));

      // String img64 = base64Encode(bytes);
      // photo = img64;
    });
  }

  uploadAll(File imageFile) async {
    String authtoken = FFAppState().authtoken;
    String id = FFAppState().IDTICKETSS;

    var stream =
        new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    var length = await imageFile.length();
    var request = http.MultipartRequest(
        "POST", Uri.parse("${FFAppState().UrlPost}/api/api-history-ticket"));

    if (keteranganController!.text.isEmpty) {
      String text = '.';
      keteranganController!.text = text;
    } else {
      keteranganController!.text = keteranganController!.text;
    }

    request.fields.addAll({
      'tb_tiketing_id': id,
      'judul': "s",
      'keterangan': keteranganController!.text,
    });
    // request.files.add(await http.MultipartFile.fromPath('photo', imageFile.path));
    request.headers.addAll({'Authorization': 'Bearer ${authtoken}'});

    var multipartFile = new http.MultipartFile('photo', stream, length,
        filename: basename(imageFile.path));

    request.files.add(multipartFile);
    var response = await request.send();
    print(response.statusCode);

    response.stream.transform(utf8.decoder).listen((value) {
      print(value);
    });

    if (response.statusCode == 200) {
      sentMessage();

      setState(() => _apiRequestCompleter = null);
      await waitForApiRequestCompleter();
      _scrollController.animateTo(
        0.0,
        curve: Curves.easeOut,
        duration: const Duration(milliseconds: 60),
      );
      keteranganController!.clear();
      photoVar = '';

      return Text("Terkirim");
    } else {
      throw Exception('Gagal Terkirim');
    }
  }

  uploadText() async {
    String authtoken = FFAppState().authtoken;
    String id = FFAppState().IDTICKETSS;

    var request = http.MultipartRequest(
        "POST", Uri.parse("${FFAppState().UrlPost}/api/api-history-ticket"));

    if (keteranganController!.text.isEmpty) {
      String text = '.';
      keteranganController!.text = text;
    } else {
      keteranganController!.text = keteranganController!.text;
    }

    request.fields.addAll({
      'tb_tiketing_id': id,
      'judul': "s",
      'keterangan': keteranganController!.text,
    });
    // request.files.add(await http.MultipartFile.fromPath('photo', imageFile.path));
    request.headers.addAll({'Authorization': 'Bearer ${authtoken}'});

    var response = await request.send();
    print(response.statusCode);
    response.stream.transform(utf8.decoder).listen((value) {
      print(value);
    });

    if (response.statusCode == 200) {
      sentMessage();
      setState(() => _apiRequestCompleter = null);
      await waitForApiRequestCompleter();
      _scrollController.animateTo(
        0.0,
        curve: Curves.easeOut,
        duration: const Duration(milliseconds: 60),
      );
      keteranganController!.clear();
      photoVar = '';

      return Text("Terkirim");
    } else {
      throw Exception('Gagal Terkirim');
    }
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
      appBar: AppBar(
        backgroundColor: Color(0xFFFF7B54),
        automaticallyImplyLeading: false,
        leading: FlutterFlowIconButton(
          borderColor: Colors.transparent,
          borderRadius: 30,
          borderWidth: 1,
          buttonSize: 60,
          icon: Icon(
            Icons.arrow_back_rounded,
            color: Colors.white,
            size: 30,
          ),
          onPressed: () async {
            IO.Socket socket = IO.io(
                "http://192.168.1.17:3030",
                IO.OptionBuilder()
                    .setTransports(['websocket']) // for Flutter or Dart VM
                    .disableAutoConnect() // disable auto-connection
                    .build());
            socket.disconnect();
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MenuMekanikWidget(),
              ),
            );
            FFAppState().update(() {
              FFAppState().IDTICKETSS = '';
            });
          },
        ),
        title: FutureBuilder<ApiCallResponse>(
          future: GetHistoryApiIDTicketCall.call(
            authtoken: FFAppState().authtoken,
            id: FFAppState().IDTICKETSS,
          ),
          builder: (context, snapshot) {
            // Customize what your widget looks like when it's loading.
            if (!snapshot.hasData) {
              return Center(
                child: SizedBox(
                  width: 50,
                  height: 50,
                  child: CircularProgressIndicator(
                    color: FlutterFlowTheme.of(context).primaryColor,
                  ),
                ),
              );
            }
            final supportsGetHistoryApiIDTicketResponse = snapshot.data!;
            print(GetHistoryApiIDTicketCall.idTicket(
              supportsGetHistoryApiIDTicketResponse.jsonBody,
            ).toString());
            return Text(
              FFAppState().IDTICKETSS,
              style: FlutterFlowTheme.of(context).title2.override(
                    fontFamily: 'Poppins',
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
            );
          },
        ),
        actions: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 20, 0),
            child: Container(
              width: 40,
              height: 40,
              child: FloatingActionButton(
                onPressed: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RepaiReporMEKANIKWidget(),
                    ),
                  );
                },
                child: Icon(
                  Icons.file_present_sharp,
                  color: Colors.white,
                  size: 40,
                ),
                backgroundColor: Colors.transparent,
                elevation: 0,
              ),
            ),
          ),
        ],
        centerTitle: false,
        elevation: 2,
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 1),
                  child: FutureBuilder<ApiCallResponse>(
                    future: GetHistoryApiIDTicketCall.call(
                      authtoken: FFAppState().authtoken,
                      id: FFAppState().IDTICKETSS,
                    ),
                    builder: (context, snapshot) {
                      // Customize what your widget looks like when it's loading.
                      if (!snapshot.hasData) {
                        return Center(
                          child: SizedBox(
                            width: 50,
                            height: 50,
                            child: CircularProgressIndicator(
                              color: FlutterFlowTheme.of(context).primaryColor,
                            ),
                          ),
                        );
                      }
                      final textGetHistoryApiIDTicketResponse = snapshot.data!;
                      return Text(
                        GetHistoryApiIDTicketCall.judul(
                                  textGetHistoryApiIDTicketResponse.jsonBody,
                                ).toString() ==
                                'null'
                            ? 'Reconnecting'
                            : GetHistoryApiIDTicketCall.judul(
                                textGetHistoryApiIDTicketResponse.jsonBody,
                              ).toString(),
                        style: FlutterFlowTheme.of(context).bodyText1.override(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold,
                            ),
                      );
                    },
                  ),
                ),
                Stack(
                  children: [
                    GestureDetector(
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 568,
                        decoration: BoxDecoration(
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                        ),
                        child: FutureBuilder<ApiCallResponse>(
                          future: (_apiRequestCompleter ??=
                                  Completer<ApiCallResponse>()
                                    ..complete(GetHistoryApiIDTicketCall.call(
                                      authtoken: FFAppState().authtoken,
                                      id: FFAppState().IDTICKETSS,
                                    )))
                              .future,
                          builder: (context, snapshot) {
                            // Customize what your widget looks like when it's loading.
                            if (!snapshot.hasData) {
                              return Center(
                                child: SizedBox(
                                  width: 50,
                                  height: 50,
                                  child: CircularProgressIndicator(
                                    color: FlutterFlowTheme.of(context)
                                        .primaryColor,
                                  ),
                                ),
                              );
                            }
                            final listViewGetHistoryApiIDTicketResponse =
                                snapshot.data!;
                            return Builder(
                              builder: (context) {
                                final chatsLV = getJsonField(
                                  listViewGetHistoryApiIDTicketResponse
                                      .jsonBody,
                                  r'''$.datas''',
                                ).toList();
                                return RefreshIndicator(
                                  onRefresh: () async {
                                    setState(() => _apiRequestCompleter = null);
                                    await waitForApiRequestCompleter();
                                  },
                                  child: ListView.builder(
                                    controller: _scrollController,
                                    padding: EdgeInsets.zero,
                                    reverse: true,
                                    shrinkWrap: true,
                                    scrollDirection: Axis.vertical,
                                    itemCount: chatsLV.length,
                                    itemBuilder: (context, chatsLVIndex) {
                                      final chatsLVItem = chatsLV[chatsLVIndex];
                                      return Card(
                                        clipBehavior:
                                            Clip.antiAliasWithSaveLayer,
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryBackground,
                                        child: SingleChildScrollView(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(16, 3, 0, 0),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0, 0, 0, 0),
                                                      child: Container(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.85,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                        ),
                                                        child: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              children: [
                                                                Text(
                                                                  getJsonField(
                                                                    chatsLVItem,
                                                                    r'''$.created_at''',
                                                                  ).toString(),
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyText1
                                                                      .override(
                                                                        fontFamily:
                                                                            'Poppins',
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .secondaryText,
                                                                        fontSize:
                                                                            10,
                                                                        fontWeight:
                                                                            FontWeight.normal,
                                                                      ),
                                                                ),
                                                              ],
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0,
                                                                          0,
                                                                          0,
                                                                          5),
                                                              child: Container(
                                                                width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width,
                                                                child: Column(
                                                                  children: [
                                                                    Padding(
                                                                      padding: EdgeInsetsDirectional
                                                                          .fromSTEB(
                                                                              0,
                                                                              0,
                                                                              0,
                                                                              1),
                                                                      child:
                                                                          Row(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.start,
                                                                        children: [
                                                                          Container(
                                                                            height:
                                                                                MediaQuery.of(context).size.height * 0.03,
                                                                            constraints:
                                                                                BoxConstraints(
                                                                              maxWidth: MediaQuery.of(context).size.width * 0.2,
                                                                            ),
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              color: FlutterFlowTheme.of(context).alternate,
                                                                              borderRadius: BorderRadius.circular(3),
                                                                            ),
                                                                            child:
                                                                                Padding(
                                                                              padding: EdgeInsetsDirectional.fromSTEB(2, 1, 2, 0),
                                                                              child: Text(
                                                                                getJsonField(
                                                                                  chatsLVItem,
                                                                                  r'''$.jabatan''',
                                                                                ).toString(),
                                                                                textAlign: TextAlign.center,
                                                                                style: FlutterFlowTheme.of(context).bodyText1.override(
                                                                                      fontFamily: 'Poppins',
                                                                                      color: FlutterFlowTheme.of(context).primaryBtnText,
                                                                                      fontSize: 12,
                                                                                    ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    Row(
                                                                      children: [
                                                                        Padding(
                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                              0,
                                                                              0,
                                                                              3,
                                                                              0),
                                                                          child:
                                                                              Text(
                                                                            getJsonField(
                                                                              chatsLVItem,
                                                                              r'''$.name''',
                                                                            ).toString(),
                                                                            style: FlutterFlowTheme.of(context).bodyText1.override(
                                                                                  fontFamily: 'Poppins',
                                                                                  fontWeight: FontWeight.bold,
                                                                                ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                            Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              children: [
                                                                Container(
                                                                    width: MediaQuery.of(
                                                                                context)
                                                                            .size
                                                                            .width *
                                                                        0.85,
                                                                    constraints:
                                                                        BoxConstraints(
                                                                      maxHeight:
                                                                          MediaQuery.of(context).size.height *
                                                                              0.5,
                                                                    ),
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .secondaryBackground,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              13),
                                                                    ),
                                                                    child: Html(
                                                                      data:
                                                                          getJsonField(
                                                                        chatsLVItem,
                                                                        r'''$.keterangan''',
                                                                      ).toString(),
                                                                    )),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.9,
                                                decoration: BoxDecoration(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryBackground,
                                                  boxShadow: [
                                                    BoxShadow(
                                                      blurRadius: 0,
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .secondaryText,
                                                      offset: Offset(0, 1),
                                                    )
                                                  ],
                                                ),
                                                child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                12, 12, 12, 12),
                                                    child: CachedNetworkImage(
                                                      imageUrl: getJsonField(
                                                        chatsLVItem,
                                                        r'''$.history_photo_url''',
                                                      ),
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.55,
                                                      fit: BoxFit.fitWidth,
                                                      // placeholder: (context, url) => CircularProgressIndicator(),
                                                      errorWidget: (context,
                                                              url, error) =>
                                                          Container(),
                                                    )),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                Align(
                  alignment: AlignmentDirectional(0.7, 0.98),
                  child: Row(
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          addImage();
                        },
                        child: Container(
                          height: 40,
                          width: 40,
                          margin: EdgeInsets.only(left: 6),
                          decoration: BoxDecoration(
                            color: Colors.lightBlue,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Icon(
                            Icons.add_photo_alternate_sharp,
                            color: Colors.white,
                            size: 27,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Form(
                        key: _formKey,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        child: Expanded(
                          child: TextField(
                            controller: keteranganController,
                            decoration: InputDecoration(
                                hintText: "Write message...",
                                hintStyle: TextStyle(color: Colors.black54),
                                border: InputBorder.none),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      FloatingActionButton(
                        onPressed: () async {
                          // keteranganController?.clear();
                          if (photoVar.isNotEmpty) {
                            if (keteranganController!.text.isEmpty) {
                              keteranganController!.text = '.';
                            }
                            uploadAll(File(photoVar));
                          }
                          if (keteranganController!.text.isNotEmpty) {
                            uploadText();
                          }
                          print(File(photoVar));
                          print(keteranganController!.text);
                        },
                        child: Icon(
                          Icons.send,
                          color: Colors.white,
                          size: 18,
                        ),
                        backgroundColor: Colors.blue,
                        elevation: 0,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future waitForApiRequestCompleter({
    double minWait = 0,
    double maxWait = double.infinity,
  }) async {
    final stopwatch = Stopwatch()..start();
    while (true) {
      await Future.delayed(Duration(milliseconds: 100));
      final timeElapsed = stopwatch.elapsedMilliseconds;
      final requestComplete = _apiRequestCompleter?.isCompleted ?? false;
      if (timeElapsed > maxWait || (requestComplete && timeElapsed > minWait)) {
        break;
      }
    }
  }
}
