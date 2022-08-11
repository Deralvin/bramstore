import 'package:bramstore/constants/theme.dart';
import 'package:bramstore/ui/widgets/dash_separator.dart';
import 'package:bramstore/viewmodels/checkout_view_model.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:stacked/stacked.dart';

class CheckoutView extends StatefulWidget {
  const CheckoutView({Key? key}) : super(key: key);

  @override
  State<CheckoutView> createState() => _CheckoutViewState();
}

class _CheckoutViewState extends State<CheckoutView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CheckoutViewModel>.reactive(
      viewModelBuilder: () => CheckoutViewModel(),
      onModelReady: (model) => model.initdata(),
      builder: (context, model, child) => Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(
            "Checkout",
            style: blackTextStyle,
          ),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: LoadingOverlay(
          opacity: 1,
          color: Colors.white,
          isLoading: model.busy,
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    child: Image.asset('assets/cc.png'),
                  ),
                  Container(
                    color: kaccentcolor,
                    width: double.infinity,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    child: Text("Pilih Kurir"),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    child: DropdownButtonFormField2(
                      decoration: InputDecoration(
                        //Add isDense true and zero Padding.
                        //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                        isDense: true,
                        contentPadding: EdgeInsets.zero,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        //Add more decoration as you want here
                        //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
                      ),
                      isExpanded: true,
                      hint: const Text(
                        'Pilih Jenis Kurir',
                        style: TextStyle(fontSize: 14),
                      ),
                      icon: const Icon(
                        Icons.arrow_drop_down,
                        color: Colors.black45,
                      ),
                      iconSize: 30,
                      buttonHeight: 40,
                      buttonPadding: const EdgeInsets.only(left: 20, right: 10),
                      dropdownDecoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      value: model.value_kurir,
                      onChanged: (value) {
                        model.value_kurir = value;
                        model.layanan = [];
                        model.getLayananKurir(value.toString());
                        model.notifyListeners();
                      },
                      items: model.kurir.map((item) {
                        return DropdownMenuItem(
                          child: Text("${item['nama']}"),
                          value: item['kode'],
                        );
                      }).toList(),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    child: Text("Pilih Layanan"),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    child: Wrap(
                      runSpacing: 4,
                      spacing: 3,
                      children: model.layanan.map((e) {
                        return InkWell(
                          onTap: () {
                            model.setLayanan(e['service']);
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                              color: model.layanan_data == e['service']
                                  ? ksecondcolor
                                  : null,
                              border: Border.all(color: kprimarycolor),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text("${e['description']}"),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Column(
                    children: [
                      Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 16, top: 12),
                            child: Text(
                              "Sub Total",
                              style: blackTextStyle.copyWith(
                                  color: Colors.grey.shade500),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(right: 16, top: 12),
                            child: Text(
                              "Rp ${model.subtotal}",
                              style: blackTextStyle.copyWith(
                                  fontSize: 18, fontWeight: semiBold),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 16, top: 12),
                            child: Text(
                              "Biaya Ongkir",
                              style: blackTextStyle.copyWith(
                                  color: Colors.grey.shade500),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(right: 16, top: 12),
                            child: Text(
                              "Rp ${model.biayaongkir}",
                              style: blackTextStyle.copyWith(
                                  fontSize: 18, fontWeight: semiBold),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 16, right: 16, top: 8),
                        child: DashSeparator(
                          height: 0.5,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 16, top: 12),
                            child: Text(
                              "Total",
                              style: blackTextStyle.copyWith(
                                  color: Colors.grey.shade500),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(right: 16, top: 12),
                            child: Text(
                              "Rp ${model.total}",
                              style: blackTextStyle.copyWith(
                                  fontSize: 18, fontWeight: semiBold),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 23,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        height: 50,
                        width: double.infinity,
                        margin: EdgeInsets.symmetric(horizontal: 40),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16)),
                              primary: ksecondcolor),
                          onPressed: model.isKonfirmasi == false
                              ? null
                              : () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => CheckoutView(),
                                    ),
                                  );
                                },
                          child: Text("Konfirmasi"),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
