class ListElementResponse {
  int dt;
  DateTime dtTxt;

  double pop;

  ListElementResponse({
    required this.dt,
    required this.dtTxt,
    required this.pop,
  });

  factory ListElementResponse.fromJson(Map<String, dynamic> json) => ListElementResponse(
        dt: json["dt"],
        dtTxt: DateTime.parse(json["dt_txt"]),
        pop: json["pop"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "dt": dt,
        "dt_txt": dtTxt.toIso8601String(),
        "pop": pop,
      };
}
