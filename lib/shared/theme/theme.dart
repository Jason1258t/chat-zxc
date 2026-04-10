import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'colors.dart';
import 'typography.dart';
import 'tokens.dart';

/// Aether Design System — ThemeData
///
/// Подключение:
/// ```dart
/// MaterialApp(
///   theme: AetherTheme.dark,
///   ...
/// )
/// ```

abstract class AetherTheme {
  static ThemeData get dark {
    final ColorScheme colorScheme = const ColorScheme.dark(
      brightness: Brightness.dark,

      // Surfaces
      surface: AetherColors.void200,
      surfaceContainerHighest: AetherColors.void300,
      surfaceContainerHigh: AetherColors.void300,
      surfaceContainer: AetherColors.void200,
      surfaceContainerLow: AetherColors.void100,
      surfaceContainerLowest: AetherColors.void0,

      // Primary (Violet)
      primary: AetherColors.violet500,
      onPrimary: Colors.white,
      primaryContainer: AetherColors.violet200,
      onPrimaryContainer: AetherColors.violet700,

      // Secondary (Cyan)
      secondary: AetherColors.cyan500,
      onSecondary: AetherColors.void0,
      secondaryContainer: AetherColors.cyan200,
      onSecondaryContainer: AetherColors.cyan600,

      // Tertiary (Rose)
      tertiary: AetherColors.rose500,
      onTertiary: Colors.white,
      tertiaryContainer: AetherColors.rose300,
      onTertiaryContainer: AetherColors.rose600,

      // Error
      error: AetherColors.error,
      onError: Colors.white,
      errorContainer: AetherColors.errorSubtle,
      onErrorContainer: AetherColors.rose600,

      // Text
      onSurface: AetherColors.textPrimary,
      onSurfaceVariant: AetherColors.textSecondary,

      // Outline
      outline: AetherColors.void400,
      outlineVariant: AetherColors.void300,

      // Scrim
      scrim: AetherColors.scrim,

      // Shadow
      shadow: Colors.black,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: AetherColors.void0,
      canvasColor: AetherColors.void100,

      // ── Typography ──────────────────────────
      textTheme: AetherTypography.textTheme.apply(
        bodyColor: AetherColors.textPrimary,
        displayColor: AetherColors.textPrimary,
      ),
      primaryTextTheme: AetherTypography.textTheme.apply(
        bodyColor: AetherColors.textPrimary,
        displayColor: AetherColors.textPrimary,
      ),

      // ── AppBar ──────────────────────────────
      appBarTheme: AppBarTheme(
        backgroundColor: AetherColors.void0,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        iconTheme: const IconThemeData(
          color: AetherColors.textSecondary,
          size: AetherIconSize.lg,
        ),
        actionsIconTheme: const IconThemeData(
          color: AetherColors.textSecondary,
          size: AetherIconSize.lg,
        ),
        titleTextStyle: AetherTypography.displaySmall.copyWith(
          color: AetherColors.textPrimary,
        ),
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.light,
          systemNavigationBarColor: AetherColors.void0,
          systemNavigationBarIconBrightness: Brightness.light,
        ),
      ),

      // ── Bottom Navigation ────────────────────
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AetherColors.void100,
        selectedItemColor: AetherColors.violet500,
        unselectedItemColor: AetherColors.textTertiary,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        elevation: 0,
        type: BottomNavigationBarType.fixed,
      ),

      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: AetherColors.void100,
        indicatorColor: AetherColors.violet200,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const IconThemeData(
              color: AetherColors.violet500,
              size: AetherIconSize.lg,
            );
          }
          return const IconThemeData(
            color: AetherColors.textTertiary,
            size: AetherIconSize.lg,
          );
        }),
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AetherTypography.labelSmall.copyWith(
              color: AetherColors.violet600,
            );
          }
          return AetherTypography.labelSmall.copyWith(
            color: AetherColors.textTertiary,
          );
        }),
      ),

      // ── Cards ───────────────────────────────
      cardTheme: CardThemeData(
        color: AetherColors.void200,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: AetherRadius.card,
          side: const BorderSide(color: AetherColors.void400, width: 0.5),
        ),
        margin: EdgeInsets.zero,
      ),

      // ── Input / TextField ────────────────────
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AetherColors.void200,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AetherSpacing.lg,
          vertical: AetherSpacing.md,
        ),
        border: OutlineInputBorder(
          borderRadius: AetherRadius.input,
          borderSide: const BorderSide(
            color: AetherColors.inputBorderDefault,
            width: 1,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: AetherRadius.input,
          borderSide: const BorderSide(
            color: AetherColors.inputBorderDefault,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: AetherRadius.input,
          borderSide: const BorderSide(
            color: AetherColors.inputBorderFocused,
            width: 1.5,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: AetherRadius.input,
          borderSide: const BorderSide(color: AetherColors.error, width: 1),
        ),
        hintStyle: AetherTypography.bodyMedium.copyWith(
          color: AetherColors.textTertiary,
        ),
        labelStyle: AetherTypography.bodyMedium.copyWith(
          color: AetherColors.textSecondary,
        ),
        floatingLabelStyle: AetherTypography.labelMedium.copyWith(
          color: AetherColors.violet500,
        ),
        prefixIconColor: AetherColors.textTertiary,
        suffixIconColor: AetherColors.textTertiary,
      ),

      // ── Buttons ──────────────────────────────
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AetherColors.violet500,
          foregroundColor: Colors.white,
          disabledBackgroundColor: AetherColors.void400,
          disabledForegroundColor: AetherColors.textTertiary,
          elevation: 0,
          shadowColor: Colors.transparent,
          padding: const EdgeInsets.symmetric(
            horizontal: AetherSpacing.xl2,
            vertical: AetherSpacing.md,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AetherRadius.lg),
          ),
          textStyle: AetherTypography.labelLarge,
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AetherColors.violet500,
          disabledForegroundColor: AetherColors.textTertiary,
          side: const BorderSide(color: AetherColors.violet400, width: 1),
          padding: const EdgeInsets.symmetric(
            horizontal: AetherSpacing.xl2,
            vertical: AetherSpacing.md,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AetherRadius.lg),
          ),
          textStyle: AetherTypography.labelLarge,
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AetherColors.violet600,
          padding: const EdgeInsets.symmetric(
            horizontal: AetherSpacing.md,
            vertical: AetherSpacing.sm,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AetherRadius.sm),
          ),
          textStyle: AetherTypography.labelLarge,
        ),
      ),

      // ── FAB ────────────────────────────────
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: AetherColors.violet500,
        foregroundColor: Colors.white,
        elevation: 0,
        focusElevation: 0,
        hoverElevation: 0,
        highlightElevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AetherRadius.xl),
        ),
      ),

      // ── Icon ────────────────────────────────
      iconTheme: const IconThemeData(
        color: AetherColors.textSecondary,
        size: AetherIconSize.lg,
      ),

      // ── Chip ────────────────────────────────
      chipTheme: ChipThemeData(
        backgroundColor: AetherColors.void300,
        deleteIconColor: AetherColors.textTertiary,
        disabledColor: AetherColors.void200,
        selectedColor: AetherColors.violet200,
        secondarySelectedColor: AetherColors.cyan200,
        padding: const EdgeInsets.symmetric(
          horizontal: AetherSpacing.md,
          vertical: AetherSpacing.xs,
        ),
        labelStyle: AetherTypography.labelMedium.copyWith(
          color: AetherColors.textSecondary,
        ),
        secondaryLabelStyle: AetherTypography.labelMedium.copyWith(
          color: AetherColors.textPrimary,
        ),
        side: const BorderSide(color: AetherColors.void400, width: 0.5),
        shape: const StadiumBorder(),
        elevation: 0,
        pressElevation: 0,
      ),

      // ── Dialog ──────────────────────────────
      dialogTheme: DialogThemeData(
        backgroundColor: AetherColors.void200,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: AetherRadius.card,
          side: const BorderSide(color: AetherColors.void400, width: 0.5),
        ),
        titleTextStyle: AetherTypography.headlineMedium.copyWith(
          color: AetherColors.textPrimary,
        ),
        contentTextStyle: AetherTypography.bodyMedium.copyWith(
          color: AetherColors.textSecondary,
        ),
      ),

      // ── Bottom Sheet ─────────────────────────
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: AetherColors.void100,
        surfaceTintColor: Colors.transparent,
        modalBackgroundColor: AetherColors.void100,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: AetherRadius.sheet),
        showDragHandle: true,
        dragHandleColor: AetherColors.void400,
        dragHandleSize: Size(40, 4),
      ),

      // ── Divider ──────────────────────────────
      dividerTheme: const DividerThemeData(
        color: AetherColors.void400,
        thickness: 0.5,
        space: 0,
      ),

      // ── Switch ───────────────────────────────
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return Colors.white;
          }
          return AetherColors.textTertiary;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AetherColors.violet500;
          }
          return AetherColors.void400;
        }),
        trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
      ),

      // ── Checkbox ─────────────────────────────
      checkboxTheme: CheckboxThemeData(
        checkColor: WidgetStateProperty.all(Colors.white),
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AetherColors.violet500;
          }
          return Colors.transparent;
        }),
        side: const BorderSide(color: AetherColors.void500, width: 1.5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AetherRadius.xs),
        ),
      ),

      // ── Radio ────────────────────────────────
      radioTheme: RadioThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AetherColors.violet500;
          }
          return AetherColors.void500;
        }),
      ),

      // ── Slider ───────────────────────────────
      sliderTheme: SliderThemeData(
        activeTrackColor: AetherColors.violet500,
        inactiveTrackColor: AetherColors.void400,
        thumbColor: AetherColors.violet500,
        overlayColor: AetherColors.glowViolet,
        valueIndicatorColor: AetherColors.violet200,
        valueIndicatorTextStyle: AetherTypography.labelSmall.copyWith(
          color: AetherColors.violet700,
        ),
      ),

      // ── Snackbar ─────────────────────────────
      snackBarTheme: SnackBarThemeData(
        backgroundColor: AetherColors.void300,
        contentTextStyle: AetherTypography.bodySmall.copyWith(
          color: AetherColors.textPrimary,
        ),
        actionTextColor: AetherColors.violet600,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AetherRadius.md),
        ),
        behavior: SnackBarBehavior.floating,
        elevation: 0,
      ),

      // ── Progress ─────────────────────────────
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: AetherColors.violet500,
        linearTrackColor: AetherColors.void400,
        circularTrackColor: AetherColors.void400,
      ),

      // ── List Tile ────────────────────────────
      listTileTheme: ListTileThemeData(
        tileColor: Colors.transparent,
        selectedTileColor: AetherColors.violet100,
        iconColor: AetherColors.textSecondary,
        textColor: AetherColors.textPrimary,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AetherSpacing.lg,
          vertical: AetherSpacing.xs,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AetherRadius.md),
        ),
      ),

      // ── Tab Bar ──────────────────────────────
      tabBarTheme: TabBarThemeData(
        labelColor: AetherColors.violet500,
        unselectedLabelColor: AetherColors.textTertiary,
        indicatorColor: AetherColors.violet500,
        indicatorSize: TabBarIndicatorSize.tab,
        dividerColor: AetherColors.void400,
        labelStyle: AetherTypography.labelMedium,
        unselectedLabelStyle: AetherTypography.labelMedium,
        splashFactory: NoSplash.splashFactory,
        overlayColor: WidgetStateProperty.all(Colors.transparent),
      ),

      // ── Ripple / Splash ──────────────────────
      splashFactory: InkRipple.splashFactory,
      splashColor: AetherColors.violet300.withValues(alpha: 0.2),
      highlightColor: Colors.transparent,
    );
  }
}
