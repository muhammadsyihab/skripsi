import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import '../backend/api_requests/api_calls.dart';
import '../daftar_catatan_daily_operator/daftar_catatan_daily_operator_widget.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_radio_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'packavider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:quickalert/quickalert.dart';

import 'package:http/http.dart' as http;

import 'package:async/async.dart';

class CatatanDailyOperatorWidget extends StatefulWidget {
  const CatatanDailyOperatorWidget({Key? key}) : super(key: key);

  @override
  _CatatanDailyOperatorWidgetState createState() =>
      _CatatanDailyOperatorWidgetState();
}

class _CatatanDailyOperatorWidgetState
    extends State<CatatanDailyOperatorWidget> {
  ApiCallResponse? postDailyOperator;
  String? statusValue;
  String? photoHm;
  TextEditingController? hmController;
  final _unfocusNode = FocusNode();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  final ImagePicker _picker = ImagePicker();

  // for alert dialog


  @override
  void initState() {
    super.initState();
    hmController = TextEditingController(text: '0');
  }

  @override
  void dispose() {
    _unfocusNode.dispose();
    hmController?.dispose();
    super.dispose();
  }

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
      // upload(File(imagePicked!.path));

      // String img64 = base64Encode(bytes);
      // photo = img64;
    });
  }

  String? respon;
  String? messages;


  @override
  Widget build(BuildContext context) {
    upload(File imageFile) async {
      String authtoken = FFAppState().authtoken;
      String dropdownStr = statusValue ?? '';
      var stream =
      new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
      var length = await imageFile.length();
      var request = http.MultipartRequest(
          "POST", Uri.parse("http://103.179.86.78:8000/api/daily/operator"));

      request.fields.addAll({'hm': hmController!.text, 'status': dropdownStr});
      request.headers.addAll({'Authorization': 'Bearer ${authtoken}'});

      var multipartFile = new http.MultipartFile('photo_hm', stream, length,
          filename: basename(imageFile.path));
      request.files.add(multipartFile);
      var response = await request.send();
      // print(response.statusCode);
      final respon = response.statusCode;
      // final messages = response.reasonPhrase;
      // print(response.reasonPhrase);

      response.stream.transform(utf8.decoder).listen((value) async {
        // print(value);
        messages = value;
        print(messages);
      });
      if (respon == 200){
        await QuickAlert.show(
            context: context,
            type: QuickAlertType.loading,
            title: 'Loading',
            text: 'Mengirim Data',
            autoCloseDuration: Duration(seconds: 3)
        );
        await Future.delayed(const Duration(milliseconds: 200), () {
          return QuickAlert.show(
            context: context,
            type: QuickAlertType.success,
            title: 'Terkirim',
            text: messages,
            confirmBtnText: 'Kembali',
            onConfirmBtnTap: 	() async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DaftarCatatanDailyOperatorWidget(),
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
        await Future.delayed(const Duration(milliseconds: 200), () {
          return  QuickAlert.show(
            context: context,
            type: QuickAlertType.warning,
            text: messages,
            title: 'Gagal Terkirim',
          );
        });
      }
      if (respon == 500) {
        await QuickAlert.show(
          context: context,
          type: QuickAlertType.loading,
          title: 'Loading',
          text: 'Mengirim Data',
        );
        await Future.delayed(const Duration(milliseconds: 200), () {
          return QuickAlert.show(
            context: context,
            type: QuickAlertType.error,
            text: messages,
            title: 'Server Error',
          );
        });
      }
    }

    context.watch<FFAppState>();
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xFF0A55C0),
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
                builder: (context) => DaftarCatatanDailyOperatorWidget(),
              ),
            );
          },
        ),
        title: Text(
          'Form Aktivitas Operator',
          style: FlutterFlowTheme.of(context).title2.override(
                fontFamily: 'Outfit',
                color: Colors.white,
                fontSize: 22,
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
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(16, 15, 16, 0),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: TextFormField(
                            controller: hmController,
                            obscureText: false,
                            decoration: InputDecoration(
                              labelText: 'HM',
                              labelStyle:
                                  FlutterFlowTheme.of(context).title3.override(
                                        fontFamily: 'Outfit',
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontWeight: FontWeight.normal,
                                      ),
                              hintText: '65.000',
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
                                  EdgeInsetsDirectional.fromSTEB(20, 20, 20, 5),
                            ),
                            style: FlutterFlowTheme.of(context).title3.override(
                                  fontFamily: 'Outfit',
                                  color: Color(0xFF14181B),
                                  fontSize: 20,
                                  fontWeight: FontWeight.normal,
                                ),
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ),
                      Align(
                        alignment: AlignmentDirectional(-0.86, 0),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                          child: Text(
                            'Status Pekerjaan',
                            style:
                                FlutterFlowTheme.of(context).bodyText1.override(
                                      fontFamily: 'Poppins',
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: AlignmentDirectional(-0.9, 0),
                        child: FutureBuilder<ApiCallResponse>(
                          future: OperatorGroup.getDailyStatusCall.call(
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
                            final statusGetDailyStatusResponse = snapshot.data!;
                            return FlutterFlowRadioButton(
                              options: ['Mulai', 'Berakhir'].toList(),
                              onChanged: (val) =>
                                  setState(() => statusValue = val),
                              optionHeight: 40,
                              textStyle: FlutterFlowTheme.of(context)
                                  .bodyText1
                                  .override(
                                    fontFamily: 'Poppins',
                                    color: Colors.black,
                                  ),
                              selectedTextStyle: FlutterFlowTheme.of(context)
                                  .bodyText1
                                  .override(
                                    fontFamily: 'Poppins',
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                              textPadding:
                                  EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                              buttonPosition: RadioButtonPosition.left,
                              direction: Axis.vertical,
                              radioButtonColor: Colors.blue,
                              inactiveRadioButtonColor: Color(0x8A000000),
                              toggleable: false,
                              horizontalAlignment: WrapAlignment.start,
                              verticalAlignment: WrapCrossAlignment.start,
                            );
                          },
                        ),
                      ),
                      SizedBox.fromSize(
                        size: Size.fromHeight(45),
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
                      SizedBox.fromSize(
                        size: Size.fromHeight(40),
                      ),
                      Align(
                        alignment: AlignmentDirectional(0, -0.1),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.66,
                          height: MediaQuery.of(context).size.height * 0.05,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                          ),
                          child: FFButtonWidget(
                            onPressed: () async {
                              upload(File(photoVar));

                              // postDailyOperator = await DailyOperatorCall.call(
                              //   authtoken: FFAppState().authtoken,
                              //   hm: int.tryParse(hmController!.text),
                              //   status: statusValue,
                              //   photoHm: photoHm,
                              // );
                              if ((postDailyOperator?.succeeded ?? true)) {
                                // ScaffoldMessenger.of(context).showSnackBar(
                                //   SnackBar(
                                //     content: Text(
                                //       DailyOperatorCall.getMessages(
                                //         (postDailyOperator?.jsonBody ?? ''),
                                //       ).toString(),
                                //       style: TextStyle(
                                //         color: FlutterFlowTheme.of(context)
                                //             .primaryText,
                                //       ),
                                //     ),
                                //     duration: Duration(milliseconds: 4000),
                                //     backgroundColor:
                                //         FlutterFlowTheme.of(context)
                                //             .secondaryColor,
                                //   ),
                                // );

                              } else {
                                // ScaffoldMessenger.of(context).showSnackBar(
                                //   SnackBar(
                                //     content: Text(
                                //       DailyOperatorCall.getMessages(
                                //         (postDailyOperator?.jsonBody ?? ''),
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
                            },
                            text: 'Kirim',
                            options: FFButtonOptions(
                              width: 130,
                              height: 40,
                              color: FlutterFlowTheme.of(context).primaryColor,
                              textStyle: FlutterFlowTheme.of(context)
                                  .subtitle2
                                  .override(
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
                    ],
                  ),
                ),
                SizedBox.fromSize(
                  size: Size.fromHeight(30),
                ),
              ],
            ),
          ),
        ),
      ),
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
