import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import '../../flutter_flow/flutter_flow_util.dart';

import 'api_manager.dart';

export 'api_manager.dart' show ApiCallResponse;

const _kPrivateApiFunctionName = 'ffPrivateApiCall';



/// Start Mekanik Group Code


class BaseUrl {
  // static String baseUrl = FFAppState().urlaneka;
  static String baseUrl = 'http://192.168.1.17:8000';
}

class MekanikGroup {
  static String baseUrl = 'https://dev-aneka2.neuhost.co.id';
  // static String baseUrl = 'http://127.0.0.1:8000';
  static String base2Url = 'https://dev-aneka2.neuhost.co.id';
  static Map<String, String> headers = {
    'Authorization': 'Bearer [authtoken]',
  };
  static PostApiTindakanTicketCall postApiTindakanTicketCall =
  PostApiTindakanTicketCall();
  static GetMekanikTaskCall getMekanikTaskCall = GetMekanikTaskCall();
}

class PostApiTindakanTicketCall {
  Future<ApiCallResponse> call({
    String? judul = '',
    String? photo = '',
    String? keterangan = '',
    String? authtoken = '',
    String? tbTiketingId,
  }) {
    return ApiManager.instance.makeApiCall(
      callName: 'postApiTindakanTicket',
      apiUrl: '${BaseUrl.baseUrl}/api/api-tindakan-ticket',
      callType: ApiCallType.POST,
      headers: {
        ...MekanikGroup.headers,
      },
      params: {
        'tb_tiketing_id': tbTiketingId,
        'judul': judul,
        'photo': photo,
        'keterangan': keterangan,
        'authtoken': authtoken,
      },
      bodyType: BodyType.MULTIPART,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }

  dynamic getRepairTicket(dynamic response) => getJsonField(
    response,
    r'''$.messages''',
  );
  dynamic getRepairDatas(dynamic response) => getJsonField(
    response,
    r'''$.datas''',
  );
  dynamic getTBTicketId(dynamic response) => getJsonField(
    response,
    r'''$.datas.tb_tiketing_id''',
  );
  dynamic getTicketId(dynamic response) => getJsonField(
    response,
    r'''$.datas.id''',
  );
  dynamic getKeterangan(dynamic response) => getJsonField(
    response,
    r'''$.datas.keterangan''',
  );
  dynamic getPhoto(dynamic response) => getJsonField(
    response,
    r'''$.datas.photo''',
  );
}

class GetMekanikTaskCall {
  Future<ApiCallResponse> call({
    String? authtoken = '',
  }) {
    return ApiManager.instance.makeApiCall(
      callName: 'getMekanikTask',
      apiUrl: '${BaseUrl.baseUrl}/api/daily/mekanik/tasks',
      callType: ApiCallType.GET,
      headers: {
        ...MekanikGroup.headers,
      },
      params: {
        'authtoken': authtoken,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }

  dynamic getDatas(dynamic response) => getJsonField(
    response,
    r'''$.datas''',
  );
  dynamic getTask(dynamic response) => getJsonField(
    response,
    r'''$.datas.tasks''',
  );
}

/// End Mekanik Group Code

/// Start Operator Group Code

class OperatorGroup {
  static String baseUrl = 'https://dev-aneka2.neuhost.co.id';
  static Map<String, String> headers = {
    'Authorization': 'Bearer [authtoken]',
  };
  static GetDailyStatusCall getDailyStatusCall = GetDailyStatusCall();
}

class GetDailyStatusCall {
  Future<ApiCallResponse> call({
    String? authtoken = '',
  }) {
    return ApiManager.instance.makeApiCall(
      callName: 'getDailyStatus',
      apiUrl: '${BaseUrl.baseUrl}/api/daily/status',
      callType: ApiCallType.GET,
      headers: {
        ...OperatorGroup.headers,
      },
      params: {
        'authtoken': authtoken,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }

  dynamic getDailyStatusMessages(dynamic response) => getJsonField(
    response,
    r'''$.messages''',
  );
  dynamic getDataStatus(dynamic response) => getJsonField(
    response,
    r'''$.data''',
  );
}

/// End Operator Group Code

class LoginCall {
  static Future<ApiCallResponse> call({
    String? email = '',
    String? password = '',
  }) {
    return ApiManager.instance.makeApiCall(
      callName: 'Login',
      apiUrl: '${BaseUrl.baseUrl}/api/login',
      callType: ApiCallType.POST,
      headers: {},
      params: {
        'email': email,
        'password': password,
      },
      bodyType: BodyType.X_WWW_FORM_URL_ENCODED,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }

  static dynamic authtoken(dynamic response) => getJsonField(
    response,
    r'''$.access_token''',
  );
  static dynamic idUser(dynamic response) => getJsonField(
    response,
    r'''$.data.id''',
  );
  static dynamic userRole(dynamic response) => getJsonField(
    response,
    r'''$.data.role''',
  );
  static dynamic userName(dynamic response) => getJsonField(
    response,
    r'''$.data.name''',
  );
  static dynamic useremail(dynamic response) => getJsonField(
    response,
    r'''$.data.email''',
  );
  static dynamic userJabatan(dynamic response) => getJsonField(
    response,
    r'''$.data.jabatan''',
  );
  static dynamic userTelp(dynamic response) => getJsonField(
    response,
    r'''$.data.no_telp''',
  );
  static dynamic userKelamin(dynamic response) => getJsonField(
    response,
    r'''$.data.jenis_kelamin''',
  );
  static dynamic userphotourl(dynamic response) => getJsonField(
    response,
    r'''$.data.user_photo_url''',
  );
}

class UpdatePasswordCall {
  static Future<ApiCallResponse> call({
    String? passwordLama = '',
    String? passwordBaru = '',
    String? authtoken = '',
  }) {
    return ApiManager.instance.makeApiCall(
      callName: 'updatePassword',
      apiUrl: '${BaseUrl.baseUrl}/api/updatePassword',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer ${authtoken}',
      },
      params: {
        'password_lama': passwordLama,
        'password_baru': passwordBaru,
      },
      bodyType: BodyType.X_WWW_FORM_URL_ENCODED,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }
}

class GetHmOperatorCall {
  static Future<ApiCallResponse> call({
    String? tanggal = '',
    String? authtoken = '',
  }) {
    return ApiManager.instance.makeApiCall(
      callName: 'getHmOperator',
      apiUrl: '${BaseUrl.baseUrl}/api/getHm',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer ${authtoken}',
      },
      params: {
        'tanggal': tanggal,
      },
      bodyType: BodyType.X_WWW_FORM_URL_ENCODED,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }

  static dynamic hm(dynamic response) => getJsonField(
    response,
    r'''$.datas.hm''',
  );
}

class PostReportMekanikCall {
  static Future<ApiCallResponse> call({
    String? judul = '',
    String? photo = '',
    String? keterangan = '',
    String? authtoken = '',
    String? tbTiketingId,
  }) {
    return ApiManager.instance.makeApiCall(
      callName: 'postReportMekanik',
      // apiUrl: 'https://webhook.site/e3214613-3eab-4f1b-a335-188bde28fc66',
      apiUrl: '${BaseUrl.baseUrl}/api/api-tindakan-ticket',
      callType: ApiCallType.POST,
      // headers: {
      //   'Authorization': 'Bearer ${authtoken}',
      // },
      params: {
        'tb_tiketing_id': tbTiketingId,
        'judul': judul,
        'photo': photo,
        'keterangan': keterangan,
        'authtoken': authtoken,
      },
      bodyType: BodyType.X_WWW_FORM_URL_ENCODED,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }

  static dynamic getRepairTicket(dynamic response) => getJsonField(
    response,
    r'''$.messages''',
  );
  static dynamic getRepairDatas(dynamic response) => getJsonField(
    response,
    r'''$.datas''',
  );
  static dynamic getTBTicketId(dynamic response) => getJsonField(
    response,
    r'''$.datas.tb_tiketing_id''',
  );
  static dynamic getTicketId(dynamic response) => getJsonField(
    response,
    r'''$.datas.id''',
  );
  static dynamic getKeterangan(dynamic response) => getJsonField(
    response,
    r'''$.datas.keterangan''',
  );
  static dynamic getPhoto(dynamic response) => getJsonField(
    response,
    r'''$.datas.photo''',
  );
}

class ApiticketCall {
  static Future<ApiCallResponse> call({
    String? masterUnitId,
    String? judul = '',
    Uint8List? photo,
    String? authtoken = '',
  }) {
    return ApiManager.instance.makeApiCall(
      callName: 'apiticket',
      apiUrl: '${BaseUrl.baseUrl}/api/api-ticket',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer ${authtoken}',
      },
      params: {
        'authtoken': authtoken,
        'master_unit_id': masterUnitId,
        'judul': judul,
        'photo': photo,
      },
      bodyType: BodyType.MULTIPART,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }

  static dynamic apiTicketMasterUnitId(dynamic response) => getJsonField(
    response,
    r'''$.datas.master_unit_id''',
  );
  static dynamic apiTicketPhoto(dynamic response) => getJsonField(
    response,
    r'''$.datas.photo''',
  );
  static dynamic apiTicketJudul(dynamic response) => getJsonField(
    response,
    r'''$.datas.judul''',
  );
  static dynamic apiTicketWaktuInsiden(dynamic response) => getJsonField(
    response,
    r'''$.datas.waktu_insiden''',
  );
  static dynamic apiTicketNamaPembuat(dynamic response) => getJsonField(
    response,
    r'''$.datas.nama_pembuat''',
  );
  static dynamic apiTicketID(dynamic response) => getJsonField(
    response,
    r'''$.datas.id''',
  );
  static dynamic getMessages(dynamic response) => getJsonField(
    response,
    r'''$.messages''',
  );
}

class ApihistoryticketCall {
  static Future<ApiCallResponse> call({
    String? accessToken = '',
    int? tbTiketingId,
    String? judul = '',
    String? photo = '',
    String? keterangan = '',
  }) {
    return ApiManager.instance.makeApiCall(
      callName: 'apihistoryticket',
      apiUrl: '${BaseUrl.baseUrl}/api/api-history-ticket',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer ${accessToken}',
      },
      params: {
        'access_token': accessToken,
        'tb_tiketing_id': tbTiketingId,
        'judul': judul,
        'photo': photo,
        'keterangan': keterangan,
      },
      bodyType: BodyType.X_WWW_FORM_URL_ENCODED,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }

  static dynamic apiHistoryTBTicketingID(dynamic response) => getJsonField(
    response,
    r'''$.datas.tb_tiketing_id''',
  );
  static dynamic apiHistoryKeterangan(dynamic response) => getJsonField(
    response,
    r'''$.datas.keterangan''',
  );
  static dynamic apiHistoryPhoto(dynamic response) => getJsonField(
    response,
    r'''$.datas.photo''',
  );
  static dynamic apiHistoryID(dynamic response) => getJsonField(
    response,
    r'''$.datas.id''',
  );
}

class DailyOperatorCall {
  static Future<ApiCallResponse> call({
    int? hm,
    File? photoHm,
    String? status = '',
    String? authtoken = '',
  }) {
    return ApiManager.instance.makeApiCall(
      callName: 'dailyOperator',
      apiUrl: '${BaseUrl.baseUrl}/api/daily/operator',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer ${authtoken}',
      },
      params: {
        'authtoken': authtoken,
        'hm': hm,
        'photo_hm': photoHm,
        'status': status,
      },
      bodyType: BodyType.MULTIPART,
      returnBody: true,
      encodeBodyUtf8: true,
      decodeUtf8: true,
      cache: false,
    );
  }

  static dynamic dailyOperatorALL(dynamic response) => getJsonField(
    response,
    r'''$.datas''',
  );
  static dynamic dailyOperatorMasterUnitID(dynamic response) => getJsonField(
    response,
    r'''$.datas.master_unit_id''',
  );
  static dynamic dailyOperatorTBJadwalID(dynamic response) => getJsonField(
    response,
    r'''$.datas.tb_jadwal_id''',
  );
  static dynamic dailyOperatorHM(dynamic response) => getJsonField(
    response,
    r'''$.datas.hm''',
  );
  static dynamic dailyOperatorPhoto(dynamic response) => getJsonField(
    response,
    r'''$.datas.photo_hm''',
  );
  static dynamic dailyOperatorStatus(dynamic response) => getJsonField(
    response,
    r'''$.datas.status''',
  );
  static dynamic dailyOperatorID(dynamic response) => getJsonField(
    response,
    r'''$.datas.id''',
  );
  static dynamic getMessages(dynamic response) => getJsonField(
    response,
    r'''$.messages''',
  );
}

class DailyMekanikCall {
  static Future<ApiCallResponse> call({
    int? perbaikanHm,
    String? status = '',
    String? keterangan = '',
    String? authtoken = '',
    String? photo = '',
    String? kerusakan = '',
    String? perbaikan = '',
    String? masterUnitId,
  }) {
    return ApiManager.instance.makeApiCall(
      callName: 'dailyMekanik',
      apiUrl: '${BaseUrl.baseUrl}/api/daily/mekanik',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer ${authtoken}',
      },
      params: {
        'authtoken': authtoken,
        'perbaikan_hm': perbaikanHm,
        'status': status,
        'keterangan': keterangan,
        'photo': photo,
        'kerusakan': kerusakan,
        'perbaikan': perbaikan,
        'master_unit_id': masterUnitId,
      },
      bodyType: BodyType.X_WWW_FORM_URL_ENCODED,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }

  static dynamic dailyMekanikMasterUnitID(dynamic response) => getJsonField(
    response,
    r'''$.datas.master_unit_id''',
  );
  static dynamic dailyMekanikMasterShiftID(dynamic response) => getJsonField(
    response,
    r'''$.datas.master_shift_id''',
  );
  static dynamic dailyMekanikMasterLokasiID(dynamic response) => getJsonField(
    response,
    r'''$.datas.master_lokasi_id''',
  );
  static dynamic dailyMekanikTanggal(dynamic response) => getJsonField(
    response,
    r'''$.datas.tanggal''',
  );
  static dynamic dailyMekanikKerusakan(dynamic response) => getJsonField(
    response,
    r'''$.datas.kerusakan''',
  );
  static dynamic dailyMekanikPerbaikanHM(dynamic response) => getJsonField(
    response,
    r'''$.datas.estimasi_perbaikan_hm''',
  );
  static dynamic dailyMekanikPerbaikan(dynamic response) => getJsonField(
    response,
    r'''$.datas.perbaikan''',
  );
  static dynamic dailyMekanikStatus(dynamic response) => getJsonField(
    response,
    r'''$.datas.status''',
  );
  static dynamic dailyMekanikKeterangan(dynamic response) => getJsonField(
    response,
    r'''$.datas.keterangan''',
  );
  static dynamic dailyMekanikID(dynamic response) => getJsonField(
    response,
    r'''$.datas.id''',
  );
  static dynamic getMessages(dynamic response) => getJsonField(
    response,
    r'''$.messages''',
  );
  static dynamic getPerbaikaHM(dynamic response) => getJsonField(
    response,
    r'''$.datas.perbaikan_hm''',
  );
}

class GetDailyOperatorCall {
  static Future<ApiCallResponse> call({
    String? authtoken = '',
  }) {
    return ApiManager.instance.makeApiCall(
      callName: 'GetDailyOperator',
      apiUrl: '${BaseUrl.baseUrl}/api/daily/operator',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer ${authtoken}',
      },
      params: {
        'authtoken': authtoken,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }

  static dynamic allGetDailyOperator(dynamic response) => getJsonField(
    response,
    r'''$.datas''',
    true,
  );
  static dynamic getDailyOperatorNoLambung(dynamic response) => getJsonField(
    response,
    r'''$.datas[:].no_lambung''',
    true,
  );
  static dynamic getDailyOperatorNamaUnit(dynamic response) => getJsonField(
    response,
    r'''$.datas[:].nama_unit''',
    true,
  );
  static dynamic getDailyOperatorNames(dynamic response) => getJsonField(
    response,
    r'''$.datas[:].name''',
    true,
  );
  static dynamic getDailyOperatorJadwalMasuk(dynamic response) => getJsonField(
    response,
    r'''$.datas[:].jadwal_masuk''',
    true,
  );
  static dynamic getDailyOperatorJadwalKeluar(dynamic response) => getJsonField(
    response,
    r'''$.datas[:].jadwal_keluar''',
    true,
  );
  static dynamic getDailyOperatorHM(dynamic response) => getJsonField(
    response,
    r'''$.datas[:].hm''',
    true,
  );
  static dynamic getDailyOperatorStatus(dynamic response) => getJsonField(
    response,
    r'''$.datas[:].status''',
    true,
  );
  static dynamic getJamKerja(dynamic response) => getJsonField(
    response,
    r'''$.datas[:].jam_kerja''',
    true,
  );
}

class GetDailyMekanikCall {
  static Future<ApiCallResponse> call({
    String? authtoken = '',
  }) {
    return ApiManager.instance.makeApiCall(
      callName: 'GetDailyMekanik',
      apiUrl: '${BaseUrl.baseUrl}/api/daily/mekanik',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer ${authtoken}',
      },
      params: {
        'authtoken': authtoken,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }

  static dynamic getDailyMekanikAll(dynamic response) => getJsonField(
    response,
    r'''$.datas''',
    true,
  );
  static dynamic getDailyMekanikNoLambung(dynamic response) => getJsonField(
    response,
    r'''$.datas[:].no_lambung''',
    true,
  );
  static dynamic getDailyMekanikNamaUnit(dynamic response) => getJsonField(
    response,
    r'''$.datas[:].nama_unit''',
    true,
  );
  static dynamic getDailyMekanikName(dynamic response) => getJsonField(
    response,
    r'''$.datas[:].name''',
    true,
  );
  static dynamic getDailyMekaniktanggal(dynamic response) => getJsonField(
    response,
    r'''$.datas[:].tanggal''',
    true,
  );
  static dynamic getDailyMekaikEstimasi(dynamic response) => getJsonField(
    response,
    r'''$.datas[:].estimasi_perbaikan_hm''',
    true,
  );
  static dynamic getDailyMekanikPerbaikanHM(dynamic response) => getJsonField(
    response,
    r'''$.datas[:].perbaikan_hm''',
    true,
  );
  static dynamic getDailtMekanikPerbaikan(dynamic response) => getJsonField(
    response,
    r'''$.datas[:].perbaikan''',
    true,
  );
  static dynamic getDailyMekanikMekanikStatus(dynamic response) => getJsonField(
    response,
    r'''$.datas[:].status''',
    true,
  );
  static dynamic getCode(dynamic response) => getJsonField(
    response,
    r'''$.code''',
  );
}

class GetUnitsCall {
  static Future<ApiCallResponse> call({
    String? authtoken = '',
  }) {
    return ApiManager.instance.makeApiCall(
      callName: 'GetUnits',
      apiUrl: '${BaseUrl.baseUrl}/api/units',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer ${authtoken}',
      },
      params: {
        'authtoken': authtoken,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }

  static dynamic getUnitsAll(dynamic response) => getJsonField(
    response,
    r'''$.datas''',
    true,
  );
  static dynamic getUnitNoLambung(dynamic response) => getJsonField(
    response,
    r'''$.datas[:].no_lambung''',
    true,
  );
  static dynamic getUnitId(dynamic response) => getJsonField(
    response,
    r'''$.datas[:].id_unit''',
    true,
  );
}

class GetTaskCall {
  static Future<ApiCallResponse> call({
    String? authtoken = '',
  }) {
    return ApiManager.instance.makeApiCall(
      callName: 'getMekanikTask',
      apiUrl: '${BaseUrl.baseUrl}/api/daily/mekanik/tasks',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer ${authtoken}',
      },
      params: {
        'authtoken': authtoken,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }

  static dynamic datas(dynamic response) => getJsonField(
    response,
    r'''$.datas''',
  );
  static dynamic task(dynamic response) => getJsonField(
    response,
    r'''$.datas.tasks''',
  );
}

class GetUnitCall {
  static Future<ApiCallResponse> call({
    String? authtoken = '',
  }) {
    return ApiManager.instance.makeApiCall(
      callName: 'GetUnit',
      apiUrl: '${BaseUrl.baseUrl}/api/unit',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer ${authtoken}',
      },
      params: {
        'authtoken': authtoken,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }

  static dynamic getUnitAll(dynamic response) => getJsonField(
    response,
    r'''$.datas''',
    true,
  );
}

class GetticketsCall {
  static Future<ApiCallResponse> call({
    String? authtoken = '',
  }) {
    return ApiManager.instance.makeApiCall(
      callName: 'Gettickets',
      apiUrl: '${BaseUrl.baseUrl}/api/tickets',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer ${authtoken}',
      },
      params: {
        'authtoken': authtoken,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }

  static dynamic getTicketsAll(dynamic response) => getJsonField(
    response,
    r'''$.datas''',
    true,
  );
  static dynamic getMessages(dynamic response) => getJsonField(
    response,
    r'''$.message''',
  );
  static dynamic getNoLambung(dynamic response) => getJsonField(
    response,
    r'''$.datas[:].no_lambung''',
    true,
  );
  static dynamic getIDtickets(dynamic response) => getJsonField(
    response,
    r'''$.datas[:].id''',
    true,
  );
  static dynamic getJudul(dynamic response) => getJsonField(
    response,
    r'''$.datas[:].judul''',
    true,
  );
  static dynamic getWaktu(dynamic response) => getJsonField(
    response,
    r'''$.datas[:].waktu_insiden''',
    true,
  );
}

class GetHistoryApiIDTicketCall {
  static Future<ApiCallResponse> call({
    String? id = '',
    String? authtoken = '',
  }) {
    return ApiManager.instance.makeApiCall(
      callName: 'GetHistoryApiIDTicket',
      apiUrl: '${BaseUrl.baseUrl}/api/history/${id}/ticket',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer ${authtoken}',
      },
      params: {
        'authtoken': authtoken,
        'id': id,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }

  static dynamic getHistoryApiTicketIDAll(dynamic response) => getJsonField(
    response,
    r'''$.datas''',
    true,
  );
  static dynamic idTicket(dynamic response) => getJsonField(
    response,
    r'''$.id_ticket''',
    true,
  );
  static dynamic judul(dynamic response) => getJsonField(
    response,
    r'''$.judul''',
    true,
  );
  static dynamic getfile(dynamic response) => getJsonField(
    response,
    r'''$.datas[:].file''',
    true,
  );

  static dynamic keterangan(dynamic response) => getJsonField(
    response,
    r'''$.datas[:].keterangan''',
    true,
  );
  static dynamic photo(dynamic response) => getJsonField(
    response,
    r'''$.datas[:].photo''',
    true,
  );
  static dynamic photourl(dynamic response) => getJsonField(
    response,
    r'''$.datas[:].history_photo_url''',
    true,
  );
}

class GetJadwalUserCall {
  static Future<ApiCallResponse> call({
    String? authtoken = '',
  }) {
    return ApiManager.instance.makeApiCall(
      callName: 'GetJadwalUser',
      apiUrl: '${BaseUrl.baseUrl}/api/jadwals',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer ${authtoken}',
      },
      params: {
        'authtoken': authtoken,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }

  static dynamic getJadwaUserAll(dynamic response) => getJsonField(
    response,
    r'''$.datas''',
    true,
  );
  static dynamic getJadwalUserNoLambung(dynamic response) => getJsonField(
    response,
    r'''$.datas[:].no_lambung''',
    true,
  );
  static dynamic getJadwalUserShift(dynamic response) => getJsonField(
    response,
    r'''$.datas[:].shift''',
    true,
  );
  static dynamic getJadwalUserNamaUnit(dynamic response) => getJsonField(
    response,
    r'''$.datas[:].nama_unit''',
    true,
  );
  static dynamic getJadwalUserName(dynamic response) => getJsonField(
    response,
    r'''$.datas[:].name''',
    true,
  );
  static dynamic getJadwalUserKerjaMasuk(dynamic response) => getJsonField(
    response,
    r'''$.datas[:].jam_kerja_masuk''',
    true,
  );
  static dynamic getJadwalUserKerjaKeluar(dynamic response) => getJsonField(
    response,
    r'''$.datas[:].jam_kerja_keluar''',
    true,
  );
  static dynamic getJadwalUserNamaGrup(dynamic response) => getJsonField(
    response,
    r'''$.datas[:].nama_grup''',
    true,
  );
  static dynamic getJadwalUserLokasi(dynamic response) => getJsonField(
    response,
    r'''$.datas[:].lokasi''',
    true,
  );
  static dynamic getStatus(dynamic response) => getJsonField(
    response,
    r'''$.datas[:].status_unit''',
    true,
  );
  static dynamic getShift(dynamic response) => getJsonField(
    response,
    r'''$.datas[:].shift''',
    true,
  );
  static dynamic getCode(dynamic response) => getJsonField(
    response,
    r'''$.code''',
  );
  static dynamic getJamKerja(dynamic response) => getJsonField(
    response,
    r'''$.datas[:].judul_jam_kerja''',
  );
}

class GetJadwalAllCall {
  static Future<ApiCallResponse> call({
    String? authtoken = '',
  }) {
    return ApiManager.instance.makeApiCall(
      callName: 'GetJadwalAll',
      apiUrl: '${BaseUrl.baseUrl}/api/jadwal',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer ${authtoken}',
      },
      params: {
        'authtoken': authtoken,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }

  static dynamic getJadwalAll(dynamic response) => getJsonField(
    response,
    r'''$.datas''',
    true,
  );
  static dynamic noLambungjadwal(dynamic response) => getJsonField(
    response,
    r'''$.datas.no_lambung''',
    true,
  );
  static dynamic idUnitJadwal(dynamic response) => getJsonField(
    response,
    r'''$.datas.id''',
    true,
  );
  static dynamic idUnit(dynamic response) => getJsonField(
    response,
    r'''$.datas.id_unit''',
    true,
  );
}

class GetNotificationsCall {
  static Future<ApiCallResponse> call({
    String? authtoken = '',
  }) {
    return ApiManager.instance.makeApiCall(
      callName: 'getNotifications',
      apiUrl: '${BaseUrl.baseUrl}/api/notifications',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer ${authtoken}',
      },
      params: {
        'authtoken': authtoken,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }

  static dynamic getNotificationsAll(dynamic response) => getJsonField(
    response,
    r'''$.datas''',
    true,
  );
  static dynamic getNotificationsMessage(dynamic response) => getJsonField(
    response,
    r'''$.message''',
  );
}

class ApiPagingParams {
  int nextPageNumber = 0;
  int numItems = 0;
  dynamic lastResponse;

  ApiPagingParams({
    required this.nextPageNumber,
    required this.numItems,
    required this.lastResponse,
  });

  @override
  String toString() =>
      'PagingParams(nextPageNumber: $nextPageNumber, numItems: $numItems, lastResponse: $lastResponse,)';
}

String _serializeList(List? list) {
  list ??= <String>[];
  try {
    return json.encode(list);
  } catch (_) {
    return '[]';
  }
}

String _serializeJson(dynamic jsonVar) {
  jsonVar ??= {};
  try {
    return json.encode(jsonVar);
  } catch (_) {
    return '{}';
  }
}
