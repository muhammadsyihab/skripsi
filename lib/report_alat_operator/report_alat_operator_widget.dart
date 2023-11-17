import 'dart:convert';
import 'dart:io';

import 'package:aneka/daftar_catatan_daily_operator/daftar_catatan_daily_operator_widget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quickalert/quickalert.dart';

import '../backend/api_requests/api_calls.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../menu_operatorv2/menu_operatorv2_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:async/async.dart';

class ReportAlatOperatorWidget extends StatefulWidget {
  const ReportAlatOperatorWidget({Key? key}) : super(key: key);

  @override
  _ReportAlatOperatorWidgetState createState() =>
      _ReportAlatOperatorWidgetState();
}

class _ReportAlatOperatorWidgetState extends State<ReportAlatOperatorWidget> {
  ApiCallResponse? aPITicket;
  LatLng? currentUserLocationValue;
  TextEditingController? namaUnitController;
  TextEditingController? shortBioController;
  final _unfocusNode = FocusNode();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    shortBioController = TextEditingController();
  }

  @override
  void dispose() {
    _unfocusNode.dispose();
    namaUnitController?.dispose();
    shortBioController?.dispose();
    super.dispose();
  }
  File? _image;
  dynamic bytes;
  String photoVar = '';
  Future addImage() async {
    final ImagePicker picker = ImagePicker();
    final File imagePicked = File(
        (await picker.pickImage(source: ImageSource.gallery, imageQuality: 50))!
            .path);
    setState(() {
      _image = File(imagePicked!.path);
      // _image = File(imagePicked!.path);
      bytes = File(imagePicked.path).readAsBytesSync();

      photoVar = imagePicked!.path;
      // upload(File(imagePicked!.path));

      // String img64 = base64Encode(bytes);
      // photo = img64;
    });
  }

  String? master_unit_id;
  String? respon;
  String? messages;



  @override
  Widget build(BuildContext context) {
    upload({required File imageFile,required String master_unit_id}) async{
      String authtoken = FFAppState().authtoken;
      String latLong = FFAppState().latLong;
      print(latLong);
      print(master_unit_id);
      print(shortBioController!.text);
      // String Id = master_unit_id ?? '';


      var stream = new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
      var length = await imageFile.length();
      var request = http.MultipartRequest("POST", Uri.parse("http://103.179.86.78:8000/api/api-ticket"));

      request.fields.addAll({
        'master_unit_id' : master_unit_id,
        'judul' : shortBioController!.text,
        'latlong': latLong,
      });
      request.headers.addAll({'Authorization': 'Bearer ${authtoken}'});

      var multipartFile = new http.MultipartFile('photo', stream, length,
          filename: basename(imageFile.path));
      request.files.add(multipartFile);
      var response = await request.send();

      final respon = response.statusCode;
      // print(response.statusCode);
      response.stream.transform(utf8.decoder).listen((value) {
        // print(value);
        messages = value;
        print(messages);
      });

      if (respon == 200) {
        await QuickAlert.show(
            context: context,
            type: QuickAlertType.loading,
            title: 'Loading',
            text: 'Mengirim Data',
            autoCloseDuration: Duration(seconds: 3)
        );
        await Future.delayed(const Duration(milliseconds: 500), () {
          return  QuickAlert.show(
            context: context,
            type: QuickAlertType.success,
            title: 'Terkirim',
            text: messages,
            confirmBtnText: 'Kembali',
            onConfirmBtnTap: 	() async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MenuOperatorv2Widget(),
                ),
              );
            },
          );
        });
      }
      if (respon == 400) {
        await QuickAlert.show(
            context: context,
            type: QuickAlertType.loading,
            title: 'Loading',
            text: 'Mengirim Data',
            autoCloseDuration: Duration(seconds: 3)
        );
        await Future.delayed(const Duration(milliseconds: 500), () {
          return  QuickAlert.show(
            context: context,
            type: QuickAlertType.warning,
            title: 'Gagal Terkirim',
            text: messages,
          );
        });

      }if (respon == 500) {
        await QuickAlert.show(
            context: context,
            type: QuickAlertType.loading,
            title: 'Loading',
            text: 'Mengirim Data',
            autoCloseDuration: Duration(seconds: 3)
        );
        await Future.delayed(const Duration(milliseconds: 500), () {
          return  QuickAlert.show(
            context: context,
            type: QuickAlertType.warning,
            title: 'Server Error',
            text: messages,
          );
        });
      }
    }
    context.watch<FFAppState>();


    return FutureBuilder<ApiCallResponse>(
      future: GetJadwalAllCall.call(
        authtoken: FFAppState().authtoken,
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
        final reportAlatOperatorGetJadwalAllResponse = snapshot.data!;
        return Scaffold(
          key: scaffoldKey,
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Color(0xFF0A55C0),
            automaticallyImplyLeading: false,
            leading: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 0, 12, 0),
              child: FlutterFlowIconButton(
                borderColor: Colors.transparent,
                borderRadius: 30,
                buttonSize: 48,
                icon: Icon(
                  Icons.keyboard_backspace,
                  color: Colors.white,
                  size: 30,
                ),
                onPressed: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DaftarCatatanDailyOperatorWidget(),
                    ),
                  );
                },
              ),
            ),
            title: Text(
              'Form Lapor Kerusakan',
              style: FlutterFlowTheme.of(context).title2.override(
                fontFamily: 'Outfit',
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            actions: [],
            centerTitle: false,
            elevation: 0,
          ),
          body: SafeArea(
            child: GestureDetector(
              onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
              child: Form(
                key: formKey,
                autovalidateMode: AutovalidateMode.disabled,
                child: ListView(
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding:
                          EdgeInsetsDirectional.fromSTEB(16, 25, 16, 0),
                          child: FutureBuilder<ApiCallResponse>(
                            future: GetJadwalAllCall.call(
                              authtoken: FFAppState().authtoken,
                            ),
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
                              final namaUnitGetJadwalAllResponse =
                              snapshot.data!;
                              return Container(
                                width: MediaQuery.of(context).size.width * 0.9,
                                child: TextFormField(
                                  controller: namaUnitController ??=
                                      TextEditingController(
                                        text: GetJadwalAllCall.noLambungjadwal(
                                          namaUnitGetJadwalAllResponse.jsonBody,
                                        ).toString() != 'null' ? GetJadwalAllCall.noLambungjadwal(
                                          namaUnitGetJadwalAllResponse.jsonBody,
                                        ).toString() : '....' ,
                                      ),
                                  readOnly: true,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    labelText: 'Nomor Lambung',
                                    labelStyle: FlutterFlowTheme.of(context)
                                        .title3
                                        .override(
                                      fontFamily: 'Outfit',
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.normal,
                                    ),
                                    hintText: GetJadwalAllCall.noLambungjadwal(
                                      namaUnitGetJadwalAllResponse.jsonBody,
                                    ).toString() == 'null' ? '....'  : GetJadwalAllCall.noLambungjadwal(
                                      namaUnitGetJadwalAllResponse.jsonBody,
                                    ).toString(),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.black,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.black,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0x00000000),
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0x00000000),
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    contentPadding:
                                    EdgeInsetsDirectional.fromSTEB(
                                        20, 0, 20, 0),
                                  ),
                                  style: FlutterFlowTheme.of(context)
                                      .title3
                                      .override(
                                    fontFamily: 'Outfit',
                                    color: Color(0xFF14181B),
                                    fontSize: 20,
                                    fontWeight: FontWeight.normal,
                                  ),
                                  textAlign: TextAlign.start,
                                ),
                              );
                            },
                          ),
                        ),
                        Padding(
                          padding:
                          EdgeInsetsDirectional.fromSTEB(16, 25, 16, 0),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.9,
                            child: TextFormField(
                              controller: shortBioController,
                              obscureText: false,
                              decoration: InputDecoration(
                                labelText: 'Judul Kerusakan',
                                hintText: 'Masukan Keterangan Kerusakan',
                                hintStyle: FlutterFlowTheme.of(context)
                                    .bodyText2
                                    .override(
                                  fontFamily: 'Outfit',
                                  color: Color(0xFF57636C),
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0x00000000),
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0x00000000),
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                contentPadding: EdgeInsetsDirectional.fromSTEB(
                                    20, 32, 20, 12),
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .bodyText1
                                  .override(
                                fontFamily: 'Outfit',
                                color: Color(0xFF14181B),
                                fontSize: 20,
                                fontWeight: FontWeight.normal,
                              ),
                              textAlign: TextAlign.start,
                              maxLines: 4,
                            ),
                          ),
                        ),
                        SizedBox.fromSize(size: Size.fromHeight(20),),
                        Center(
                          child: Column(
                            children: [
                              SizedBox(
                                height: 15,
                              ),
                              Text('Upload Gambar',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                      color: Colors.black)),
                              SizedBox(
                                height: 10,
                              ),
                              Center(
                                child: Container(
                                  margin: const EdgeInsets.all(15.0),
                                  decoration: BoxDecoration(
                                      color: Colors.white38,
                                      border: Border.all(
                                          color: Colors.black,
                                          width: 2)),
                                  width: 300,
                                  height: 270,
                                  child: InkWell(
                                    onTap: () {
                                      addImage();
                                    },
                                    child: _image != null
                                        ? Image.file(
                                      _image!,
                                      fit: BoxFit.cover,
                                    )
                                        : Image.asset(
                                      'assets/images/upload.png',
                                      scale: 15,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox.fromSize(
                                size: Size.fromHeight(40),
                              ),
                            ],
                          ),
                        ),
                        SizedBox.fromSize(size: Size.fromHeight(35),),
                        Align(
                          alignment: AlignmentDirectional(0, -0.15),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.66,
                            height: MediaQuery.of(context).size.height * 0.05,
                            decoration: BoxDecoration(
                              color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                            ),
                            child: FFButtonWidget(
                              onPressed: () async {
                                
                                upload(imageFile: File(photoVar),master_unit_id: GetJadwalAllCall.idUnit(
                                      reportAlatOperatorGetJadwalAllResponse.jsonBody,
                                    ).toString().replaceAll('[', '').replaceAll(']', ''));
                                print(upload);

                                // aPITicket = await ApiticketCall.call(
                                //   authtoken: FFAppState().authtoken,
                                //   masterUnitId: GetJadwalAllCall.idUnit(
                                //     reportAlatOperatorGetJadwalAllResponse.jsonBody,
                                //   ).toString(),
                                //   judul: shortBioController!.text,
                                // );
                                if ((aPITicket?.succeeded ?? true)) {
                                  // ScaffoldMessenger.of(context).showSnackBar(
                                  //   SnackBar(
                                  //     content: Text(
                                  //       ApiticketCall.getMessages(
                                  //         (aPITicket?.jsonBody ?? ''),
                                  //       ).toString(),
                                  //       style: TextStyle(
                                  //         color: FlutterFlowTheme.of(context)
                                  //             .primaryText,
                                  //       ),
                                  //     ),
                                  //     duration: Duration(milliseconds: 4000),
                                  //     backgroundColor: FlutterFlowTheme.of(context)
                                  //         .secondaryColor,
                                  //   ),
                                  // );

                                } else {
                                  // ScaffoldMessenger.of(context).showSnackBar(
                                  //   SnackBar(
                                  //     content: Text(
                                  //       ApiticketCall.getMessages(
                                  //         (aPITicket?.jsonBody ?? ''),
                                  //       ).toString(),
                                  //       style: TextStyle(
                                  //         color: FlutterFlowTheme.of(context)
                                  //             .primaryText,
                                  //       ),
                                  //     ),
                                  //     duration: Duration(milliseconds: 4000),
                                  //     backgroundColor: Color(0xFFFB0505),
                                  //   ),
                                  // );
                                }

                                setState(() {});
                              },
                              text: 'Kirim',
                              options: FFButtonOptions(
                                width: 130,
                                height: 40,
                                color: FlutterFlowTheme.of(context).primaryColor,
                                textStyle:
                                FlutterFlowTheme.of(context).subtitle2.override(
                                  fontFamily: 'Poppins',
                                  color: Colors.white,
                                ),
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ),
                        SizedBox.fromSize(
                          size: Size.fromHeight(30),
                        ),
                      ],
                    ),

                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
