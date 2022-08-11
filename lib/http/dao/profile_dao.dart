import 'package:flutter_bilibili/http/core/hi_net.dart';
import 'package:flutter_bilibili/http/request/profile_request.dart';
import 'package:flutter_bilibili/model/index.dart';
import 'package:flutter_bilibili/util/hi_functions.dart';

class ProfileDao {

  static get() async {
    ProfileRequest request = ProfileRequest();
    var result = await HiNet.getInstance().fire(request);
    hiPrint(result);
    return Profile.fromJson(result['data']);
  }

}