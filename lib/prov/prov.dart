import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import 'dart:convert';

class control extends ChangeNotifier {
  String ip = 'localhost';

  int gender = 0;

  List<String> specialty = [""];
  List<String> city = [""];

  int indcity = 0;
  int indspecialty = 0;
  //signup////////////////////////////////////////////////////
  TextEditingController name = new TextEditingController();
  TextEditingController phone = new TextEditingController();
  TextEditingController pass = new TextEditingController();
  TextEditingController pass1 = new TextEditingController();
  TextEditingController age = new TextEditingController();
  String genderform = '';

  var datarigester = null;

  void registernew() async {
    datarigester = null;
    String url =
        "http://$ip/doctor/view/siginup.php?name=${name.text}&phone=${phone.text}&pass=${pass.text}&age=${age.text}&gender=${genderform}";

    try {
      var responseregister = await http.get(Uri.parse(url));
      if (!responseregister.body.isEmpty) {
        var responsebody = jsonDecode(responseregister.body);

        datarigester = responsebody;
      }
    } catch (e) {
      print(e);
    }
    print(datarigester);
    print(datarigester);
    print(datarigester);
    notifyListeners();
  }

  //signin///////////////////////////////////////////
  TextEditingController phonesignin = new TextEditingController();
  TextEditingController passsignin = new TextEditingController();

  //get account

  var data = null;
  void getdata() async {
    data = null;
    String url =
        "http://$ip/doctor/view/signin.php?phone=${phonesignin.text}&pass=${passsignin.text}";

    try {
      var response = await http.get(Uri.parse(url));
      if (!response.body.isEmpty) {
        var responsebody = jsonDecode(response.body);
        data = responsebody;
      }
    } catch (e) {
      print(e);
    }
    print('object');
    print('object');
    print('object');
    print('object');
    print("${data}");
    notifyListeners();
  }

  void chosegender(String type) {
    if (type == 'male') {
      genderform = type;
      gender = 1;
    }
    if (type == 'fmale') {
      genderform = type;
      gender = 2;
    }
    notifyListeners();
  }

  //////////////////////////////////////////////////////////////////////////////////////////////
  /////////////////////////////////////////////////////////////////////////
  ///

  TimeOfDay timestart = TimeOfDay.now();
  TimeOfDay timeend = TimeOfDay.now();
  String timestartnew = '00:00';
  String timeendnew = "00:00";

  String day = '';
  List<String> weak = [
    "",
    "السبت",
    "الاحد",
    "الاتنين",
    "الثلاثاء",
    "الاربعاء",
    "الخميس",
    "الجمعه",
  ];

  //page profile
  List data_work_time = [
    {'mes': 'not'}
  ];
  //
  List data_work_time_get = [];

  String cityt = '';
  void changecity(i) {
    indcity = i;
    cityt = city[i];
    notifyListeners();
  }

  String specialtyt = '';
  void changespecialty(i) {
    indspecialty = i;
    specialtyt = specialty[i];
    notifyListeners();
  }

  void chosestarttime(String x) {
    timestartnew = x;
    notifyListeners();
  }

  void choseendtime(String x) {
    timeendnew = x;
    notifyListeners();
  }

  choseday(int x) {
    day = weak[x];

    notifyListeners();
  }

  int idday = 0;
  changeidday(int x) {
    idday = x;
    notifyListeners();
  }

  //page home doctor

  List posts = [];
  int indexendpost = 1;
  void getallposts() async {
    //posts = [];
    String url = "http://$ip/doctor/view/get_all_posts.php?id=$indexendpost";
    try {
      var response = await http.get(Uri.parse(url));
      if (!response.body.isEmpty) {
        var responsebody = jsonDecode(response.body);
        //posts.add(responsebody);
        for (var post in responsebody) {
          posts.add(post);
        }
      }
    } catch (e) {
      print(e);
    }
    print('${posts}');
    //changeIconlike();
    notifyListeners();
  }

  //page profile doctor visit ///////////////////////////////
  int id_doctor = 0;
  getiddoctor(int i) {
    id_doctor = int.parse(posts[i]['id_doctor']);
  }

  List datadoctor = [];
  void getdatadoctorvesitprofile() async {
    datadoctor = [];
    String url = "http://$ip/doctor/view/signindoc.php?id=$id_doctor";

    try {
      var response = await http.get(Uri.parse(url));
      if (!response.body.isEmpty) {
        var responsebody = jsonDecode(response.body);

        datadoctor = responsebody;
      }
    } catch (e) {
      print(e);
    }

    print('${datadoctor}');
    notifyListeners();
  }

