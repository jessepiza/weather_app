class Weather {
  dynamic id;
  String? name;
  dynamic temp;
  String? description;
  dynamic feelsLike;
  dynamic humidity;
  dynamic windSpeed;
  // ignore: unnecessary_question_mark
  dynamic? pressure;

  Weather({required this.id,
           required this.name, 
           required this.temp, 
           required this.description, 
           required this.feelsLike,
           required this.humidity,
           required this.windSpeed,
           required this.pressure});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'temp': temp,
      'description': description,
      'feels_like': feelsLike,
      'humidity': humidity,
      'wind_speed': windSpeed,
      'pressure' : pressure
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
    return data;
  }
}