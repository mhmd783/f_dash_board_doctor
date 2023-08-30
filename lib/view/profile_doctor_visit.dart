import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'package:provider/provider.dart';

import '../prov/prov.dart';

class profile_doctor_visit extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _profile_doctor_visit();
  }
}

class _profile_doctor_visit extends State<profile_doctor_visit> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<control>(context, listen: false).getdatadoctorvesitprofile();
    });

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<control>(context, listen: false)
          .get_work_time_profile_doctor_visit();
    });
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<control>(context, listen: false)
          .getpost_profile_doctor_visit();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 243, 243, 58),
        iconTheme: IconThemeData(color: Colors.black),
        //toolbarHeight: 0,
      ),
      backgroundColor: Colors.white.withOpacity(0.9),
      body: Consumer<control>(builder: (context, val, child) {
        return !val.datadoctor.isEmpty
            ? Container(
                color: Colors.white,
                margin: MediaQuery.sizeOf(context).width >= 1080
                    ? EdgeInsets.only(
                        left: MediaQuery.sizeOf(context).width / 5,
                        right: MediaQuery.sizeOf(context).width / 5)
                    : null,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Stack(
                        alignment: AlignmentDirectional.bottomEnd,
                        children: [
                          Column(
                            children: [
                              Container(
                                color: Colors.white,
                                height: 200,
                                width: double.infinity,
                                child: Image.asset(
                                  'images/back1.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Divider(
                                color: Colors.black,
                                height: 1,
                                thickness: 1.0,
                              ),
                              Container(
                                //color: Colors.white,
                                height: 50,
                                width: double.infinity,
                              ),
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.only(right: 20),
                            child: CircleAvatar(
                                radius: 50,
                                backgroundColor:
                                    const Color.fromARGB(255, 243, 243, 58),
                                child: Icon(
                                  Icons.person,
                                  color: Colors.black,
                                  size: 50,
                                )),
                          ),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 20),
                        child: Text(
                          "${val.datadoctor[0]['f_name']} ${val.datadoctor[0]['s_name']}",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 30),
                        ),
                      ),
                      Container(
                        margin:
                            EdgeInsets.only(left: 40, right: 25, bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              margin: EdgeInsets.only(right: 20),
                              decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(255, 243, 243, 58),
                                  borderRadius: BorderRadius.circular(10)),
                              child: TextButton(
                                  onPressed: () {
                                    val.addnumberpationt();
                                    _addpationt();
                                  },
                                  child: Text(
                                    "اضافه",
                                    style: TextStyle(color: Colors.black),
                                  )),
                            ),
                            Text(
                              ' عدد المرضي المتاحين ${val.datadoctor[0]['active']}',
                              style: TextStyle(
                                  color: val.datadoctor[0]['active'] == 0
                                      ? Colors.redAccent
                                      : Colors.greenAccent,
                                  fontSize: 20),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin:
                            EdgeInsets.only(left: 40, right: 25, bottom: 10),
                        child: Text(
                          '${(val.datadoctor[0]['power'] - val.datadoctor[0]['active']) * int.parse(val.datadoctor[0]['salary']) * 0.05}',
                          style: TextStyle(color: Colors.black, fontSize: 20),
                        ),
                      ),
                      Container(
                        margin:
                            EdgeInsets.only(left: 40, right: 25, bottom: 10),
                        child: Text(
                          'التخصص: ${val.datadoctor[0]['specialty']}',
                          style: TextStyle(color: Colors.black, fontSize: 20),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                  left: 40, right: 25, bottom: 10),
                              child: Text(
                                ' ${val.datadoctor[0]['phone']}',
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              child: Icon(Icons.call),
                              margin: EdgeInsets.only(right: 25),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                  left: 40, right: 25, bottom: 10),
                              child: Text(
                                ' ${val.datadoctor[0]['pass']}',
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              child: Icon(Icons.password),
                              margin: EdgeInsets.only(right: 25),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                  left: 40, right: 25, bottom: 10),
                              child: Text(
                                ' ${val.datadoctor[0]['email']}',
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              child: Icon(Icons.email),
                              margin: EdgeInsets.only(right: 25),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                  left: 40, right: 25, bottom: 10),
                              child: Text(
                                'التقييمات ${val.datadoctor[0]['rating']}',
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              child: Icon(Icons.star_border),
                              margin: EdgeInsets.only(right: 25),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                  left: 40, right: 25, bottom: 10),
                              child: Text(
                                '${val.datadoctor[0]['salary']} الكشف ',
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 15),
                              ),
                            ),
                            Container(
                              child: Icon(
                                Icons.money,
                                size: 35,
                              ),
                              margin: EdgeInsets.only(right: 25),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              alignment: Alignment.topRight,
                              margin: EdgeInsets.only(
                                  left: 40, right: 25, bottom: 10),
                              child: Text(
                                "${val.datadoctor[0]['city']}-${val.datadoctor[0]['area']}-${val.datadoctor[0]['streat']}-${val.datadoctor[0]['number_build']}",
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 15),
                                maxLines: 10,
                                textAlign: TextAlign.end,
                              ),
                            ),
                            Container(
                              child: Icon(
                                Icons.location_on,
                                size: 35,
                              ),
                              margin: EdgeInsets.only(right: 25),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        child: Center(
                            child: Text(
                          'مواعيد الحجز',
                          style: TextStyle(fontSize: 20),
                        )),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            top: 10, left: 25, right: 25, bottom: 10),
                        width: double.infinity,
                        height: 150,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: val.data_work_time_get == []
                                ? 0
                                : val.data_work_time_get.length,
                            itemBuilder: (context, i) {
                              return Container(
                                width: 80,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  // color: const Color.fromARGB(255, 243, 243, 58),
                                  border: Border(
                                    bottom: BorderSide(
                                      color: Colors.black,
                                      width: 1.0,
                                    ),
                                    top: BorderSide(
                                      color: Colors.black,
                                      width: 1.0,
                                    ),
                                    right: BorderSide(
                                      color: Colors.black,
                                      width: 1.0,
                                    ),
                                    left: BorderSide(
                                      color: Colors.black,
                                      width: 1.0,
                                    ),
                                  ),
                                ),
                                margin: EdgeInsets.only(left: 10),
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        '${val.data_work_time_get[i]['day']}',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        '${val.data_work_time_get[i]['start_time']}',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        '${val.data_work_time_get[i]['end_time']}',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    // IconButton(
                                    //     onPressed: () {

                                    //     },
                                    //     icon: Icon(Icons.delete)),
                                  ],
                                ),
                              );
                            }),
                      ),

                      /////////////////////////////////////
                      Container(
                        margin:
                            EdgeInsets.only(left: 40, right: 25, bottom: 10),
                        child: Text(
                          'معلومات عن الدكتور ',
                          style: TextStyle(color: Colors.black, fontSize: 20),
                          textAlign: TextAlign.end,
                        ),
                      ),
                      Container(
                        margin:
                            EdgeInsets.only(left: 40, right: 30, bottom: 10),
                        child: Text(
                          '${val.datadoctor[0]['description']} ',
                          style: TextStyle(color: Colors.grey, fontSize: 15),
                          textAlign: TextAlign.end,
                        ),
                      ),
                      //Divider>
                      Container(
                        margin: EdgeInsets.only(left: 10, right: 10),
                        child: Divider(
                          color: Colors.black,
                          thickness: 1,
                        ),
                      ),
                      /////////////////////////////////////////////////////////////posts

                      !val.post_visit.isEmpty
                          ? Container(
                              width: double.infinity,
                              height: MediaQuery.of(context).size.height - 200,
                              child: ListView.builder(
                                  itemCount: val.post_visit.length,
                                  itemBuilder: (context, i) {
                                    return Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Container(
                                              margin:
                                                  EdgeInsets.only(right: 10),
                                              child: Text(
                                                "${val.post_visit[i]['f_name']} ${val.post_visit[i]['s_name']}",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20),
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(
                                                  right: 20, bottom: 10),
                                              child: CircleAvatar(
                                                  radius: 20,
                                                  backgroundColor:
                                                      const Color.fromARGB(
                                                          255, 243, 243, 58),
                                                  child: Icon(
                                                    Icons.person,
                                                    color: Colors.black,
                                                    size: 20,
                                                  )),
                                            ),
                                          ],
                                        ),
                                        Container(
                                          alignment: Alignment.topRight,
                                          margin: EdgeInsets.only(
                                              left: 40, right: 40, bottom: 10),
                                          child: Text(
                                            ' ${val.post_visit[i]['post']}',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 20,
                                            ),
                                            maxLines: 10,
                                            textAlign: TextAlign.end,
                                          ),
                                        ),
                                        Container(
                                          width: double.infinity,
                                          height: 10,
                                          color: Colors.grey.shade400,
                                        ),
                                      ],
                                    );
                                  }))
                          : Center(
                              child: Text('لا يوجد بيانات '),
                            ),
                    ],
                  ),
                ),
              )
            : Center(
                child: CircularProgressIndicator(),
              );
      }),
    );
  }

  _addpationt() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          scrollable: true,
          title: const Text("تفعيل حساب الدكتور"),
          elevation: 10,
          content: Form(
            child: Consumer<control>(builder: (context, val, child) {
              return Column(
                children: [
                  TextFormField(
                    controller: val.pationt,
                    decoration: InputDecoration(label: Text("اضف عدد المرضي")),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 243, 243, 58),
                        borderRadius: BorderRadius.circular(10)),
                    child: TextButton(
                        onPressed: () {
                          if (val.pationt.text!= '') {
                            val.add();
                            Navigator.of(context).pop();
                            _check_active_doctor();
                          }
                        },
                        child: Text(
                          "اضافه",
                          style: TextStyle(color: Colors.black),
                        )),
                  ),
                ],
              );
            }),
          ),
          actions: <Widget>[
            CircleAvatar(
              backgroundColor: Colors.grey.shade300,
              child: Consumer<control>(builder: (context, val, child) {
                return IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                );
              }),
            ),
          ],
        );
      },
    );
  }

  Future<void> _check_active_doctor() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          scrollable: true,
          title: const Text('تحقق'),
          elevation: 10,
          content: Form(
            child: Consumer<control>(builder: (context, val, child) {
              return Column(
                children: [
                  Center(
                    child: val.active[0]['mes'] == 'good'
                        ? Text(
                            'تم تفعيل الحساب ',
                            style: TextStyle(
                                color: Colors.greenAccent, fontSize: 15),
                          )
                        : CircularProgressIndicator(),
                  ),
                ],
              );
            }),
          ),
          actions: <Widget>[
            CircleAvatar(
              backgroundColor: Colors.grey.shade300,
              child: Consumer<control>(builder: (context, val, child) {
                return IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                );
              }),
            ),
          ],
        );
      },
    );
  }
}
