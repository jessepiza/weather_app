class Weather {
  dynamic id;
  String? name;
  double? temp;
  String? description;
  double? feelsLike;
  int? humidity;
  dynamic windSpeed;
  int? pressure;
  String? main;

  Weather({required this.id,
           required this.name, 
           required this.temp, 
           required this.description, 
           required this.feelsLike,
           required this.humidity,
           required this.windSpeed,
           required this.pressure,
           required this.main});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'temp': temp,
      'description': description,
      'feels_like': feelsLike,
      'humidity': humidity,
      'wind_speed': windSpeed,
      'pressure' : pressure,
      'main' : main,
    };
  }

  Weather.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    temp = json['temp'];
    description = json['description'];
    feelsLike = json['feels_like'];
    humidity = json['humidity'];
    windSpeed = json['wind_speed'];
    pressure = json['pressure'];
    main = json['main'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['temp'] = temp;
    data['description'] = description;
    data['feels_like'] = feelsLike;
    data['humidity'] = humidity;
    data['wind_speed'] = windSpeed;
    data['pressure'] = pressure;
    data['main'] = main;
    return data;
  }
}