import 'package:cloud_firestore/cloud_firestore.dart';

class MemberCollection {
  CollectionReference _memberCollection =
      Firestore.instance.collection('member');

  addMember(Map memberData) {
    _memberCollection.add(memberData);
  }

  // Stream<QuerySnapshot> getMembers() {
  //   return _memberCollection.snapshots();
  // }

  getMembers() async {
    QuerySnapshot qss = await _memberCollection.getDocuments();
    return qss.documents;
  }
}
