import 'package:bramstore/constants/theme.dart';
import 'package:bramstore/ui/views/checkout_view.dart';
import 'package:bramstore/ui/widgets/dash_separator.dart';
import 'package:bramstore/viewmodels/cart_view_model.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class CartView extends StatelessWidget {
  const CartView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CartViewModel>.reactive(
      viewModelBuilder: () => CartViewModel(),
      onModelReady: (model) => model.init(),
      builder: (context, model, child) => Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Cart",
            style: blackTextStyle,
          ),
          elevation: 0,
          backgroundColor: Colors.white,
        ),
        body: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          model.changePage(1);
                        },
                        child: Container(
                          height: 35,
                          margin: EdgeInsets.only(left: 16, right: 4),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(
                                color: model.page == 1
                                    ? ksecondcolor
                                    : Colors.grey.shade300),
                          ),
                          child: Text(
                            "Clothes",
                            style: blackTextStyle.copyWith(
                                color: model.page == 1
                                    ? kprimarycolor
                                    : Colors.grey.shade600),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          model.changePage(2);
                        },
                        child: Container(
                          height: 35,
                          margin: EdgeInsets.only(left: 4, right: 4),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(
                                color: model.page == 2
                                    ? ksecondcolor
                                    : Colors.grey.shade300),
                          ),
                          child: Text(
                            "Food",
                            style: blackTextStyle.copyWith(
                                color: model.page == 2
                                    ? kprimarycolor
                                    : Colors.grey.shade600),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          model.changePage(3);
                        },
                        child: Container(
                          height: 35,
                          margin: EdgeInsets.only(left: 4, right: 16),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(
                                color: model.page == 3
                                    ? ksecondcolor
                                    : Colors.grey.shade300),
                          ),
                          child: Text(
                            "Services",
                            style: blackTextStyle.copyWith(
                                color: model.page == 3
                                    ? kprimarycolor
                                    : Colors.grey.shade600),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(left: 16, right: 16),
                  width: double.infinity,
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: model.list_clothes.length,
                    itemBuilder: (ctx, idx) {
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(
                            child: Container(
                              margin: EdgeInsets.only(
                                  top: idx == 0 ? 16 : 6, bottom: 10),
                              height: 200,
                              width: 150,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(18),
                                child: Image.network(
                                  model.list_clothes[idx]['gambar'],
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 2,
                            child: Container(
                              height: 200,
                              width: double.infinity,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(
                                        top: idx == 0 ? 16 : 0, left: 25),
                                    child: Text(
                                      "${model.list_clothes[idx]['nama']}",
                                      style:
                                          blackTextStyle.copyWith(fontSize: 15),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 16, left: 25),
                                    child: Text(
                                      "Size : ${model.list_clothes[idx]['ukuran']}",
                                      style: blackTextStyle.copyWith(
                                          fontSize: 14,
                                          color: Colors.grey.shade600),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 16, left: 25),
                                    child: Text(
                                      "${model.list_clothes[idx]['harga']}",
                                      style: blackTextStyle.copyWith(
                                          fontSize: 16, fontWeight: semiBold),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      alignment: Alignment.bottomCenter,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(
                                                left: 16, top: 8),
                                            child: Wrap(
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    // model.decreaseQty();
                                                  },
                                                  child: Container(
                                                    height: 35,
                                                    width: 35,
                                                    alignment: Alignment.center,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              6),
                                                      border: Border.all(
                                                          color: Colors
                                                              .grey.shade300),
                                                    ),
                                                    child: Text("-"),
                                                  ),
                                                ),
                                                Container(
                                                  height: 35,
                                                  width: 35,
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                      "${model.list_clothes[idx]['qty'].toString()}"),
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    // model.increaseQty();
                                                  },
                                                  child: Container(
                                                    height: 35,
                                                    width: 35,
                                                    alignment: Alignment.center,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              6),
                                                      border: Border.all(
                                                          color: Colors
                                                              .grey.shade300),
                                                    ),
                                                    child: Text("+"),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            child: IconButton(
                                              onPressed: () {
                                                model.removeCheckout(idx);
                                              },
                                              icon: Icon(Icons.close),
                                              color: Colors.grey.shade400,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      );
                    },
                  ),
                ),
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
                        "Rp ${model.summary}",
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
                        "Shipping",
                        style: blackTextStyle.copyWith(
                            color: Colors.grey.shade500),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 16, top: 12),
                      child: Text(
                        "Rp 0",
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
                        "Rp ${model.summary}",
                        style: blackTextStyle.copyWith(
                            fontSize: 18, fontWeight: semiBold),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 100,
                )
              ],
            ),
          ),
        ),
        floatingActionButton: Container(
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
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => CheckoutView(),
                ),
              );
            },
            child: Text("Checkout"),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}
