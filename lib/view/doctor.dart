import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:provider/provider.dart';

import '../prov/prov.dart';

class doctor extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _doctor();
  }
}

class _doctor extends State<doctor> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<control>(context, listen: false)
          .cleandatadoctorinpagedoctor();
    });
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<control>(context, listen: false).get_number_of_doctors();
    });
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<control>(context, listen: false)
          .get_number_of_doctors_active();
    });
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<control>(context, listen: false)
          .get_number_of_doctors_not_active();
    });
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<control>(context, listen: false).get_number_of_pationt();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            Container(
                margin: EdgeInsets.only(top: 5),
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed("search");
                  },
                  child: Text(
                    "بحث عن دكتور",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                )),
            Container(
              margin: EdgeInsets.only(right: 10),
              child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed("search");
                  },
                  icon: Icon(
                    Icons.search,
                    color: Colors.black,
                  )),
            )
          ],
          title: Consumer<control>(builder: (context, val, child) {
            return Text(
              'كل الدكاتره',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            );
          }),
          backgroundColor: const Color.fromARGB(255, 243, 243, 58),
        ),
        body: Consumer<control>(builder: (context, val, child) {
          return Row(
            children: [
              Expanded(
                flex: 7,
                child: !val.doctors.isEmpty
                    ? Container(
                        margin: EdgeInsets.only(bottom: 10),
                        child: ListView.builder(
                            itemCount: val.doctors.length + 1,
                            itemBuilder: (constant, i) {
                              if (i < val.doctors.length) {
                                if (val.indexenddoctor > val.doctors[i]['id'] ||
                                    val.indexenddoctor == 1) {
                                  val.indexenddoctor = val.doctors[i]['id'];
                                }
                              }
                              return i < val.doctors.length
                                  ? Card(
                                      color: val.doctors[i]['active'] == 0
                                          ? Colors.redAccent.withOpacity(.7)
                                          : Colors.greenAccent.withOpacity(.7),
                                      margin: EdgeInsets.all(10),
                                      elevation: 20,
                                      child: ListTile(
                                        onTap: () {
                                          val.getiddoctorfrompagedoctor(i);
                                          Navigator.of(context).pushNamed(
                                              "profile_doctor_visit");
                                        },
                                        leading: CircleAvatar(
                                            backgroundColor:
                                                const Color.fromARGB(
                                                    255, 243, 243, 58),
                                            child: Icon(
                                              Icons.person,
                                              color: Colors.black,
                                            )),
                                        title: Text(
                                          "د: ${val.doctors[i]['f_name']} ${val.doctors[i]['s_name']}",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        subtitle: Text(
                                          '${val.doctors[i]['city']}-${val.doctors[i]['area']}-${val.doctors[i]['streat']}-${val.doctors[i]['number_build']}',
                                          style: TextStyle(color: Colors.black),
                                        ),
                                        trailing: Text(
                                            'عدد الحجوزات المتاحه ${val.doctors[i]['active']}'),
                                      ))
                                  : Center(
                                      child: IconButton(
                                          onPressed: () {
                                            val.getalldoctors();
                                          },
                                          icon: Icon(
                                            Icons.refresh,
                                            size: 40,
                                          )));
                            }),
                      )
                    : Center(
                        child: CircularProgressIndicator(),
                      ),
              ),
              //pages/////////////////////////////////////////////////////
              Expanded(
                  flex: 2,
                  child: Container(
                    child: Column(
                      children: [
                        Card(
                          margin: EdgeInsets.all(10),
                          elevation: 20,
                          color: val.screen == 0
                              ? Colors.grey.withOpacity(0.4)
                              : Colors.white,
                          child: ListTile(
                            onTap: () {
                              //val.cleandatadoctorinpagedoctor();
                              val.change_screen_doctor();

                              Navigator.of(context)
                                  .pushReplacementNamed('doctor');
                            },
                            title: Text('Doctores'),
                            trailing: Text('${val.numberdoctor}'),
                          ),
                        ),
                        Card(
                          margin: EdgeInsets.all(10),
                          elevation: 20,
                          color: val.screen == 1
                              ? Colors.grey.withOpacity(0.4)
                              : Colors.white,
                          child: ListTile(
                            onTap: () {
                              //val.cleandatadoctorinpageactivedoctor();
                              val.change_screen_active_doctor();
                              Navigator.of(context)
                                  .pushReplacementNamed('active_doctor');
                            },
                            title: Text('active doctores'),
                            trailing: Text('${val.numberdoctoractive}'),
                          ),
                        ),
                        Card(
                          margin: EdgeInsets.all(10),
                          elevation: 20,
                          color: val.screen == 2
                              ? Colors.grey.withOpacity(0.4)
                              : Colors.white,
                          child: ListTile(
                            onTap: () {
                              val.change_screen_not_active_doctor();

                              Navigator.of(context)
                                  .pushReplacementNamed('not_active_doctor');
                            },
                            title: Text('not active doctores'),
                            trailing: Text('${val.numberdoctornotactive}'),
                          ),
                        ),
                        Card(
                          margin: EdgeInsets.all(10),
                          elevation: 20,
                          color: val.screen == 3
                              ? Colors.grey.withOpacity(0.4)
                              : Colors.white,
                          child: ListTile(
                            onTap: () {
                              val.change_screen_pationt();
                              Navigator.of(context)
                                  .pushReplacementNamed('pationt');
                            },
                            title: Text('pationt'),
                            trailing: Text('${val.numberpationt}'),
                          ),
                        ),
                      ],
                    ),
                  )),
            ],
          );
        }),
        floatingActionButton: Consumer<control>(builder: (context, val, child) {
          return FloatingActionButton(
            backgroundColor: const Color.fromARGB(255, 243, 243, 58),
            child: Icon(
              Icons.person_search,
              color: Colors.black,
            ),
            onPressed: () {
              val.getspcialty();

              _Search();
            },
          );
        }));
  }

  //////////////////////////////////////////////////////
  Future<void> _Search() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          scrollable: true,
          title: const Text('بحث'),
          elevation: 10,
          content: Form(
            child: Consumer<control>(builder: (context, val, child) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    margin: EdgeInsets.all(10),
                    child: Text(
                      'اختار التخصص',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    width: 300,
                    height: 40,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: val.specialty.length,
                        itemBuilder: (context, i) {
                          return Container(
                            decoration: BoxDecoration(
                                color: val.indspecialty == i
                                    ? Colors.grey
                                    : const Color.fromARGB(255, 243, 243, 58),
                                borderRadius: BorderRadius.circular(50)),
                            margin: EdgeInsets.only(left: 10),
                            child: TextButton(
                                onPressed: () {
                                  val.changespecialty(i);
                                },
                                child: Text(
                                  '${val.specialty[i]}',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                )),
                          );
                        }),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    child: Text(
                      'اختار المدينه',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    width: 300,
                    height: 40,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: val.city.length,
                        itemBuilder: (context, i) {
                          return Container(
                            decoration: BoxDecoration(
                                color: val.indcity == i
                                    ? Colors.grey
                                    : const Color.fromARGB(255, 243, 243, 58),
                                borderRadius: BorderRadius.circular(50)),
                            margin: EdgeInsets.only(left: 10),
                            child: TextButton(
                                onPressed: () {
                                  val.changecity(i);
                                },
                                child: Text(
                                  '${val.city[i]}',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                )),
                          );
                        }),
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
                    Icons.search,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    val.doctors = [];
                    val.indexenddoctor = 1;
                    val.getalldoctors();
                    val.get_number_of_doctors();
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
