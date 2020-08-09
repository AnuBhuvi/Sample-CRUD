import 'package:cloud_firestore/cloud_firestore.dart';

class MemberCollection {
  CollectionReference _memberCollection =
      Firestore.instance.collection('member');
//CRUD OPERATIONS
  addMember(Map memberData) {
    _memberCollection.add(memberData);
  }

  getMembers() async {
    QuerySnapshot qss = await _memberCollection.getDocuments();
    return qss.documents;
  }
}