  void get_work_time_profile_doctor_visit() async {
    data_work_time_get = [
      {'mes': 'not'}
    ];
    String url =
        "http://$ip/doctor/view/get_time_work.php?id_doctor=${id_doctor.toString()}";
    try {
      var response = await http.get(Uri.parse(url));
      if (!response.body.isEmpty) {
        var responsebody = jsonDecode(response.body);
        data_work_time_get = responsebody;
      }
    } catch (e) {
      print("$e");
    }
    print('${data_work_time_get}');

    notifyListeners();
  }

  List post_visit = [];
  void getpost_profile_doctor_visit() async {
    post_visit = [];
    String url =
        "http://$ip/doctor/view/add_post_doc.php?id_doctor=${id_doctor.toString()}&get=get";
    try {
      var response = await http.get(Uri.parse(url));
      if (!response.body.isEmpty) {
        var responsebody = jsonDecode(response.body);
        post_visit = responsebody;
      }
    } catch (e) {
      print(e);
    }
    print('post');
    print('${post_visit}');
    print('post');

    notifyListeners();
  }

  //page doctor/////////////////////////////////////////////////////////////////
  List doctors = [];
  int indexenddoctor = 1;
  cleandatadoctorinpagedoctor() {
    doctors = [];
    indexenddoctor = 1;
    getalldoctors();
  }

  void getalldoctors() async {
    String url =
        "http://$ip/doctor/view/get_doctors.php?id=$indexenddoctor&specialty=$specialtyt&city=$cityt";
    try {
      var response = await http.get(Uri.parse(url));
      if (!response.body.isEmpty) {
        var responsebody = jsonDecode(response.body);
        //posts.add(responsebody);
        for (var doc in responsebody) {
          doctors.add(doc);
        }
      }
    } catch (e) {
      print(e);
    }
    print('${doctors}');
    //changeIconlike();
    notifyListeners();
  }

  getiddoctorfrompagedoctor(int i) {
    id_doctor = doctors[i]['id'];
  }

  void getcitys() async {
    city = [""];
    String url = "http://$ip/doctor/view/get_doctors.php?getcity=getcity";
    try {
      var response = await http.get(Uri.parse(url));
      if (!response.body.isEmpty) {
        var responsebody = jsonDecode(response.body);
        //posts.add(responsebody);
        for (var doc in responsebody) {
          city.add(doc['city']);
        }
      }
    } catch (e) {
      print(e);
    }
    print('${city}');

    notifyListeners();
  }

  void getspcialty() async {
    specialty = [""];
    String url =
        "http://$ip/doctor/view/get_doctors.php?getspcialty=getspcialty";
    try {
      var response = await http.get(Uri.parse(url));
      if (!response.body.isEmpty) {
        var responsebody = jsonDecode(response.body);
        //posts.add(responsebody);
        for (var row in responsebody) {
          specialty.add(row['specialty']);
        }
      }
    } catch (e) {
      print(e);
    }
    print('${specialty}');
    getcitys();
    notifyListeners();
  }

  TextEditingController search = new TextEditingController();
  List searches = [];
  void getsearch() async {
    searches = [];
    String url = "http://$ip/doctor/view/dash_board.php?phone=${search.text}";
    try {
      var response = await http.get(Uri.parse(url));
      if (!response.body.isEmpty) {
        var responsebody = jsonDecode(response.body);
        //posts.add(responsebody);
        searches = responsebody;
      }
    } catch (e) {
      print(e);
    }
    print('${searches}');
    //changeIconlike();
    notifyListeners();
  }

  getiddoctorfrompagesearch(int i) {
    id_doctor = searches[i]['id'];
  }

  TextEditingController pationt = new TextEditingController();
  addnumberpationt() {
    pationt.text = "5";
  }

  List active = [
    {"mes": "not"}
  ];
  add() async {
    active = [
      {"mes": "not"}
    ];
    String url =
        "http://$ip/doctor/view/dash_board.php?id_doctor=${id_doctor}&active=${pationt.text}";
    try {
      var response = await http.get(Uri.parse(url));
      if (!response.body.isEmpty) {
        var responsebody = jsonDecode(response.body);
        //posts.add(responsebody);
        active = responsebody;
        getdatadoctorvesitprofile();
        searches = [];
        getsearch();
        indexenddoctor = 1;
        doctors = [];
        getalldoctors();
      }
    } catch (e) {
      print(e);
    }
    print('${active}');

    //changeIconlike();
    notifyListeners();
  }

