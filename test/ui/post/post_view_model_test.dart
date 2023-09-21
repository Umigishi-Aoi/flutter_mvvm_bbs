import 'package:clock/clock.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:fluter_mvvm_bbs/config/firestore_settings.dart';
import 'package:fluter_mvvm_bbs/model/auth/auth_model.dart';
import 'package:fluter_mvvm_bbs/model/firestore/firestore_model.dart';
import 'package:fluter_mvvm_bbs/ui/post/view_model/post_view_model.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final firestoreInstance = FakeFirebaseFirestore();

  final firestoreModel = FirestoreModel(firestoreInstance);

  final authInstance = MockFirebaseAuth();

  final authModel = AuthModel(authInstance);

  const post = 'post test';

  final controller = TextEditingController()..text = post;

  final postViewModel =
      PostViewModel.withModel(authModel, firestoreModel, controller);

  group('PostViewModel Test', () {
    test('post test', () async {
      await authInstance.signInWithProvider(GithubAuthProvider());
      final userName = authInstance.currentUser?.displayName;
      final photoUrl = authInstance.currentUser?.photoURL;
      await withClock(Clock.fixed(DateTime(2023)), () async {
        await postViewModel.setData();

        final snapshot =
            await firestoreInstance.collection(Collection.bbs.name).get();
        final data = snapshot.docs[0].data();
        final now = Timestamp.fromDate(DateTime.now());
        final createdAt = Timestamp(now.seconds, 0);
        expect(data[BbsField.userName.name], userName);
        expect(data[BbsField.photoUrl.name], photoUrl);
        expect(data[BbsField.post.name], post);
        expect(
          data[BbsField.createdAt.name],
          createdAt,
        );
      });
    });
  });
}
