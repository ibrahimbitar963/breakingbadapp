class Character {
late int char_Id;
late String nickName;
late String image;
late List<dynamic> jobs;
late String StatusIfDeadOrAlive;
late List<dynamic> appearance;
late String actorName ;
late List<dynamic> better_call_saul_appearance;

Character.fromJson(Map <String, dynamic> json) {

 char_Id=json['char_id'];
 nickName= json['name'];
 image= json['img'];
 jobs=json['occupation'];
 StatusIfDeadOrAlive=json['status'];
 appearance=json['appearance'];
 actorName=json['portrayed'];
 better_call_saul_appearance=json['better_call_saul_appearance'];


}


 }
