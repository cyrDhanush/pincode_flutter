import 'package:flutter/material.dart';
import 'package:pincode_api/api.dart';
import 'package:pincode_api/provider.dart';
import 'package:provider/provider.dart';

class homePage extends StatefulWidget {
  const homePage({Key? key}) : super(key: key);

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage>
    with SingleTickerProviderStateMixin {
  List datalist = <dataModel>[];
  int currentvalue = 0;
  int currentpincode = 604407;
  TextEditingController pincodecontroller = TextEditingController();
  late AnimationController controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = AnimationController(vsync: this);
    pincodecontroller.text = currentpincode.toString();
    refreshdata();
  }

  Future refreshdata() {
    return fetchdata(pincode: int.parse(pincodecontroller.text));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pincode"),
        actions: [
          IconButton(
            onPressed: () {
              context.read<themeprovider>().toggle();
            },
            icon: AnimatedCrossFade(
              firstChild: Icon(
                Icons.light_mode_rounded,
                color: Theme.of(context).primaryColorDark,
              ),
              secondChild: Icon(
                Icons.dark_mode_rounded,
                color: Theme.of(context).primaryColorLight,
              ),
              crossFadeState:
                  (context.watch<themeprovider>().current_theme == 0)
                      ? (CrossFadeState.showFirst)
                      : (CrossFadeState.showSecond),
              duration: Duration(milliseconds: 300),
            ),
          ),
        ],
      ),
      body: Container(
        alignment: Alignment.topCenter,
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 30,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.4,
                child: TextField(
                  controller: pincodecontroller,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    label: Text("Pincode"),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 5, horizontal: 13),
                  ),
                  onSubmitted: (s) {
                    setState(() {
                      currentvalue = 0;
                      refreshdata();
                      FocusManager.instance.primaryFocus?.unfocus();
                    });
                  },
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    currentvalue = 0;
                    refreshdata();
                    FocusManager.instance.primaryFocus?.unfocus();
                  });
                },
                child: Text("Search"),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                child: FutureBuilder(
                  future: refreshdata(),
                  builder: (context, snapshot) {
                    if (snapshot.data != null &&
                        snapshot.data.statuscode == 'Success' &&
                        snapshot.data.datalist.length > 1) {
                      return Container(
                        height: 50,
                        // width: 250,
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: Theme.of(context).primaryColor,
                            width: 0.5,
                          ),
                        ),
                        child: DropdownButton(
                          value: currentvalue,
                          underline: Container(),
                          style: Theme.of(context).textTheme.titleMedium,
                          borderRadius: BorderRadius.circular(16),
                          icon: const Icon(Icons.keyboard_arrow_down),
                          items: [
                            for (int i = 0;
                                i < snapshot.data.datalist.length;
                                i++)
                              DropdownMenuItem(
                                value: i,
                                child: Text(snapshot.data.datalist[i].cityname),
                              ),
                          ],
                          onChanged: (int? a) {
                            setState(
                              () {
                                currentvalue = a!;
                              },
                            );
                          },
                        ),
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
              ),
              SizedBox(
                height: 25,
              ),
              FutureBuilder(
                future: refreshdata(),
                builder: (context, snapshot) {
                  if (snapshot.data != null) {
                    if (snapshot.data.statuscode == 'Error') {
                      return Container(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 30,
                            ),
                            Text(
                              "Enter Correct Pincode",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.red,
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                          ],
                        ),
                      );
                    } else {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Theme(
                            data: Theme.of(context).copyWith(
                              dividerColor: Colors.transparent,
                            ),
                            child: Card(
                              elevation: 7,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: DataTable(
                                headingRowHeight: 0,
                                columns: [
                                  DataColumn(
                                    label: Text(""),
                                  ),
                                  DataColumn(
                                    label: Text(""),
                                  ),
                                ],
                                rows: [
                                  DataRow(
                                    cells: [
                                      DataCell(
                                        Text(
                                          "City/Town: ",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium,
                                        ),
                                      ),
                                      DataCell(
                                        Text(
                                          snapshot.data.datalist[currentvalue]
                                              .cityname,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall,
                                        ),
                                      ),
                                    ],
                                  ),
                                  DataRow(
                                    cells: [
                                      DataCell(
                                        Text(
                                          "Block: ",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium,
                                        ),
                                      ),
                                      DataCell(
                                        Text(
                                          snapshot.data.datalist[currentvalue]
                                              .block,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall,
                                        ),
                                      ),
                                    ],
                                  ),
                                  DataRow(
                                    cells: [
                                      DataCell(
                                        Text(
                                          "District: ",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium,
                                        ),
                                      ),
                                      DataCell(
                                        Text(
                                          snapshot.data.datalist[currentvalue]
                                              .district,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall,
                                        ),
                                      ),
                                    ],
                                  ),
                                  DataRow(
                                    cells: [
                                      DataCell(
                                        Text(
                                          "State: ",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium,
                                        ),
                                      ),
                                      DataCell(
                                        Text(
                                          snapshot.data.datalist[currentvalue]
                                              .state,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall,
                                        ),
                                      ),
                                    ],
                                  ),
                                  DataRow(
                                    cells: [
                                      DataCell(
                                        Text(
                                          "Pincode: ",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium,
                                        ),
                                      ),
                                      DataCell(
                                        Text(
                                          snapshot.data.datalist[currentvalue]
                                              .pincode,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                        ],
                      );
                    }
                  } else {
                    return Container(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 30,
                          ),
                          CircularProgressIndicator(),
                          SizedBox(
                            height: 30,
                          ),
                        ],
                      ),
                    );
                  }
                },
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
