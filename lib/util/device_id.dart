import 'package:news/base/app_cache.dart';
import 'package:uuid/uuid.dart';

class DeviceId {
  String deviceIdKey = "device_id";

  Future<String> setDeviceId() async {
    String deviceId = await this.getDeviceId();

    if (deviceId.isNotEmpty) {
      return deviceId;
    }

    var uuid = new Uuid();

    deviceId = uuid.v4();

    Map<String, dynamic> jsonModel = {this.deviceIdKey: deviceId};
    await AppCache.save(key: this.deviceIdKey, jsonModel: jsonModel);

    return deviceId;
  }

  Future<String> getDeviceId() async {
    Map<String, dynamic> jsonModel = await AppCache.load(this.deviceIdKey);

    if (jsonModel == null || !jsonModel.containsKey(this.deviceIdKey)) {
      return "";
    }

    return jsonModel[this.deviceIdKey];
  }
}
