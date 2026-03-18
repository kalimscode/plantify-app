import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/di/providers.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../widgets/aichat_bubble.dart';
import '../widgets/aichat_input.dart';
import '../widgets/aichat_typing.dart';

class AiChatScreen extends ConsumerStatefulWidget {
  const AiChatScreen({super.key});

  @override
  ConsumerState<AiChatScreen> createState() => _AiChatScreenState();
}

class _AiChatScreenState extends ConsumerState<AiChatScreen> {
  final _controller = TextEditingController();
  final _scrollController = ScrollController();
  bool _userScrolling = false;

  static const List<String> _suggestions = [
    "Why are my leaves turning yellow? 🍂",
    "How often should I water succulents? 💧",
    "Best indoor plants for beginners 🌱",
    "How do I treat root rot? 🪴",
    "Why is my plant wilting? 😟",
    "How to propagate plants at home? ✂️",
  ];

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      final scrolling =
          _scrollController.position.isScrollingNotifier.value;
      if (scrolling) {
        _userScrolling = true;
      } else {
        Future.delayed(const Duration(milliseconds: 300), () {
          _userScrolling = false;
        });
      }
    });
  }

  void _smartScroll() {
    if (!_scrollController.hasClients) return;
    if (_userScrolling) return;

    final max = _scrollController.position.maxScrollExtent;
    final cur = _scrollController.position.pixels;

    if (max - cur < 200) {
      _scrollController.animateTo(
        max,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
      );
    }
  }

  void _sendMessage(String text) {
    if (text.trim().isEmpty) return;
    final isLoading = ref.read(aiChatViewModelProvider).isLoading;
    if (isLoading) return;
    ref.read(aiChatViewModelProvider.notifier).sendMessage(text.trim());
    _controller.clear();
    FocusScope.of(context).unfocus();
  }

  void _sendVoiceMessage(String transcribedText) {
    if (transcribedText.trim().isEmpty) return;
    final isLoading = ref.read(aiChatViewModelProvider).isLoading;
    if (isLoading) return;
    ref
        .read(aiChatViewModelProvider.notifier)
        .sendMessage(transcribedText.trim(), isVoice: true);
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    final chatState = ref.watch(aiChatViewModelProvider);
    final viewModel = ref.read(aiChatViewModelProvider.notifier);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final profileAsync = ref.watch(userProfileProvider);

    String? userImage;
    profileAsync.whenData((p) => userImage = p?.imagePath);

    WidgetsBinding.instance.addPostFrameCallback((_) => _smartScroll());

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: isDark ? AppColors.dark500 : AppColors.white500,
      appBar: AppBar(
        backgroundColor: isDark ? AppColors.fill01 : AppColors.fill04,
        elevation: 0,
        title: Row(
          children: [
            Container(
              width: 40.w,
              height: 40.h,
              decoration: BoxDecoration(
                color: isDark ? AppColors.fontBlack : AppColors.fontWhite,
                shape: BoxShape.circle,
              ),
              child:  Center(
                child: Text('🌿', style: TextStyle(fontSize: 20.sp)),
              ),
            ),
            SizedBox(width: 10.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Plant Assistant',
                  style: AppTypography.bodyNormalBold.copyWith(
                    color: isDark ? AppColors.fontWhite : AppColors.fontBlack,
                  ),
                ),
                Text(
                  'Always here to help 🌱',
                  style: AppTypography.bodySmallRegular.copyWith(
                    color: AppColors.main500,
                    fontSize: 12.sp,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          if (chatState.messages.isNotEmpty)
            IconButton(
              icon: Icon(
                Icons.delete_sweep_outlined,
                color: isDark ? AppColors.fontWhite : AppColors.fontBlack,
              ),
              tooltip: 'Clear chat',
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: const Text('Clear chat?'),
                    content: const Text(
                        'All messages will be deleted. This cannot be undone.'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          viewModel.clearChat();
                        },
                        child:  Text(
                          'Clear',
                          style: TextStyle(color: AppColors.danger500),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
        ],
      ),
      body: SafeArea(
        top: false,
        child: Column(
          children: [
            Expanded(
              child: chatState.messages.isEmpty
                  ? _buildEmptyState(isDark, chatState.isLoading)
                  : ListView.builder(
                controller: _scrollController,
                physics: const BouncingScrollPhysics(),
                padding:
                EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 8.h),
                itemCount: chatState.isLoading
                    ? chatState.messages.length + 1
                    : chatState.messages.length,
                itemBuilder: (context, index) {
                  if (index == chatState.messages.length &&
                      chatState.isLoading) {
                    return const AiTypingWidget();
                  }

                  final msg = chatState.messages[index];

                  return AiChatBubble(
                    message: msg.message,
                    isUser: msg.isUser,
                    isVoice: msg.isVoice,
                    userImage: userImage,
                    onDelete: () => viewModel.deleteMessage(index),
                  );
                },
              ),
            ),

            // ── Input ──────────────────────────────────────────────
            AiChatInput(
              controller: _controller,
              isLoading: chatState.isLoading,
              onSend: () => _sendMessage(_controller.text),
              onSendVoice: _sendVoiceMessage,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState(bool isDark, bool isLoading) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
      child: Column(
        children: [
          SizedBox(height: 24.h),

          Container(
            width: 80.w,
            height: 80.h,
            decoration: BoxDecoration(
              color: AppColors.main500.withOpacity(0.12),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text('🌿', style: TextStyle(fontSize: 38.sp)),
            ),
          ),

          SizedBox(height: 16.h),

          Text(
            'Ask anything about plants',
            style: AppTypography.bodyNormalBold.copyWith(
              fontSize: 18.sp,
              color: isDark ? AppColors.fontWhite : AppColors.fontBlack,
            ),
          ),

          SizedBox(height: 6.h),

          Text(
            'Tap a suggestion to get started',
            style: AppTypography.bodySmallRegular.copyWith(
              color: AppColors.fontGrey
            )
          ),

          SizedBox(height: 28.h),

          Wrap(
            spacing: 8.w,
            runSpacing: 10.h,
            alignment: WrapAlignment.center,
            children: _suggestions.map((s) {
              return GestureDetector(
                onTap: isLoading ? null : () => _sendMessage(s),
                child: AnimatedOpacity(
                  opacity: isLoading ? 0.4 : 1.0,
                  duration: const Duration(milliseconds: 200),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 14.w,
                      vertical: 10.h,
                    ),
                    decoration: BoxDecoration(
                      color: isDark
                          ? AppColors.main500.withOpacity(0.12)
                          : AppColors.main500.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(20.r),
                      border: Border.all(
                        color: AppColors.main500.withOpacity(0.35),
                        width: 1,
                      ),
                    ),
                    child: Text(
                      s,
                      style: AppTypography.bodySmallRegular.copyWith(
                        color: AppColors.main500,
                        fontSize: 13.sp,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}