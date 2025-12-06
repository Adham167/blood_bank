import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoginLogic {
  static Future<void> handleLoginSuccess(BuildContext context, String emailInput) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        print(' No user found in Firebase Auth');
        return;
      }

      print(' Logged in User UID: ${user.uid}');
      print(' Email from input: $emailInput');
      print(' Email from Firebase: ${user.email}');

      final userData = await _fetchUserDataFromFirestore(user.uid);
      
      final name = _extractName(userData);
      final email = _extractEmail(userData, user, emailInput);
      final phone = _extractPhone(userData);
      
      print(' Extracted Data - Name: $name, Email: $email, Phone: $phone');

      await _saveUserDataToSharedPreferences(name, email, phone);
      
      await _printVerification();

    } catch (e) {
      print(' Error during login process: $e');
      rethrow;
    }
  }

  static Future<Map<String, dynamic>> _fetchUserDataFromFirestore(String uid) async {
    try {
      print(' Searching in Firestore for UID: $uid');
      
      final docRef = FirebaseFirestore.instance.collection('Users').doc(uid);
      final docSnapshot = await docRef.get();
      
      if (docSnapshot.exists) {
        final data = docSnapshot.data()!;
        print(' Found in direct document');
        print(' Document data: $data');
        return data;
      }
      
      print(' Document not found with ID = UID');
      
      final querySnapshot = await FirebaseFirestore.instance
          .collection('Users')
          .where('uid', isEqualTo: uid)
          .limit(1)
          .get();
      
      if (querySnapshot.docs.isNotEmpty) {
        final data = querySnapshot.docs.first.data();
        print(' Found in collection query');
        print(' Query data: $data');
        return data;
      }
      
      print(' No user found with UID: $uid');
      return {};
      
    } catch (e) {
      print(' Error fetching from Firestore: $e');
      return {};
    }
  }

  static String _extractName(Map<String, dynamic> userData) {
    final name = userData['name'] ?? 
                 userData['fullName'] ?? 
                 userData['username'] ?? 
                 userData['displayName'] ?? 
                 'User';
    print(' Extracted Name: $name');
    return name;
  }

  static String _extractEmail(Map<String, dynamic> userData, User user, String emailInput) {
    final email = userData['email'] ?? 
                  user.email ?? 
                  emailInput;
    print('📧 Extracted Email: $email');
    return email;
  }

  static String _extractPhone(Map<String, dynamic> userData) {
    final phone = userData['phone'] ?? 
                  userData['phoneNumber'] ?? 
                  userData['mobile'] ?? 
                  userData['telephone'] ?? 
                  userData['contact'] ?? 
                  '';
    print('📱 Extracted Phone: $phone');
    return phone;
  }

  static Future<void> _saveUserDataToSharedPreferences(String name, String email, String phone) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      
      print(' Attempting to save to SharedPreferences:');
      print('   Name: $name');
      print('   Email: $email');
      print('   Phone: $phone');
      
      await prefs.setString('user_name', name);
      await prefs.setString('user_email', email);
      await prefs.setString('user_phone', phone);
      
      print(' Successfully saved to SharedPreferences');
    } catch (e) {
      print(' Error saving to SharedPreferences: $e');
      throw Exception('Failed to save user data');
    }
  }

  static Future<void> _printVerification() async {
    final prefs = await SharedPreferences.getInstance();
    
    print('=' * 50);
    print(' VERIFICATION - What is actually saved:');
    print('=' * 50);
    
    final savedName = prefs.getString('user_name');
    final savedEmail = prefs.getString('user_email');
    final savedPhone = prefs.getString('user_phone');
    
    print(' Name in SharedPreferences: ${savedName ?? "NULL"}');
    print(' Email in SharedPreferences: ${savedEmail ?? "NULL"}');
    print(' Phone in SharedPreferences: ${savedPhone ?? "NULL"}');
    print('=' * 50);
    
    if (savedName == null || savedEmail == null) {
      print(' WARNING: Some data is NULL!');
    } else {
      print(' SUCCESS: All data saved correctly!');
    }
  }

  static Future<void> testSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    print(' TEST - Current SharedPreferences state:');
    print('   user_name: ${prefs.getString('user_name') ?? "NULL"}');
    print('   user_email: ${prefs.getString('user_email') ?? "NULL"}');
    print('   user_phone: ${prefs.getString('user_phone') ?? "NULL"}');
    
    await prefs.setString('user_name', 'Test User');
    await prefs.setString('user_email', 'test@email.com');
    await prefs.setString('user_phone', '0123456789');
    
    print(' TEST - After setting test data:');
    print('   user_name: ${prefs.getString('user_name')}');
    print('   user_email: ${prefs.getString('user_email')}');
    print('   user_phone: ${prefs.getString('user_phone')}');
  }
}