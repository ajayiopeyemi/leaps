/*
(0.6.6-dev) [Firestore]: The behavior for java.util.Date objects stored in Firestore is going to change AND YOUR APP MAY BREAK.
W/Firestore(14237): To hide this warning and ensure your app does not break, you need to add the following code to your app before calling any other Cloud Firestore methods:
W/Firestore(14237):
W/Firestore(14237): FirebaseFirestore firestore = FirebaseFirestore.getInstance();
W/Firestore(14237): FirebaseFirestoreSettings settings = new FirebaseFirestoreSettings.Builder()
W/Firestore(14237):     .setTimestampsInSnapshotsEnabled(true)
W/Firestore(14237):     .build();
W/Firestore(14237): firestore.setFirestoreSettings(settings);
W/Firestore(14237):
W/Firestore(14237): With this change, timestamps stored in Cloud Firestore will be read back as com.google.firebase.Timestamp objects instead of as system java.util.Date objects. So you will also need to update code expecting a java.util.Date to instead expect a Timestamp. For example:
W/Firestore(14237):
W/Firestore(14237): // Old:
W/Firestore(14237): java.util.Date date = snapshot.getDate("created_at");
W/Firestore(14237): // New:
W/Firestore(14237): Timestamp timestamp = snapshot.getTimestamp("created_at");
W/Firestore(14237): java.util.Date date = timestamp.toDate();
W/Firestore(14237):
W/Firestore(14237): Please audit all existing usages of java.util.Date when you enable the new behavior. In a future release, the behavior will be changed to the new behavior, so if you do not follow these steps, YOUR APP MAY BREAK.*/



/*
void initFirestoreSettings() async {
  Firestore firestore = Firestore();
  await firestore.settings(timestampsInSnapshotsEnabled: true);
}*/