  int screen = 0;
  change_screen_doctor() {
    screen = 0;
    notifyListeners();
  }

  change_screen_active_doctor() {
    screen = 1;
    notifyListeners();
  }

  change_screen_not_active_doctor() {
    screen = 2;
    notifyListeners();
  }

  change_screen_pationt() {
    screen = 3;
    notifyListeners();
  }

  //page active doctor/////////////////////////

  cleandatadoctorinpageactivedoctor() {
    doctors = [];
    indexenddoctor = 1;
    getalldoctorsactive();
  }

  void getalldoctorsactive() async {
    String url =
        "http://$ip/doctor/view/dash_board.php?id=$indexenddoctor&active=1";
    try {
      var response = await http.get(Uri.parse(url));
      if (!response.body.isEmpty) {
        var responsebody = jsonDecode(response.body);
        //posts.add(responsebody);
        for (var doc in responsebody) {
          doctors.add(doc);
        }
      }
    } catch (e) {
      print(e);
    }
    print('${doctors}');
    //changeIconlike();
    notifyListeners();
  }

  //page not active////////////////////////////
  cleandatadoctorinpagenotactivedoctor() {
    doctors = [];
    indexenddoctor = 1;
    getalldoctorsnotactive();
  }

  void getalldoctorsnotactive() async {
    String url =
        "http://$ip/doctor/view/dash_board.php?id=$indexenddoctor&active=0";
    try {
      var response = await http.get(Uri.parse(url));
      if (!response.body.isEmpty) {
        var responsebody = jsonDecode(response.body);
        //posts.add(responsebody);
        for (var doc in responsebody) {
          doctors.add(doc);
        }
      }
    } catch (e) {
      print(e);
    }
    print('${doctors}');
    //changeIconlike();
    notifyListeners();
  }
  //get number doctor
  int numberdoctor = 0;
  get_number_of_doctors() async {
    String url =
        "http://$ip/doctor/view/numberdoctordashboard.php?get=getnumberdoctor&specialty=$specialtyt&city=$cityt";
    try {
      var response = await http.get(Uri.parse(url));
      if (!response.body.isEmpty) {
        var responsebody = jsonDecode(response.body);
        //posts.add(responsebody);
        for (var doc in responsebody) {
          numberdoctor = doc['mes'];
        }
      }
    } catch (e) {
      print(e);
    }
    print('${numberdoctor}');
    //changeIconlike();
    notifyListeners();
  }
  //get number doctor active 
  int numberdoctoractive = 0;
  get_number_of_doctors_active() async {
    String url =
        "http://$ip/doctor/view/numberdoctordashboard.php?get=getnumberdoctoractive";
    try {
      var response = await http.get(Uri.parse(url));
      if (!response.body.isEmpty) {
        var responsebody = jsonDecode(response.body);
        //posts.add(responsebody);
        for (var doc in responsebody) {
          numberdoctoractive = doc['mes'];
        }
      }
    } catch (e) {
      print(e);
    }
    print('${numberdoctoractive}');
    //changeIconlike();
    notifyListeners();
  }
  //get number doctor not active
  int numberdoctornotactive = 0;
  get_number_of_doctors_not_active() async {
    String url =
        "http://$ip/doctor/view/numberdoctordashboard.php?get=getnumberdoctornotactive";
    try {
      var response = await http.get(Uri.parse(url));
      if (!response.body.isEmpty) {
        var responsebody = jsonDecode(response.body);
        //posts.add(responsebody);
        for (var doc in responsebody) {
          numberdoctornotactive = doc['mes'];
        }
      }
    } catch (e) {
      print(e);
    }
    print('${numberdoctornotactive}');
    //changeIconlike();
    notifyListeners();
  }

  //get number pationt
  int numberpationt = 0;
  get_number_of_pationt() async {
    String url =
        "http://$ip/doctor/view/numberdoctordashboard.php?get=getnumberpationt";
    try {
      var response = await http.get(Uri.parse(url));
      if (!response.body.isEmpty) {
        var responsebody = jsonDecode(response.body);
        //posts.add(responsebody);
        for (var doc in responsebody) {
          numberpationt = doc['mes'];
        }
      }
    } catch (e) {
      print(e);
    }
    print('${numberpationt}');
    //changeIconlike();
    notifyListeners();
  }
}
