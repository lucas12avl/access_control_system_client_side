import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'tree.dart';
import 'package:intl/intl.dart';
// add intl: ^0.19.0 under dependencies: in pubspec.yaml
// this is to get class DateFormat, see https://pub.dev/packages/intl
final DateFormat DATEFORMATTER = DateFormat('yyyy-MM-ddThh:mm');
// the format Webserver wants

/* // getTree tutorial
Future<Tree> getTree(String areaId) async {
  const String BASE_URL = "http://localhost:8080";
  Uri uri = Uri.parse("${BASE_URL}/get_children?$areaId");
  final response = await http.get(uri);
  // response is NOT a Future because of await
  if (response.statusCode == 200) {
    // TODO: change prints by logs, use package Logger for instance
    // which is the most popular, see https://pub.dev/packages/logger
    print("statusCode=$response.statusCode");
    print(response.body);
    // If the server did return a 200 OK response, then parse the JSON.
    Map<String, dynamic> decoded = convert.jsonDecode(response.body);
    return Tree(decoded); // "as Area" putted by the IDE to AVOID ERRORS
  } else {
    // If the server did not return a 200 OK response, then throw an exception.
    print("statusCode=$response.statusCode");
    throw Exception('failed to get answer to request $uri');
  }
}
*/


const String BASE_URL = "http://localhost:8080";
Future<String> sendRequest(Uri uri) async {
  final response = await http.get(uri);
// response is NOT a Future because of await
  if (response.statusCode == 200) { // server returns an OK response
    print("statusCode=$response.statusCode");
    print(response.body);
    return response.body;
  } else {
    print("statusCode=$response.statusCode");
    throw Exception('failed to get answer to request $uri');
  }
}

//getTree session 8
Future<Tree> getTree(String areaId) async {
  Uri uri = Uri.parse("${BASE_URL}/get_children?$areaId");
  final String responseBody = await sendRequest(uri);
  Map<String, dynamic> decoded = convert.jsonDecode(responseBody);
  return Tree(decoded);
}

Future<String> getRoot() async {

  String areaId = "root";
  Uri uri = Uri.parse("${BASE_URL}/get_children?$areaId");
  final String responseBody = await sendRequest(uri);
  Map<String, dynamic> decoded = convert.jsonDecode(responseBody);
  Tree treeRoot = Tree(decoded);
  String rootId = treeRoot.root.id;
  return rootId;
}

Future<void> lockDoor(Door door) async {
  lockUnlockDoor(door,
      'lock');
}
Future<void> unlockDoor(Door door) async {
  lockUnlockDoor(door,
      'unlock');
}
Future<void> lockUnlockDoor(Door door, String action) async {
// From the simulator : when asking to lock door D1, of parking, the request is
// http://localhost:8080/reader?credential=11343&action=lock
// &datetime=2023-12-08T09:30&doorId=D1
  assert ((action=='lock') | (action=='unlock'));
  String strNow = DATEFORMATTER.format(DateTime.now());
  print(strNow);
  Uri uri = Uri.parse("${BASE_URL}/reader?credential=11343&action=$action"
      "&datetime=$strNow&doorId=${door.id}");
// credential 11343 corresponds to user Ana of Administrator group
  print('lock ${door.id}, uri $uri');
  final String responseBody = await sendRequest(uri);
  print('requests.dart : door ${door.id} is ${door.state}');

  //hardcodear las credenciales en el java para poder decir que somos el admin, es muy chungo y hay mas cosas mas importantes
}
