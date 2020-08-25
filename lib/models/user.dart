class User {

  final String uid;

  User({ this.uid});

}


class UserData{
  final String name;
  final String sugars;
  final int strength;
  final String uid;
  final String groupid;
  final String spirit;

  UserData({this.uid,this.strength,this.sugars,this.name,this.groupid,this.spirit});
}

class groupdata{
  final String groupid;
  groupdata({this.groupid});
}