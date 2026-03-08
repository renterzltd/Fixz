import 'package:fixz/hdHelper/exportFile.dart';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart';

import 'global_utils.dart';

class NetWorkHelper {
  NetWorkHelper();

  String baseUrl = '';
  String startdate = '';
  String enddate = '';

  Future<dynamic> getsavedcardlist(String storeId, String authKey) async {
    String url = 'https://secure.telr.com/gateway/savedcardslist.json';
    var data = {
      'storeid': GlobalUtils.storeid, //'',
      'authkey': GlobalUtils.authkey, //'',
      'custref': '444',
      'testmode': '1'
    };
    var requestData = {'SavedCardListRequest': data};

    debugPrint('Data auth test: $data');
    debugPrint('Data auth test: $requestData');

    var body = json.encode(requestData);
    debugPrint('body = $body');

    http.Response response = await http.post(
      Uri.parse(url),
      body: body,
      headers: {
        "Content-Type": "application/json",
      },
    );
    debugPrint("Register email  = $response");

    String dataReturned = response.body;
    dynamic decodedData = jsonDecode(dataReturned);
    //
    return decodedData;
    // } else {
    //   debugPrint(response.statusCode);
    //   return response.statusCode;
  }

  Future<dynamic> getdeletecardlist(
      String storeId, String authKey, String transref) async {
    // String url = 'https://secure.telr.com/gateway/delsavedcards.json';
    String url = 'https://secure.telr.com/gateway/delsavedcards.json';
    var data = {
      'storeid': GlobalUtils.storeid,
      'authkey': GlobalUtils.authkey,
      'custref': '444',
      'testmode': '1',
      'tranref': transref
    };
    // var requestData = { data};

    debugPrint('Data auth test: $data');
    // debugPrint('Data auth test: $requestData');

    var body = json.encode(data);
    debugPrint('body = $body');

    http.Response response = await http.post(
      Uri.parse(url),
      body: body,
      headers: {
        "Content-Type": "application/json",
      },
    );
    // debugPrint("Register email  = $response");

    String dataReturned = response.body;
    dynamic decodedData = jsonDecode(dataReturned);
    //
    return decodedData;
    // } else {
    //   debugPrint(response.statusCode);
    //   return response.statusCode;
  }

  Future<dynamic> getcardtoken(String storeId, String number, String month,
      String year, String cvv) async {
    String url = 'https://secure.telr.com/gateway/cardtoken.json';
    var data = {
      'store': GlobalUtils.storeid,
      'number': number,
      'expiry_month': month,
      'expiry_year': year,
      'cvv': cvv,
    };
    var requestData = {'CardTokenRequest': data};

    debugPrint('Data auth test: $data');
    debugPrint('Data auth test: $requestData');

    var body = json.encode(requestData);
    debugPrint('body = $body');

    http.Response response = await http.post(
      Uri.parse(url),
      body: body,
      headers: {
        "Content-Type": "application/json",
      },
    );
    debugPrint("Register email  = $response");

    String dataReturned = response.body;
    dynamic decodedData = jsonDecode(dataReturned);
    //
    return decodedData;
    // } else {
    //   debugPrint(response.statusCode);
    //   return response.statusCode;
  }

  Future pay(XmlDocument xml) async {
    String url = 'https://secure.telr.com/gateway/mobile.xml';
    var data = {xml};

    var body = xml.toString();

    http.Response response = await http.post(
      Uri.parse(url),
      body: body,
      headers: {
        "Content-Type": "application/xml",
      },
    );
    debugPrint("Response => PAY API CALL ${response.statusCode}");
    // debugPrint("Response body = ${response.body}");
    if (response.statusCode == 200 || response.statusCode == 400) {
      return response.body;
    } else {
      return 'failed';
    }
  }

  Future getTransactionstatus(XmlDocument xml) async {
    String url = 'https://secure.telr.com/gateway/mobile_complete.xml';
    var data = {xml};

    var body = xml.toString();

    http.Response response = await http.post(
      Uri.parse(url),
      body: body,
      headers: {
        "Content-Type": "application/xml",
      },
    );
    debugPrint("Response => GET TRANS STATUS ${response.statusCode}");
    debugPrint("Response body = HARDIK 157 ${response.body}");
    if (response.statusCode == 200 || response.statusCode == 400) {
      return response.body;
    } else {
      return 'failed';
    }
  }
}
