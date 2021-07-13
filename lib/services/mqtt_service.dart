import 'dart:developer';
import 'package:ake_car_tracker/constants/mqtt_constant.dart';
import 'package:ake_car_tracker/controllers/controller.dart';
import 'package:get/get.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:uuid/uuid.dart';

class MqttService extends GetxService {
  Uuid uuid = Uuid();

  @override
  void onInit() {
    initializedMqtt();
    super.onInit();
  }

  /// MqttServer client object.
  MqttServerClient? client;

  /// Initialized Mqtt Server
  Future<void> initializedMqtt() async {
    client = MqttServerClient(MqttConstant.MQTT_HOST, uuid.v4())
      ..logging(on: false)
      ..port = MqttConstant.PORT
      ..keepAlivePeriod = 20
      ..onDisconnected = _onDisconnected
      ..onSubscribed = _onSubscribed
      ..onConnected = _onConnected
      ..onUnsubscribed = _onUnsubscribed
      ..onSubscribeFail = _onSubscribeFail;

    /// Mqtt server if connection is lost.
    /// MqttBroker publish this message on this topic key.
    final mqttMsg = MqttConnectMessage()
        .withWillMessage('connection-failed')
        .withWillTopic('willTopic')
        .startClean()
        .withWillQos(MqttQos.atLeastOnce)
        .withWillTopic('failed');
    client!.connectionMessage = mqttMsg;
    await connectMqtt();
  }

  getConnectionStatus() {
    return client!.connectionStatus!.state == MqttConnectionState.connected;
  }

  /// Mqtt server connected.
  void _onConnected() {
    log('Connected');
  }

  /// Mqtt server disconnected
  void _onDisconnected() {
    log('Disconnected');
  }

  /// Mqtt server subscribed
  void _onSubscribed(String? topic) {
    log('Subscribed topic is : $topic');
  }

  void _onUnsubscribed(String? topic) {
    log('Unsubscribed topic is : $topic');
  }

  void _onSubscribeFail(String? topic) {
    log('Failed subscribe topic : $topic');
  }

  /// Connection MQTT Server.
  Future<void> connectMqtt() async {
    if (client!.connectionStatus!.state != MqttConnectionState.connected) {
      try {
        await client!.connect();
      } catch (e) {
        log('Connection failed' + e.toString());
      }
    } else {
      log('MQTT Server already connected ');
    }
  }

  /// Diconnection MQTT Server.
  Future<void> disconnectMqtt() async {
    if (client!.connectionStatus!.state == MqttConnectionState.connected) {
      try {
        client!.disconnect();
      } catch (e) {
        log('Disconnection Failed ' + e.toString());
      }
    } else {
      log('MQTT Server already disconnected ');
    }
  }

  /// Subscribe all topic
  void subscribeAllTopic(String imei) {
    if (client!.connectionStatus!.state == MqttConnectionState.connected) {
      client!.subscribe(imei + "/data", MqttQos.atLeastOnce);
      _listenAllTopic();
    } else {
      log('No Connection found');
    }
  }

  /// Mqtt Server publish.
  void publishMqttService(String topic, String message, {bool retain = true}) {
    final builder = MqttClientPayloadBuilder();
    builder.addString(message);
    client!.publishMessage(
      topic,
      MqttQos.atLeastOnce,
      builder.payload!,
      retain: retain,
    );
    builder.clear();
  }

  /// MQTT Server Listen all.
  void _listenAllTopic() {
    client!.updates!.listen((dynamic t) {
      MqttPublishMessage recMessage = t[0].payload;
      final String imei = t[0].topic.split("/").first;
      final message =
          MqttPublishPayload.bytesToStringAsString(recMessage.payload.message);
      print("$imei --> $message");
      Get.find<MapScreenController>().parseMqttDataSensor(imei, message);
    });
  }
}
