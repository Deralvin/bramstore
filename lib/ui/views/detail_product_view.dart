import 'package:bramstore/constants/dummy_data.dart';
import 'package:bramstore/constants/theme.dart';
import 'package:bramstore/viewmodels/detail_product_view_model.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class DetailProductView extends StatelessWidget {
  DetailProductView({Key? key, this.id = ""}) : super(key: key);
  final String? id;
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DetailProductViewModel>.reactive(
      viewModelBuilder: () => DetailProductViewModel(),
      onModelReady: (model) => model.initdata(id!),
      builder: (context, model, child) => Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.black),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            "Detail",
            style: blackTextStyle,
          ),
          elevation: 0,
          backgroundColor: Colors.white,
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.add_circle_outline_sharp),
              color: Colors.black,
            )
          ],
        ),
        body: SafeArea(
          child: model.detail.length == 0
              ? Container()
              : Container(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            "${model.detail[0]['nama_produk']}",
                            style: blackTextStyle.copyWith(
                                fontWeight: semiBold, fontSize: 17),
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Rp ${model.detail[0]['harga']}",
                            style: blackTextStyle.copyWith(
                                fontWeight: medium, fontSize: 17),
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            margin: EdgeInsets.only(
                                left: 16, right: 16, top: 16, bottom: 16),
                            width: double.infinity,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(32),
                              child:
                                  Image.network("${model.detail[0]['gambar']}"),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 16, bottom: 8),
                          child: Text(
                            "Description",
                            style: blackTextStyle.copyWith(
                                fontWeight: semiBold, fontSize: 16),
                          ),
                        ),
                        Container(
                          margin:
                              EdgeInsets.only(left: 16, bottom: 8, right: 16),
                          child: Text(
                            "${model.detail[0]['deskripsi']}",
                            textAlign: TextAlign.justify,
                            style: blackTextStyle.copyWith(
                                fontWeight: regular, fontSize: 14),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 16),
                          child: Text(
                            "Select Size",
                            style: blackTextStyle.copyWith(
                                fontWeight: semiBold, fontSize: 16),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 16, top: 8),
                          child: Wrap(
                            spacing: 4,
                            runSpacing: 4,
                            children: model.type_size
                                .map(
                                  (item) => InkWell(
                                    onTap: () {
                                      model.selectedsize(item);
                                    },
                                    child: Container(
                                      height: 35,
                                      width: 35,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(6),
                                        color: item == model.id_size
                                            ? kaccentcolor
                                            : null,
                                        border: Border.all(
                                            color: item == model.id_size
                                                ? kaccentcolor
                                                : Colors.grey.shade300),
                                      ),
                                      child: Text(item),
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 16, top: 16),
                          child: Text(
                            "Quantity",
                            style: blackTextStyle.copyWith(
                                fontWeight: semiBold, fontSize: 16),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 16, top: 8),
                          child: Wrap(
                            children: [
                              InkWell(
                                onTap: () {
                                  model.decreaseQty();
                                },
                                child: Container(
                                  height: 35,
                                  width: 35,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    border:
                                        Border.all(color: Colors.grey.shade300),
                                  ),
                                  child: Text("-"),
                                ),
                              ),
                              Container(
                                height: 35,
                                width: 35,
                                alignment: Alignment.center,
                                child: Text("${model.qty.toString()}"),
                              ),
                              InkWell(
                                onTap: () {
                                  model.increaseQty();
                                },
                                child: Container(
                                  height: 35,
                                  width: 35,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    border:
                                        Border.all(color: Colors.grey.shade300),
                                  ),
                                  child: Text("+"),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 16, vertical: 16),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "Rp 210.000",
                                  style: blackTextStyle.copyWith(
                                      fontSize: 21, fontWeight: semiBold),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  height: 50,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(16)),
                                        primary: ksecondcolor),
                                    onPressed: () {},
                                    child: Text("Add to Cart"),
                                  ),
                                ),
                              ),
                            ],
                          ),
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
