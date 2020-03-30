class Urls {

  static final Urls _login = Urls._internal();

  factory Urls() {
    return _login;
  }

  Urls._internal();


  // maokang's ip: 192.168.31.72
  // your local ip: 127.0.0.1
  static const apiUrlBase = "http://192.168.31.72:8080/api";
}

