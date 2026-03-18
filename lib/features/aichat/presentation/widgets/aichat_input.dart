import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import '../../../../core/theme/app_colors.dart';

class AiChatInput extends StatefulWidget {
  final TextEditingController controller;
  final VoidCallback onSend;
  final void Function(String transcribedText)? onSendVoice;
  final bool isLoading;

  const AiChatInput({
    super.key,
    required this.controller,
    required this.onSend,
    required this.isLoading,
    this.onSendVoice,
  });

  @override
  State<AiChatInput> createState() => _AiChatInputState();
}

class _AiChatInputState extends State<AiChatInput>
    with SingleTickerProviderStateMixin {
  final stt.SpeechToText _speech = stt.SpeechToText();

  bool _isListening = false;
  bool _keepListening = false;

  String _currentSession = '';
  String _allHeard = '';

  late AnimationController _pulseCtrl;
  late Animation<double> _pulseAnim;

  @override
  void initState() {
    super.initState();
    _pulseCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _pulseAnim = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _pulseCtrl, curve: Curves.easeInOut),
    );
  }

  Future<void> _onMicTapped() async {
    if (widget.isLoading) return;

    final status = await Permission.microphone.request();
    if (!mounted) return;

    if (!status.isGranted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Microphone permission is required.'),
          action: status.isPermanentlyDenied
              ? SnackBarAction(label: 'Open Settings', onPressed: openAppSettings)
              : null,
        ),
      );
      return;
    }

    final available = await _speech.initialize(
      onError: (e) => debugPrint('STT error: ${e.errorMsg}'),
      onStatus: (s) {
        debugPrint('STT status: $s');

        if (_keepListening && mounted &&
            (s == 'notListening' || s == 'done')) {
          Future.delayed(const Duration(milliseconds: 100), () {
            if (_keepListening && mounted) _startOneSession();
          });
        }
      },
    );

    if (!mounted) return;

    if (!available) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Speech recognition not available.')),
      );
      return;
    }

    _currentSession = '';
    _allHeard = '';
    _keepListening = true;
    setState(() => _isListening = true);
    _pulseCtrl.repeat(reverse: true);

    _startOneSession();
  }

  Future<void> _startOneSession() async {
    if (!_keepListening || !mounted) return;
    if (_speech.isListening) return;

    _currentSession = '';

    await _speech.listen(
      onResult: (result) {
        final words = result.recognizedWords.trim();
        if (words.isNotEmpty) {
          _currentSession = words;
          if (words.length > _allHeard.length) {
            _allHeard = words;
          }
          debugPrint('STT result (final=${result.finalResult}): $words');
        }
      },
      listenFor: const Duration(seconds: 30),
      pauseFor: const Duration(seconds: 3),
      partialResults: true,
      cancelOnError: false,
      listenMode: stt.ListenMode.dictation,
    );
  }

  Future<void> _confirmVoice() async {
    final textToSend = _allHeard.trim().isNotEmpty
        ? _allHeard.trim()
        : _currentSession.trim();

    _keepListening = false;
    await _speech.stop();
    _currentSession = '';
    _allHeard = '';
    _stopUI();

    if (textToSend.isNotEmpty) {
      debugPrint('Sending voice: $textToSend');
      widget.onSendVoice?.call(textToSend);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Nothing heard — speak clearly and try again.'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
  }

  Future<void> _cancelVoice() async {
    _keepListening = false;
    await _speech.cancel();
    _currentSession = '';
    _allHeard = '';
    _stopUI();
  }

  void _stopUI() {
    _pulseCtrl.stop();
    _pulseCtrl.reset();
    if (mounted) setState(() => _isListening = false);
  }

  @override
  void dispose() {
    _keepListening = false;
    _speech.cancel();
    _pulseCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: isDark ? AppColors.fill01: AppColors.fill04,
        borderRadius: BorderRadius.circular(30.r),
        border: Border.all(
          color: _isListening
              ? Colors.red.withOpacity(0.5)
              : Colors.transparent,
          width: 1.5,
        ),
      ),
      child: _isListening ? _buildVoiceRow() : _buildTextRow(isDark),
    );
  }

  Widget _buildTextRow(bool isDark) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: widget.controller,
            minLines: 1,
            maxLines: 4,
            decoration: InputDecoration(
              hintText: 'Ask about your plant...',
              border: InputBorder.none,
              hintStyle: TextStyle(color: AppColors.fontGrey ,fontSize: 14.sp),
            ),
          ),
        ),
        SizedBox(width: 6.w),
        GestureDetector(
          onTap: widget.isLoading ? null : _onMicTapped,
          child: Container(
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
              color: widget.isLoading
                  ? AppColors.main500.withOpacity(0.4)
                  : AppColors.main500,
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.mic_rounded, color: Colors.white, size: 18.w),
          ),
        ),
        SizedBox(width: 8.w),
        GestureDetector(
          onTap: widget.isLoading ? null : widget.onSend,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
              color: widget.isLoading
                  ? AppColors.main500.withOpacity(0.4)
                  : AppColors.main500,
              shape: BoxShape.circle,
            ),
            child: SvgPicture.asset(
              'assets/SvgIcons/send-01.svg',
              width: 18.w,
              color: AppColors.fontWhite
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildVoiceRow() {
    return Row(
      children: [
        GestureDetector(
          onTap: _cancelVoice,
          child: Container(
            padding: EdgeInsets.all(8.w),
            decoration:  BoxDecoration(
              color: AppColors.danger500,
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.close_rounded, color: Colors.white, size: 18.w),
          ),
        ),

        SizedBox(width: 10.w),

        Expanded(
          child: Row(
            children: [
              AnimatedBuilder(
                animation: _pulseAnim,
                builder: (_, __) => Transform.scale(
                  scale: _pulseAnim.value,
                  child: Container(
                    width: 8.w,
                    height: 8.w,
                    decoration:  BoxDecoration(
                      color: AppColors.danger500,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 6.w),
              Text(
                'Listening...',
                style: TextStyle(
                  color: Colors.red.shade400,
                  fontSize: 13.sp,
                  fontStyle: FontStyle.italic,
                ),
              ),
              const Spacer(),
              _AnimatedWaveform(),
              SizedBox(width: 4.w),
            ],
          ),
        ),

        SizedBox(width: 10.w),

        GestureDetector(
          onTap: _confirmVoice,
          child: Container(
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
              color: AppColors.main500,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppColors.main500.withOpacity(0.4),
                  blurRadius: 10,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Icon(Icons.check_rounded, color: Colors.white, size: 20.w),
          ),
        ),
      ],
    );
  }
}

class _AnimatedWaveform extends StatefulWidget {
  @override
  State<_AnimatedWaveform> createState() => _AnimatedWaveformState();
}

class _AnimatedWaveformState extends State<_AnimatedWaveform>
    with TickerProviderStateMixin {
  static const List<double> _maxH = [6, 14, 10, 20, 8, 18, 6, 16, 8];
  late List<AnimationController> _ctrls;
  late List<Animation<double>> _anims;

  @override
  void initState() {
    super.initState();
    _ctrls = List.generate(
      _maxH.length,
          (i) => AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 200 + i * 60),
      )..repeat(reverse: true),
    );
    _anims = List.generate(
      _maxH.length,
          (i) => Tween<double>(begin: 2, end: _maxH[i]).animate(
        CurvedAnimation(parent: _ctrls[i], curve: Curves.easeInOut),
      ),
    );
  }

  @override
  void dispose() {
    for (final c in _ctrls) c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: List.generate(_maxH.length, (i) {
        return AnimatedBuilder(
          animation: _anims[i],
          builder: (_, __) => Container(
            margin: EdgeInsets.symmetric(horizontal: 1.5.w),
            width: 3.w,
            height: _anims[i].value,
            decoration: BoxDecoration(
              color: Colors.red.shade400,
              borderRadius: BorderRadius.circular(4.r),
            ),
          ),
        );
      }),
    );
  }
}