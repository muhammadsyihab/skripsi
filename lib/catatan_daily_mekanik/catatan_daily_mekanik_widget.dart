import 'dart:convert';
import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:quickalert/quickalert.dart';

import '../backend/api_requests/api_calls.dart';
import '../daftar_catatan_daily_mekanik/daftar_catatan_daily_mekanik_widget.dart';
import '../flutter_flow/flutter_flow_drop_down.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:async/async.dart';

class CatatanDailyMekanikWidget extends StatefulWidget {
  const CatatanDailyMekanikWidget({Key? key}) : super(key: key);

  @override
  _CatatanDailyMekanikWidgetState createState() =>
      _CatatanDailyMekanikWidgetState();
}

class _CatatanDailyMekanikWidgetState extends State<CatatanDailyMekanikWidget> {
  ApiCallResponse? dailymekanik;
  String? noLambungValue;
  String? jadwalValue;
  TextEditingController? judulController;
  TextEditingController? statusController;
  TextEditingController? perbaikanController;
  TextEditingController? perbaikanHMController;
  TextEditingController? keteranganController;
  String? photo;
  PickedFile? _pickedFile;
  final _unfocusNode = FocusNode();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    judulController = TextEditingController();
    statusController = TextEditingController();
    perbaikanController = TextEditingController();
    perbaikanHMController = TextEditingController();
    keteranganController = TextEditingController();
  }

  @override
  void dispose() {
    _unfocusNode.dispose();
    judulController?.dispose();
    statusController?.dispose();
    perbaikanController?.dispose();
    perbaikanHMController?.dispose();
    keteranganController?.dispose();
    super.dispose();
  }

  // for Image
  Future<File> saveFilePermanently(String imagePath) async {
    final directory = await getApplicationDocumentsDirectory();
    final name = basename(imagePath);
    final image = File('${directory.path}/$name');

    return File(imagePath).copy(image.path);
  }

  File? _image;
  dynamic bytes;
  String photoVar = '';
  Future getImageGalery() async {
    final ImagePicker picker = ImagePicker();
    final File imagePicked = File(
        (await picker.pickImage(source: ImageSource.gallery, imageQuality: 50))!
            .path);
    setState(() {
      _image = File(imagePicked!.path);
      // _image = File(imagePicked!.path);
      bytes = File(imagePicked.path).readAsBytesSync();

      photoVar = imagePicked!.path;
    });
  }

  String? id_jadwal;
  String? respon;
  String? messages;

  @override
  Widget build(BuildContext context) {
    upload({required File imageFile, required id_jadwal}) async {
      String authtoken = FFAppState().authtoken;
      print(id_jadwal);
      String dropdownStr = noLambungValue ?? '';

      var stream =
          new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
      var length = await imageFile.length();
      var request = http.MultipartRequest(
          "POST", Uri.parse("http://103.179.86.78:8000/api/daily/mekanik"));

      request.fields.addAll({
        'master_unit_id': dropdownStr,
        'kerusakan': judulController!.text,
        'perbaikan': perbaikanController!.text,
        'perbaikan_hm': perbaikanHMController!.text,
        'status': statusController!.text,
        'keterangan': keteranganController!.text,
        'tb_jadwal_id': id_jadwal,
      });

      request.headers.addAll({'Authorization': 'Bearer ${authtoken}'});

      var multipartFile = new http.MultipartFile('photo', stream, length,
          filename: basename(imageFile.path));
      request.files.add(multipartFile);
      var response = await request.send();
      final respon = response.statusCode;
      print(response.statusCode);

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
            autoCloseDuration: Duration(seconds: 3));
        await Future.delayed(const Duration(milliseconds: 500), () {
          return QuickAlert.show(
            context: context,
            type: QuickAlertType.success,
            title: 'Terkirim',
            text: messages,
            confirmBtnText: 'Kembali',
            onConfirmBtnTap: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DaftarCatatanDailyMekanikWidget(),
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
            autoCloseDuration: Duration(seconds: 3));
        await Future.delayed(const Duration(milliseconds: 500), () {
          return QuickAlert.show(
            context: context,
            type: QuickAlertType.warning,
            title: 'Gagal Terkirim',
            text: messages,
          );
        });
      }
      if (respon == 500) {
        await QuickAlert.show(
            context: context,
            type: QuickAlertType.loading,
            title: 'Loading',
            text: 'Mengirim Data',
            autoCloseDuration: Duration(seconds: 3));
        await Future.delayed(const Duration(milliseconds: 500), () {
          return QuickAlert.show(
            context: context,
            type: QuickAlertType.error,
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
        final catatanDailyMekanikGetUnitsResponse = snapshot.data!;
        return Scaffold(
          key: scaffoldKey,
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Color(0xFFFF7B54),
            automaticallyImplyLeading: false,
            leading: FlutterFlowIconButton(
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
                    builder: (context) => DaftarCatatanDailyMekanikWidget(),
                  ),
                );
              },
            ),
            title: Text(
              'Form Aktivitas Mekanik',
              style: FlutterFlowTheme.of(context).title2.override(
                    fontFamily: 'Outfit',
                    color: Colors.white,
                    fontSize: 25,
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
              child: Align(
                alignment: AlignmentDirectional(0, 0),
                child: Form(
                  key: formKey,
                  autovalidateMode: AutovalidateMode.disabled,
                  child: ListView(
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        16, 16, 16, 0),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.9,
                                      child: TextFormField(
                                        controller: judulController,
                                        obscureText: false,
                                        decoration: InputDecoration(
                                          labelText: 'Kerusakan',
                                          labelStyle:
                                              FlutterFlowTheme.of(context)
                                                  .title1
                                                  .override(
                                                    fontFamily: 'Outfit',
                                                    color: Colors.black,
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                          hintText: 'Kerusakan...',
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.black,
                                              width: 2,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.black,
                                              width: 2,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0x00000000),
                                              width: 2,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          focusedErrorBorder:
                                              OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0x00000000),
                                              width: 2,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          contentPadding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  20, 32, 20, 12),
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .title3
                                            .override(
                                              fontFamily: 'Outfit',
                                              color: Color(0xFF14181B),
                                              fontSize: 15,
                                              fontWeight: FontWeight.normal,
                                            ),
                                        textAlign: TextAlign.start,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        16, 16, 16, 0),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.9,
                                      child: TextFormField(
                                        controller: statusController,
                                        obscureText: false,
                                        decoration: InputDecoration(
                                          labelText: 'Status',
                                          labelStyle:
                                              FlutterFlowTheme.of(context)
                                                  .title1
                                                  .override(
                                                    fontFamily: 'Outfit',
                                                    color: Colors.black,
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                          hintText: 'RFU',
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.black,
                                              width: 2,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.black,
                                              width: 2,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0x00000000),
                                              width: 2,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          focusedErrorBorder:
                                              OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0x00000000),
                                              width: 2,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          contentPadding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  20, 32, 20, 12),
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .title3
                                            .override(
                                              fontFamily: 'Outfit',
                                              color: Color(0xFF14181B),
                                              fontSize: 15,
                                              fontWeight: FontWeight.normal,
                                            ),
                                        textAlign: TextAlign.start,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        16, 16, 16, 0),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.9,
                                      child: TextFormField(
                                        controller: perbaikanController,
                                        obscureText: false,
                                        decoration: InputDecoration(
                                          labelText: 'Perbaikan Part',
                                          labelStyle:
                                              FlutterFlowTheme.of(context)
                                                  .title1
                                                  .override(
                                                    fontFamily: 'Outfit',
                                                    color: Colors.black,
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                          hintText: 'Perbaikan Part...',
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.black,
                                              width: 2,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.black,
                                              width: 2,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0x00000000),
                                              width: 2,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          focusedErrorBorder:
                                              OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0x00000000),
                                              width: 2,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          contentPadding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  20, 32, 20, 12),
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .title3
                                            .override(
                                              fontFamily: 'Outfit',
                                              color: Color(0xFF14181B),
                                              fontSize: 15,
                                              fontWeight: FontWeight.normal,
                                            ),
                                        textAlign: TextAlign.start,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        16, 16, 16, 0),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.9,
                                      child: TextFormField(
                                        controller: perbaikanHMController,
                                        obscureText: false,
                                        decoration: InputDecoration(
                                          labelText: 'Perbaikan HM',
                                          labelStyle:
                                              FlutterFlowTheme.of(context)
                                                  .title1
                                                  .override(
                                                    fontFamily: 'Outfit',
                                                    color: Colors.black,
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                          hintText: '10',
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.black,
                                              width: 2,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.black,
                                              width: 2,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0x00000000),
                                              width: 2,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          focusedErrorBorder:
                                              OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0x00000000),
                                              width: 2,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          contentPadding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  20, 32, 20, 12),
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .title3
                                            .override(
                                              fontFamily: 'Outfit',
                                              color: Color(0xFF14181B),
                                              fontSize: 15,
                                              fontWeight: FontWeight.normal,
                                            ),
                                        textAlign: TextAlign.start,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        16, 16, 16, 0),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.9,
                                      child: TextFormField(
                                        controller: keteranganController,
                                        obscureText: false,
                                        decoration: InputDecoration(
                                          labelText: 'Keterangan',
                                          labelStyle:
                                              FlutterFlowTheme.of(context)
                                                  .title1
                                                  .override(
                                                    fontFamily: 'Outfit',
                                                    color: Colors.black,
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                          hintText: '....',
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.black,
                                              width: 2,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.black,
                                              width: 2,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0x00000000),
                                              width: 2,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          focusedErrorBorder:
                                              OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0x00000000),
                                              width: 2,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          contentPadding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  20, 32, 20, 12),
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .title3
                                            .override(
                                              fontFamily: 'Outfit',
                                              color: Color(0xFF14181B),
                                              fontSize: 15,
                                              fontWeight: FontWeight.normal,
                                            ),
                                        textAlign: TextAlign.start,
                                        maxLines: 4,
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: AlignmentDirectional(-0.8, 0),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 7, 0, 0),
                                      child: Text(
                                        'Nomor Lambung',
                                        style: FlutterFlowTheme.of(context)
                                            .title3
                                            .override(
                                              fontFamily: 'Poppins',
                                              fontSize: 16,
                                            ),
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: AlignmentDirectional(-0.8, 0),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          15, 10, 0, 0),
                                      child: FutureBuilder<ApiCallResponse>(
                                        future: GetUnitsCall.call(
                                          authtoken: FFAppState().authtoken,
                                        ),
                                        builder: (context, snapshot) {
                                          // Customize what your widget looks like when it's loading.
                                          if (!snapshot.hasData) {
                                            return Center(
                                              child: SizedBox(
                                                width: 50,
                                                height: 50,
                                                child:
                                                    CircularProgressIndicator(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primaryColor,
                                                ),
                                              ),
                                            );
                                          }
                                          final noLambungGetUnitsResponse =
                                              snapshot.data!;
                                          return FlutterFlowDropDown<String>(
                                            optionLabels:
                                                (GetUnitsCall.getUnitNoLambung(
                                              noLambungGetUnitsResponse
                                                  .jsonBody,
                                            ) as List)
                                                    .map<String>(
                                                        (s) => s.toString())
                                                    .toList()
                                                    .toList(),
                                            options: (GetUnitsCall.getUnitId(
                                              noLambungGetUnitsResponse
                                                  .jsonBody,
                                            ) as List)
                                                .map<String>(
                                                    (s) => s.toString())
                                                .toList()
                                                .toList(),
                                            onChanged: (val) async {
                                              setState(
                                                  () => noLambungValue = val);
                                            },
                                            width: 300,
                                            height: 50,
                                            textStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyText1
                                                    .override(
                                                      fontFamily: 'Poppins',
                                                      color: Colors.black,
                                                    ),
                                            hintText: 'No Lambung...',
                                            fillColor: Colors.white,
                                            elevation: 2,
                                            borderColor: Color(0xF8000000),
                                            borderWidth: 2,
                                            borderRadius: 0,
                                            margin:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    12, 4, 12, 4),
                                            hidesUnderline: true,
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                  SizedBox.fromSize(
                                    size: Size.fromHeight(40),
                                  ),
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
                                                getImageGalery();
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
                                  SizedBox(
                                    height: 28,
                                  ),
                                  Align(
                                    alignment: AlignmentDirectional(0, 0),
                                    child: Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.2,
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryBackground,
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Align(
                                            alignment:
                                                AlignmentDirectional(0, 0.05),
                                            child: FFButtonWidget(
                                              onPressed: () async {
                                                upload(
                                                    imageFile: File(photoVar),
                                                    id_jadwal: GetJadwalAllCall
                                                            .idUnitJadwal(
                                                      catatanDailyMekanikGetUnitsResponse
                                                          .jsonBody,
                                                    )
                                                        .toString()
                                                        .replaceAll('[', '')
                                                        .replaceAll(']', ''));
                                                print(upload);
                                                // dailymekanik =
                                                // await DailyMekanikCall.call(
                                                //   authtoken: FFAppState().authtoken,
                                                //   kerusakan: judulController!.text,
                                                //   status: statusController!.text,
                                                //   perbaikan:
                                                //   perbaikanController!.text,
                                                //   perbaikanHm: int.tryParse(
                                                //       perbaikanHMController!.text),
                                                //   keterangan:
                                                //   keteranganController!.text,
                                                //   masterUnitId: noLambungValue,
                                                //   photo: photo,
                                                // );
                                                if ((dailymekanik?.succeeded ??
                                                    true)) {
                                                  // ScaffoldMessenger.of(context)
                                                  //     .showSnackBar(
                                                  //   SnackBar(
                                                  //     content: Text(
                                                  //       DailyMekanikCall
                                                  //           .getMessages(
                                                  //         (dailymekanik
                                                  //                 ?.jsonBody ??
                                                  //             ''),
                                                  //       ).toString(),
                                                  //       style: TextStyle(
                                                  //         color: FlutterFlowTheme
                                                  //                 .of(context)
                                                  //             .primaryText,
                                                  //       ),
                                                  //     ),
                                                  //     duration: Duration(
                                                  //         milliseconds: 4000),
                                                  //     backgroundColor:
                                                  //         FlutterFlowTheme.of(
                                                  //                 context)
                                                  //             .primaryColor,
                                                  //   ),
                                                  // );
                                                } else {
                                                  // ScaffoldMessenger.of(context)
                                                  //     .showSnackBar(
                                                  //   SnackBar(
                                                  //     content: Text(
                                                  //       DailyMekanikCall
                                                  //           .getMessages(
                                                  //         (dailymekanik
                                                  //                 ?.jsonBody ??
                                                  //             ''),
                                                  //       ).toString(),
                                                  //       style: TextStyle(
                                                  //         color: FlutterFlowTheme
                                                  //                 .of(context)
                                                  //             .primaryText,
                                                  //       ),
                                                  //     ),
                                                  //     duration: Duration(
                                                  //         milliseconds: 4000),
                                                  //     backgroundColor:
                                                  //         Color(0xFFFB0505),
                                                  //   ),
                                                  // );
                                                }

                                                setState(() {});
                                              },
                                              text: 'Kirim',
                                              options: FFButtonOptions(
                                                width: 200,
                                                height: 40,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryColor,
                                                textStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .subtitle2
                                                        .override(
                                                          fontFamily: 'Poppins',
                                                          color: Colors.white,
                                                        ),
                                                borderSide: BorderSide(
                                                  color: Colors.transparent,
                                                  width: 1,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 45,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

Widget CustomButton(
    {required String? title,
    required IconData? icon,
    required VoidCallback? onClick}) {
  return Container(
    width: 280,
    child: ElevatedButton(
      onPressed: onClick,
      child: Row(
        children: [
          Icon(Icons.image_outlined),
          SizedBox(
            width: 20,
          ),
          Text(title!)
        ],
      ),
    ),
  );
}
