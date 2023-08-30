import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:provider/provider.dart';

import '../prov/prov.dart';

class active_doctor extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _active_doctor();
  }
}

class _active_doctor extends State<active_doctor> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<control>(context, listen: false)
          .cleandatadoctorinpageactivedoctor();
    });
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<control>(context, listen: false)
          .get_number_of_doctors_active();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: MediaQuery.sizeOf(context).width <= 1080
              ? IconButton(
                  onPressed: () {
                    _menu();
                  },
                  icon: Icon(
                    Icons.menu,
                    color: Colors.black,
                  ))
              : Icon(
                  Icons.medical_information,
                  color: Colors.black,
                ),
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
            'دكاتره نشطه',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
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
                                        Navigator.of(context)
                                            .pushNamed("profile_doctor_visit");
                                      },
                                      leading: CircleAvatar(
                                          backgroundColor: const Color.fromARGB(
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
                                          val.getalldoctorsactive();
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
            MediaQuery.sizeOf(context).width >= 1080
                  ?Expanded(
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
                )): Expanded(flex: 0, child: Container()),
          ],
        );
      }),
    );
  }
  Future<void> _menu() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          scrollable: true,
          title: const Text('menu'),
          elevation: 10,
          content: Form(
            child: Consumer<control>(builder: (context, val, child) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.end,
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
                        Navigator.of(context).pop();
                        Navigator.of(context).pushReplacementNamed('doctor');
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
                        Navigator.of(context).pop();
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
                        Navigator.of(context).pop();
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
                        Navigator.of(context).pop();
                        Navigator.of(context).pushReplacementNamed('pationt');
                      },
                      title: Text('pationt'),
                      trailing: Text('${val.numberpationt}'),
                    ),
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
