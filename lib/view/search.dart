import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../prov/prov.dart';
import 'package:provider/provider.dart';

class search extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _search();
  }
}

class _search extends State<search> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "ابحث عن الدكتور باسمه",
            textAlign: TextAlign.center,
          ),
          duration: Duration(seconds: 3),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          // leading: Container(
          //   margin: EdgeInsets.only(right: 10),
          //   child: Consumer<control>(builder: (context, val, child) {
          //     return IconButton(
          //         onPressed: () {
          //           val.getsearch();
          //         },
          //         icon: Icon(
          //           Icons.search,
          //           color: Colors.black,
          //         ));
          //   }),
          // ),
          title: Consumer<control>(builder: (context, val, child) {
            return TextFormField(
              controller: val.search,
              keyboardType: TextInputType.number,
              inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'\d')),
                    ],
              decoration: InputDecoration(
                label: Text(
                  'رقم تلفون الدكتور',
                  
                  style: TextStyle(color: Colors.grey),
                  
                ),
              ),
            );
          }),
          backgroundColor: const Color.fromARGB(255, 243, 243, 58),
        ),
        body: Consumer<control>(builder: (context, val, child) {
          return !val.searches.isEmpty
              ? Container(
                  child: ListView.builder(
                      itemCount: val.searches.length,
                      itemBuilder: (constant, i) {
                        return Card(
                            color: val.searches[i]['active'] == 0
                                ? Colors.redAccent.withOpacity(.7)
                                : Colors.greenAccent.withOpacity(.7),
                            margin: EdgeInsets.all(10),
                            elevation: 20,
                            child: ListTile(
                              onTap: () {
                                val.getiddoctorfrompagesearch(i);
                                Navigator.of(context)
                                    .pushNamed("profile_doctor_visit");
                              },
                              leading: CircleAvatar(
                                  backgroundColor:
                                      const Color.fromARGB(255, 243, 243, 58),
                                  child: Icon(
                                    Icons.person,
                                    color: Colors.black,
                                  )),
                              title: Text(
                                "د: ${val.searches[i]['f_name']} ${val.searches[i]['s_name']}",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(
                                '${val.searches[i]['city']}-${val.searches[i]['area']}-${val.searches[i]['streat']}-${val.searches[i]['number_build']}',
                                style: TextStyle(color: Colors.black),
                              ),
                              trailing: Text('${val.searches[i]['active']}'),
                            ));
                      }),
                )
              : Center(
                  child: Text(
                    'لا يوجد بيانات',
                    style: TextStyle(color: Colors.grey, fontSize: 20),
                  ),
                );
        }),
        floatingActionButton: Consumer<control>(builder: (context, val, child) {
          return FloatingActionButton(
            backgroundColor: const Color.fromARGB(255, 243, 243, 58),
            child: Icon(
              Icons.search,
              color: Colors.black,
            ),
            onPressed: () {
              val.getsearch();
            },
          );
        }));
  }
}
