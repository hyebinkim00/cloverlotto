import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../controller/qrscan_controller.dart';

class QrscanPage extends GetView<QrscanController> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  late String barcodeData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              Container(
                  height: 500,
                  child: QRView(
                    key: qrKey,
                    onQRViewCreated: _onQRViewCreated,
                    overlay: QrScannerOverlayShape(
                        borderColor: Colors.cyanAccent,
                        borderRadius: 10,
                        borderLength: 20,
                        borderWidth: 10,
                        cutOutSize: MediaQuery.of(context).size.width * 0.8),
                  )),
              Obx(() => Text('${controller.totalResponse}')),
              TextButton(
                  onPressed: () {
                    controller.qrViewController!.pauseCamera();
                  },
                  child: Text('결과 보기')),
              Obx(() => Visibility(
                  visible: (controller.totalResponse.value.isNotEmpty),
                  child: TextButton(
                      onPressed: () {
                        controller.qrViewController!.resumeCamera();
                      },
                      child: Text('결과 확인하기')))),
            ],
          ),
        ),
      ),
    );
  }

  void _onQRViewCreated(QRViewController qrViewController) {
    controller.qrViewController = qrViewController;
    qrViewController!.scannedDataStream.listen((scanData) {
      // QR 스캔됨
      if (scanData.code!.contains('m.dhlottery.co.kr')) {
        List<String> parts = scanData.code!.split('?');
        barcodeData = parts[1];
        controller.qrViewController!.pauseCamera();
        controller.barcodeResult(barcodeData);
      }
    });
  }

  void showAlert(BuildContext context, String ss) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('로또 결과'),
            content: Text('몇회 + 번호 + 결과'),
            actions: <Widget>[
              Container(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(); //창 닫기
                  },
                  child: Text("저장하기"),
                ),
              ),
              Container(
                child: ElevatedButton(
                  onPressed: () {
                    controller.totalResponse.value="";
                    Navigator.of(context).pop(); //창 닫기
                  },
                  child: Text("다시 스캔하기"),
                ),
              ),
            ],
          );
        });
  }
}
