import 'dart:convert';
import "package:price_app/features/utils/exports.dart";
import 'package:http/http.dart'as http;

class Verification extends StatefulWidget {
  final String email;
  const Verification({super.key, required this.email});
  @override
  _VerificationState createState() => _VerificationState();
}
class _VerificationState extends State<Verification> {
  final List<TextEditingController> _otpControllers = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];
  @override
  void dispose() {
    for (var controller in _otpControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  bool _isLoading = false;
  bool _isResending = false;


  Future<void> verifyOTP(String email, String otp) async {
    setState(() => _isLoading = true);
    try {
      final url = Uri.parse('https://seedapp.vercel.app/api/verifyOTP');
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'otp': otp}),
      );

      if (response.statusCode == 200) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => NewPassword(email: widget.email)),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to verify OTP: ${jsonDecode(response.body)['error']}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred: $e')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator(
        color: Color(0xFF0B6F17),
      ))
          : Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'OTP Verification',
                      style: KHeadingTextStyle.copyWith(fontSize: 24.sp),
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      'Enter the 4-digit verification code we just sent to ${widget.email}',
                      style: KSubHeadingTextStyle.copyWith(fontSize: 16.sp),
                    ),
                    SizedBox(height: 15.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildOTPField(0),
                        _buildOTPField(1),
                        _buildOTPField(2),
                        _buildOTPField(3),
                      ],
                    ),
                    SizedBox(height: 80.h),
                    MyElevatedButton(
                      onPressed: () {
                        final otp = _otpControllers.map((controller) => controller.text).join();
                        verifyOTP(widget.email, otp);
                      },
                      buttonText: 'Verify',
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20.w),
            child: _isResending
                ? const Center(
              child: CircularProgressIndicator(
                color: Color(0xFF0B6F17),
              ),
            )
                : BottomActionText(
              question: "Did not receive code?",
              action: 'Resend',
              onTap: () {
                // Resend OTP here
                setState(() {
                  _isResending = true;
                });
                sendOTP(widget.email).then((success) {
                  setState(() {
                    _isResending = false;
                  });

                  // Show success message
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('OTP sent successfully. Check your email.'),
                      backgroundColor: Color(0xFF0B6F17),
                    ),
                  );
                }).catchError((error) {
                  setState(() {
                    _isResending = false;
                  });

                  // Show error message if OTP sending fails
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Failed to send OTP. Please try again.'),
                      backgroundColor: Colors.red,
                    ),
                  );
                });
              },
            ),
          )

        ],
      ),
    );
  }

  Widget _buildOTPField(int index) {
    return SizedBox(
      width: 50.w,
      child: TextFormField(
        controller: _otpControllers[index],
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        style: TextStyle(fontSize: 18.sp),
        decoration: InputDecoration(
          counterText: '',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 12.h),
        ),
        onChanged: (value) {
          if (value.isNotEmpty) {
            if (index < 3) {
              FocusScope.of(context).nextFocus();
            } else {
              FocusScope.of(context).unfocus();
            }
          } else {
            if (index > 0) {
              FocusScope.of(context).previousFocus();
            }
          }
        },
      ),
    );
  }
}


