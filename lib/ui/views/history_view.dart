import 'package:bramstore/constants/theme.dart';
import 'package:bramstore/viewmodels/history_view_model.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:stacked/stacked.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';

class HistoryView extends StatelessWidget {
  const HistoryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HistoryViewModel>.reactive(
      viewModelBuilder: () => HistoryViewModel(),
      onModelReady: (model) => model.initdata(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "History",
            style: blackTextStyle,
          ),
          elevation: 0,
          backgroundColor: Colors.white,
        ),
        backgroundColor: Colors.white,
        body: LoadingOverlay(
          isLoading: model.busy,
          opacity: 1,
          color: Colors.white,
          child: SafeArea(
            child: Container(
              child: ListView.builder(
                itemCount: model.history_data.length,
                itemBuilder: (ctx, idx) {
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    margin:
                        EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey.shade400)),
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("nomor transaksi"),
                                Text(
                                  "${model.history_data[idx]['nomor_transaksi']}",
                                  style: blackTextStyle.copyWith(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                SizedBox(
                                  height: 12,
                                ),
                                Text("harga"),
                                Text(
                                  "Rp. ${model.history_data[idx]['total_bayar']}",
                                  style: blackTextStyle.copyWith(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text("${model.history_data[idx]['status']}"),
                                SizedBox(
                                  height: 16,
                                ),
                                Text("Batas Pembayaran"),
                                Text(
                                  "${model.history_data[idx]['pembayaran_expired']}",
                                  style: blackTextStyle.copyWith(
                                      color: Colors.red),
                                ),
                                SizedBox(
                                  height: 16,
                                ),
                              ],
                            )
                          ],
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            final link = WhatsAppUnilink(
                              phoneNumber: '+6289629758463',
                              text:
                                  "Kode Transaksi ${model.history_data[idx]['nomor_transaksi']}",
                            );
                            // Convert the WhatsAppUnilink instance to a string.
                            // Use either Dart's string interpolation or the toString() method.
                            // The "launch" method is part of "url_launcher".
                            await launch('$link');
                          },
                          child: Text("Kirim Pembayaran"),
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
