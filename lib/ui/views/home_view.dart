import 'package:bramstore/constants/dummy_data.dart';
import 'package:bramstore/constants/theme.dart';
import 'package:bramstore/ui/views/detail_product_view.dart';
import 'package:bramstore/ui/widgets/textfield.dart';
import 'package:bramstore/viewmodels/home_view_model.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shimmer/shimmer.dart';
import 'package:stacked/stacked.dart';

class HomeView extends StatefulWidget {
  HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  TextEditingController searchtxt = new TextEditingController();
  int _current = 0;
  final CarouselController _controller = CarouselController();
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      onModelReady: (model) => model.initdata(),
      builder: (context, model, child) => Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Container(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  // Text("Hi..."),
                  TextFieldWidget(
                    textfield: searchtxt,
                    texthint: "Search....",
                  ),
                  model.list_banner == null
                      ? Shimmer.fromColors(
                          baseColor: Colors.grey.shade300,
                          highlightColor: Colors.grey.shade100,
                          enabled: true,
                          child: Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 10),
                            height: 140,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(12)),
                          ),
                        )
                      : model.list_banner!.length == 0
                          ? Container()
                          : Container(
                              margin: EdgeInsets.only(top: 12),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12)),
                              child: CarouselSlider(
                                options: CarouselOptions(
                                    autoPlay: true,
                                    height: 140,
                                    enlargeCenterPage: true,
                                    onPageChanged: (index, reason) {
                                      setState(() {
                                        _current = index;
                                      });
                                    }),
                                carouselController: _controller,
                                items: model.list_banner!
                                    .map(
                                      (item) => Container(
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                fit: BoxFit.fill,
                                                image: AssetImage(item)),
                                            borderRadius:
                                                BorderRadius.circular(12)),
                                        // child: Image.network(
                                        //   item.source!,
                                        // ),
                                      ),
                                    )
                                    .toList(),
                              ),
                            ),
                  Container(
                    margin: EdgeInsets.only(left: 16, right: 16, top: 16),
                    child: Text(
                      "Categories",
                      style: blackTextStyle.copyWith(
                          fontSize: 18, fontWeight: bold),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 8, left: 16, right: 16),
                    child: Wrap(
                      children: model.list_kategori
                          .map(
                            (e) => InkWell(
                              borderRadius: BorderRadius.circular(8),
                              onTap: () {
                                print(e.icon);
                              },
                              child: Container(
                                margin: EdgeInsets.all(3),
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                      width: 1, color: kprimarycolor),
                                ),
                                child: Wrap(
                                  runSpacing: 3,
                                  spacing: 3,
                                  children: [
                                    Container(
                                      height: 19,
                                      child: Image.network(e.icon!),
                                    ),
                                    Text(" ${e.namaKategori}")
                                  ],
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                    // child: ListView.builder(
                    //   itemCount: model.list_kategori.length,
                    //   shrinkWrap: true,
                    //   scrollDirection: Axis.horizontal,
                    //   itemBuilder: (ctx, idx) {
                    //     return Column(
                    //       crossAxisAlignment: CrossAxisAlignment.start,
                    //       children: [
                    //         Container(
                    //           height: 50,
                    //           margin: EdgeInsets.only(
                    //               left: idx == 0 ? 16 : 8,
                    //               right: idx == model.list_kategori.length - 1
                    //                   ? 16
                    //                   : 8),
                    //           decoration: BoxDecoration(
                    //             color: kaccentcolor,
                    //             borderRadius: BorderRadius.circular(100),
                    //           ),
                    //           width: 50,
                    //           child: Container(
                    //             height: 30,
                    //             width: 30,
                    //             child: Image.network(
                    //               model.list_kategori[idx].icon!,
                    //               width: 30,
                    //               height: 30,
                    //               fit: BoxFit.none,
                    //               scale: 4,
                    //             ),
                    //           ),
                    //         ),
                    //         Container(
                    //           alignment: Alignment.center,
                    //           margin: EdgeInsets.only(left: 16),
                    //           child: Row(
                    //             children: [
                    //               Text(
                    //                 "${model.list_kategori[idx].namaKategori!}",
                    //                 style:
                    //                     blackTextStyle.copyWith(fontSize: 12),
                    //               ),
                    //             ],
                    //           ),
                    //         )
                    //       ],
                    //     );
                    //   },
                    // ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 16, right: 16, top: 16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "New Arrival",
                          style: blackTextStyle.copyWith(
                              fontSize: 18, fontWeight: bold),
                        ),
                        Text(
                          "See all",
                          style: blackTextStyle.copyWith(
                              fontSize: 13,
                              fontWeight: regular,
                              color: ksecondcolor),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 300,
                    margin: EdgeInsets.only(top: 8),
                    child: ListView.builder(
                      itemCount: new_arrival.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (ctx, idx) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 230,
                              margin: EdgeInsets.only(
                                  left: idx == 0 ? 16 : 4,
                                  right:
                                      idx == new_arrival.length - 1 ? 16 : 4),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                    image:
                                        AssetImage(new_arrival[idx]['img_src']),
                                    fit: BoxFit.cover),
                              ),
                              width: 170,
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 16),
                              child: Text(
                                "${new_arrival[idx]['nama_product']}",
                                style: blackTextStyle.copyWith(
                                    fontSize: 15, fontWeight: semiBold),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 16),
                              child: Row(
                                children: [
                                  Text("Rp ${new_arrival[idx]['price']}",
                                      style: blackTextStyle.copyWith(
                                          color: kprimarycolor)),
                                ],
                              ),
                            )
                          ],
                        );
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 16, right: 16, top: 16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Recomended",
                          style: blackTextStyle.copyWith(
                              fontSize: 18, fontWeight: bold),
                        ),
                        Text(
                          "See all",
                          style: blackTextStyle.copyWith(
                              fontSize: 13,
                              fontWeight: regular,
                              color: ksecondcolor),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 300,
                    margin: EdgeInsets.only(top: 8),
                    child: ListView.builder(
                      itemCount: new_arrival.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (ctx, idx) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => DetailProductView(),
                              ),
                            );
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 230,
                                margin: EdgeInsets.only(
                                    left: idx == 0 ? 16 : 4,
                                    right:
                                        idx == new_arrival.length - 1 ? 16 : 4),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                      image: AssetImage(
                                          new_arrival[idx]['img_src']),
                                      fit: BoxFit.cover),
                                ),
                                width: 170,
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 16),
                                child: Text(
                                  "${new_arrival[idx]['nama_product']}",
                                  style: blackTextStyle.copyWith(
                                      fontSize: 15, fontWeight: semiBold),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 16),
                                child: Row(
                                  children: [
                                    Text(
                                      "Rp ${new_arrival[idx]['price']}",
                                      style: blackTextStyle.copyWith(
                                          color: kprimarycolor),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 16, right: 16, top: 16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "All Product",
                          style: blackTextStyle.copyWith(
                              fontSize: 18, fontWeight: bold),
                        ),
                        // Text(
                        //   "See all",
                        //   style: blackTextStyle.copyWith(
                        //       fontSize: 13,
                        //       fontWeight: regular,
                        //       color: ksecondcolor),
                        // ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    child: GridView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            childAspectRatio: 1,
                            crossAxisCount: 2),
                        itemCount: model.listproductall.length,
                        itemBuilder: (ctx, idx) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => DetailProductView(
                                    id: model.listproductall[idx]['id']
                                        .toString(),
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              height: 300,
                              child: Column(
                                children: [
                                  Expanded(
                                    child: Container(
                                      height: 260,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                              "${model.listproductall[idx]['gambar']}"),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "${model.listproductall[idx]['nama_produk']}",
                                      overflow: TextOverflow.ellipsis,
                                      style: blackTextStyle.copyWith(
                                          fontSize: 15, fontWeight: semiBold),
                                    ),
                                  ),
                                  Container(
                                    child: Row(
                                      children: [
                                        Text(
                                          "Rp ${model.listproductall[idx]['harga']}",
                                          style: blackTextStyle.copyWith(
                                              color: kprimarycolor),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        }),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
