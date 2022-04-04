class Driver {
  final int num;
  final String train;
  final String lati;
  final String longi;

  Driver(
      {required this.num,
      required this.train,
      required this.lati,
      required this.longi});

  factory Driver.fromJson(Map<String, dynamic> json) {
    return Driver(
      num: json['num'],
      train: json['train'],
      lati: json['latitude'],
      longi: json['longitude'],
    );
  }

  Map<String, dynamic> toJson() => {
        'train': train,
        'latitude': lati,
        'longitude': longi,
      };
}
