import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  Future addUserInfo(Map<String, dynamic> userInfoMap, String id) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .doc(id)
        .set(userInfoMap);
  }

  Future addUserUploadItem(
      Map<String, dynamic> userInfoMap, String id, String itemId) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .doc(id)
        .collection("Items")
        .doc(itemId)
        .set(userInfoMap);
  }

  Future addAdminItem(Map<String, dynamic> userInfoMap, String id) async {
    return await FirebaseFirestore.instance
        .collection("Request")
        .doc(id)
        .set(userInfoMap);
  }

  Future<Stream<QuerySnapshot>> getAdminApproval() async {
    return await FirebaseFirestore.instance
        .collection("Request")
        .where("Status", isEqualTo: "Pending")
        .snapshots();
  }

  Future<Stream<QuerySnapshot>> getUserPendingRequest(String id) async {
    return await FirebaseFirestore.instance
        .collection("users").doc(id)
        .collection("Items").where("Status", isEqualTo: "Pending")
        .snapshots();
  }

  Future updateAdmingRequest(String id) async {
    return await FirebaseFirestore.instance
        .collection("Request")
        .doc(id)
        .update({"Status": "Approved"});
  }

  Future updateUserRequest(String id, String itemId) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .doc(id)
        .collection("Items")
        .doc(itemId)
        .update({"Status": "Approved"});
  }

  Future updateAdminReedemRequest(String id) async {
    return await FirebaseFirestore.instance
        .collection("Reedem")
        .doc(id)
        .update({"Status": "Approved"});
  }
  Future updateUserReedemRequest(String id, String itemId) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .doc(id)
        .collection("Reedem")
        .doc(itemId)
        .update({"Status": "Approved"});
  }

  Future updateUserPoints(String id, String points) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .doc(id)
        .update({"Points": points});
  }

  Future addUserReedemPoints(
      Map<String, dynamic> userInfoMap, String id, String reedemId) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .doc(id)
        .collection("Reedem")
        .doc(reedemId)
        .set(userInfoMap);
  }

  Future addAdminReedemRequest(
      Map<String, dynamic> userInfoMap, String reedemId) async {
    return await FirebaseFirestore.instance
        .collection("Reedem")
        .doc(reedemId)
        .set(userInfoMap);
  }

  Future<Stream<QuerySnapshot>> getUserTransactions(String id) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .doc(id)
        .collection("Reedem")
        .snapshots();
  }

  Future<Stream<QuerySnapshot>> getAdminReedemApproval() async {
    return await FirebaseFirestore.instance
        .collection("Reedem")
        .where("Status", isEqualTo: "Pending")
        .snapshots();
  }
}
