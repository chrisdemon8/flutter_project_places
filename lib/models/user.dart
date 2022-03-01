class UserModel {
  String uid;
  String? email;
  String? displayName;
  String? photoUrl;

  UserModel(
      {required this.uid,
        this.email,
        this.displayName,
        this.photoUrl});

}