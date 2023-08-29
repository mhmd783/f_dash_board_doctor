import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../prov/prov.dart';

class pationt extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _pationt();
  }
}

class _pationt extends State<pationt> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<control>(context, listen: false).get_number_of_pationt();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "عدد المرضي ",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: const Color.fromARGB(255, 243, 243, 58),
      ),
      body: Consumer<control>(builder: (context, val, child) {
        return Row(
          children: [
            Expanded(
                flex: 7,
                child: Container(
                    child: Center(
                        child: Text(
                  "${val.numberpationt}",
                  style: TextStyle(fontSize: 40, color: Colors.grey),
                )))),
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
                )),
          ],
        );
      }),
    );
  }
}
