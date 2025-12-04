import 'package:blood_bank/core/app/app_colors.dart';
import 'package:blood_bank/core/app/app_router.dart';
import 'package:blood_bank/core/app/app_styles.dart';
import 'package:blood_bank/core/constants/show_snack_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfileSection extends StatelessWidget {
  const EditProfileSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.secondbackground.withOpacity(0.3),
          width: 0.5,
        ),
        color: const Color(0xfffafafa),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // 🔐 Change Password
          _buildMenuItem(
            context,
            icon: Icons.lock_outline,
            title: "Change Password",
            onTap: () => _showChangePasswordDialog(context),
          ),

          // 📍 Update Location (اختياري)
          _buildMenuItem(
            context,
            icon: Icons.location_on_outlined,
            title: "Update Location",
            onTap: () => _showUpdateLocationDialog(context),
          ),

          // ❤️ Blood Type Info (اختياري)
          _buildMenuItem(
            context,
            icon: Icons.bloodtype_outlined,
            title: "My Blood Type",
            onTap: () => _showBloodTypeInfo(context),
          ),

          // 🔴 Log Out
          _buildMenuItem(
            context,
            icon: Icons.logout,
            title: "Log Out",
            color: Colors.red,
            onTap: () => _showLogoutConfirmation(context),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color? color,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: (color ?? AppColors.primary).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: color ?? AppColors.primary, size: 20),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  title,
                  style: AppStyles.styleBold15.copyWith(
                    color: color ?? AppColors.secondary,
                  ),
                ),
              ),
              Icon(
                Icons.arrow_forward_ios_rounded,
                size: 16,
                color: Colors.grey[400],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 🔐 Change Password Dialog
  Future<void> _showChangePasswordDialog(BuildContext context) async {
    final currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser == null) {
      ShowSnackBar.ShowSnackBarErrMessage(context, "User not logged in");
      return;
    }

    final oldPasswordController = TextEditingController();
    final newPasswordController = TextEditingController();
    final confirmPasswordController = TextEditingController();

    bool isLoading = false;
    bool obscureOldPassword = true;
    bool obscureNewPassword = true;
    bool obscureConfirmPassword = true;

    await showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Row(
                children: [
                  Icon(Icons.lock_reset, color: AppColors.primary),
                  const SizedBox(width: 12),
                  const Text("Change Password"),
                ],
              ),
              content:
                  isLoading
                      ? const Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CircularProgressIndicator(),
                          SizedBox(height: 16),
                          Text("Updating password..."),
                        ],
                      )
                      : SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Old Password
                            TextField(
                              controller: oldPasswordController,
                              obscureText: obscureOldPassword,
                              decoration: InputDecoration(
                                labelText: "Current Password",
                                prefixIcon: const Icon(Icons.lock_outline),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    obscureOldPassword
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      obscureOldPassword = !obscureOldPassword;
                                    });
                                  },
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),

                            // New Password
                            TextField(
                              controller: newPasswordController,
                              obscureText: obscureNewPassword,
                              decoration: InputDecoration(
                                labelText: "New Password",
                                prefixIcon: const Icon(Icons.lock_outline),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    obscureNewPassword
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      obscureNewPassword = !obscureNewPassword;
                                    });
                                  },
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),

                            // Confirm New Password
                            TextField(
                              controller: confirmPasswordController,
                              obscureText: obscureConfirmPassword,
                              decoration: InputDecoration(
                                labelText: "Confirm New Password",
                                prefixIcon: const Icon(Icons.lock_outline),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    obscureConfirmPassword
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      obscureConfirmPassword =
                                          !obscureConfirmPassword;
                                    });
                                  },
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "Password must be at least 6 characters",
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
              actions: [
                TextButton(
                  onPressed:
                      isLoading ? null : () => Navigator.of(context).pop(),
                  child: const Text("Cancel"),
                ),
                ElevatedButton(
                  onPressed:
                      isLoading
                          ? null
                          : () async {
                            final oldPassword =
                                oldPasswordController.text.trim();
                            final newPassword =
                                newPasswordController.text.trim();
                            final confirmPassword =
                                confirmPasswordController.text.trim();

                            // التحقق من البيانات
                            if (oldPassword.isEmpty ||
                                newPassword.isEmpty ||
                                confirmPassword.isEmpty) {
                              ShowSnackBar.ShowSnackBarErrMessage(
                                context,
                                "Please fill all fields",
                              );
                              return;
                            }

                            if (newPassword.length < 6) {
                              ShowSnackBar.ShowSnackBarErrMessage(
                                context,
                                "Password must be at least 6 characters",
                              );
                              return;
                            }

                            if (newPassword != confirmPassword) {
                              ShowSnackBar.ShowSnackBarErrMessage(
                                context,
                                "Passwords don't match",
                              );
                              return;
                            }

                            setState(() => isLoading = true);

                            try {
                              // إعادة المصادقة لتأكيد الهوية
                              final credential = EmailAuthProvider.credential(
                                email: currentUser.email!,
                                password: oldPassword,
                              );

                              await currentUser.reauthenticateWithCredential(
                                credential,
                              );

                              // تغيير كلمة المرور
                              await currentUser.updatePassword(newPassword);

                              Navigator.of(context).pop();
                              ShowSnackBar.ShowSnackBarMessage(
                                context,
                                "Password changed successfully!",
                              );
                            } on FirebaseAuthException catch (e) {
                              String message;
                              switch (e.code) {
                                case 'wrong-password':
                                  message = "Current password is incorrect";
                                  break;
                                case 'weak-password':
                                  message = "New password is too weak";
                                  break;
                                case 'requires-recent-login':
                                  message =
                                      "Please login again to change password";
                                  break;
                                default:
                                  message = "Error: ${e.message}";
                              }
                              ShowSnackBar.ShowSnackBarErrMessage(
                                context,
                                message,
                              );
                            } catch (e) {
                              ShowSnackBar.ShowSnackBarErrMessage(
                                context,
                                "An error occurred",
                              );
                            } finally {
                              if (context.mounted) {
                                setState(() => isLoading = false);
                              }
                            }
                          },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                  ),
                  child:
                      isLoading
                          ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                          : const Text("Update"),
                ),
              ],
            );
          },
        );
      },
    );
  }

  // 🔴 Logout Confirmation
  Future<void> _showLogoutConfirmation(BuildContext context) async {
    await showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Row(
              children: [
                Icon(Icons.logout, color: Colors.red),
                const SizedBox(width: 12),
                const Text("Log Out"),
              ],
            ),
            content: const Text("Are you sure you want to log out?"),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text("Cancel"),
              ),
              ElevatedButton(
                onPressed: () async {
                  Navigator.of(context).pop(); // إغلاق الدايالوج
                  await _performLogout(context);
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                child: const Text("Log Out"),
              ),
            ],
          ),
    );
  }

  // 🚪 Perform Logout
  Future<void> _performLogout(BuildContext context) async {
    try {
      // إظهار مؤشر تحميل
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(child: CircularProgressIndicator()),
      );

      // 1. مسح بيانات SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();

      // 2. تسجيل الخروج من Firebase
      await FirebaseAuth.instance.signOut();

      // 3. الانتقال إلى صفحة Login
      if (context.mounted) {
        Navigator.of(context).pop(); // إغلاق مؤشر التحميل

        // الانتقال إلى صفحة Login وإزالة كل الـ stack
        GoRouter.of(context).go(AppRouter.kLoginView);

        ShowSnackBar.ShowSnackBarMessage(context, "Logged out successfully");
      }
    } catch (e) {
      if (context.mounted) {
        Navigator.of(context).pop(); // إغلاق مؤشر التحميل
        ShowSnackBar.ShowSnackBarErrMessage(
          context,
          "Error logging out: ${e.toString()}",
        );
      }
    }
  }

  // 📍 Update Location (اختياري)
  Future<void> _showUpdateLocationDialog(BuildContext context) async {
    final TextEditingController locationController = TextEditingController();

    await showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text("Update Location"),
            content: TextField(
              controller: locationController,
              decoration: const InputDecoration(
                labelText: "Enter your city/area",
                prefixIcon: Icon(Icons.location_on),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text("Cancel"),
              ),
              ElevatedButton(
                onPressed: () {
                  // هنا يمكنك حفظ الموقع في Firestore
                  Navigator.of(context).pop();
                  ShowSnackBar.ShowSnackBarMessage(context, "Location updated");
                },
                child: const Text("Save"),
              ),
            ],
          ),
    );
  }

  // ❤️ Blood Type Info (اختياري)
  Future<void> _showBloodTypeInfo(BuildContext context) async {
    await showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text("My Blood Type"),
            content: const Text(
              "Your blood type is important information for blood donations. "
              "Make sure it's correctly set in your profile.",
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text("OK"),
              ),
            ],
          ),
    );
  }
}
