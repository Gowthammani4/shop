// ignore_for_file: avoid_print, prefer_if_null_operators

class SoccerMatch {
  Fixture fixture;
  Team home;
  Team away;
  Goal goal;
  SoccerMatch(this.fixture, this.home, this.away, this.goal);

  factory SoccerMatch.fromJson(Map<String, dynamic> json) {
    print('pass');

    return SoccerMatch(
        Fixture.fromJson(json['fixture']),
        Team.fromJson(json['teams']['home']),
        Team.fromJson(json['teams']['away']),
        Goal.fromJson(json['goals']));
  }
}

class Fixture {
  String date;
  Status status;
  Fixture(this.date, this.status);

  factory Fixture.fromJson(Map<String, dynamic> json) {
    print('passing fistures');

    return Fixture(json['date'], Status.fromJson(json['status']));
  }
}

class Status {
  String long;
  Status(this.long);

  factory Status.fromJson(Map<String, dynamic> json) {
    print('passing status');

    return Status(json['long']);
  }
}

class Team {
  String name;
  String logoUrl;
  Team(
    this.name,
    this.logoUrl,
  );

  factory Team.fromJson(Map<String, dynamic> json) {
    print('passing team');

    return Team(
      json['name'],
      json['logo'],
    );
  }
}

class Goal {
  int home;
  int away;
  Goal(this.home, this.away);

  factory Goal.fromJson(Map<String, dynamic> json) {
    print('passing goal');
    return Goal(json['home'] == null ? 0 : json['home'],
        json['away'] == null ? 0 : json['away']);
  }
}
