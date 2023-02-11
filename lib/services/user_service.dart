import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:math';

import 'package:flutterpartproject/main.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path/path.dart';

import 'constans.dart';
import '../models/api_response.dart';
import '../models/departement.dart';
import '../models/user.dart';
import '../pages/auth/loginpage.dart';

// logout

logout() async {
  Get.to(() => Login());
  await userId.remove('userToken');
  await userId.remove('userId');
  await userEmail.remove('userEmail');
  await userImage.remove('userImage');
}

//==============================================================================

getRequest(String url) async {
  try {
    var respons = await http.get(
      Uri.parse(url),
      headers: {'Accept': 'application/json'},
    );
    if (respons.statusCode == 200) {
      var responsbody = jsonDecode(respons.body);
      return responsbody;
    } else {
      print("erro ${respons.statusCode}");
    }
  } catch (e) {
    print("$e");
  }
}

//==============================================================================
postRequest(String url, Map data) async {
  var token = userId.getString('userToken');
  print(token);
  try {
    var respons = await http.post(
      Uri.parse(url),
      body: data,
      headers: {'Accept': 'application/json', 'Authorization': 'Bearer $token'},
    );

    if (respons.statusCode == 200) {
      var responsbody = jsonDecode(respons.body);

      return responsbody;
    } else {
      print("errorrrrrrrrrrrrrrrrrrrrrrrrrs  ${respons.statusCode}");
    }
  } catch (e) {
    print(" rerrrro catch $e");
  }
}

//==============================================================================
uploadmultipleimage(String url, Map data, List images) async {
  http.MultipartRequest request = http.MultipartRequest('POST', Uri.parse(url));
  //data
  data.forEach((key, value) {
    return request.fields[key] = value;
  });
  //end data

  List<http.MultipartFile> newList = [];

  for (int i = 0; i < images.length; i++) {
    var length = await images[i].length();
    var stream = http.ByteStream(images[i].openRead());

    var multipartFile = http.MultipartFile("files[]", stream, length,
        filename: basename(images[i].path));
    newList.add(multipartFile);
  }

  request.files.addAll(newList);

  var myRequest = await request.send();
  print(myRequest);
  print("send");

  var respones =
      await http.Response.fromStream(myRequest); // نحصل على الريسبونس

  if (myRequest.statusCode == 200) {
    print(respones.body);
    return jsonDecode(respones.body);
  } else {
    print(" rerrrro catch ${myRequest.statusCode}");
  }
}

// to upload one image
Future<ApiResponse> uploadimg(File file) async {
  var token = userId.getString('userToken');
  String? userID = userId.getString('userId');

  ApiResponse apiResponse = ApiResponse();
  final response = await http.MultipartRequest(
    "post",
    Uri.parse(uploadprofileURL),
  );
  var length = await file.length();
  var stream = http.ByteStream(file.openRead());
  var multipartFile = http.MultipartFile("image", stream, length,
      filename: basename(file.path));
  response.files.add(multipartFile);
  var headers = {
    'Accept': 'application/json',
    'Authorization': 'Bearer $token'
  };
  response.headers.addAll(headers);

  //response.fields[{'id': userID}];
  response.fields['id'] = "$userID";
  var myrequest = await response.send();
  var myresponse = await http.Response.fromStream(myrequest);
  if (myresponse.statusCode == 200) {
    print(myresponse.body);
  } else {
    print(myresponse.request);
    print(myresponse.statusCode);
    print(file.path);
  }

  return apiResponse;
}
