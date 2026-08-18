# Bug Fix: Pokemon Evolution Name Not Updating

The current implementation of the Save Kids home screen uses the initial team name (e.g., "Charmander") to display the avatar's name, even after it has evolved into a new stage (e.g., "Charmeleon"). This plan will update the UI to use the current stage name from the avatar model.

## Proposed Changes

### [Component Name] Feature: Save Kids

#### [MODIFY] [SaveKidsHomeScreen.kt](file:///G:/DEV/Projetos/SaveKids/ZodiakAndroid/app/src/main/kotlin/com/zodiak/android/feature/savekids/view/SaveKidsHomeScreen.kt)

Update the `avatarDisplayName` calculation to prioritize `state.avatar?.currentStageName` over the static `state.profile?.avatarTeamName`.

#### [MODIFY] [SaveKidsHomeViewModel.kt](file:///G:/DEV/Projetos/SaveKids/ZodiakAndroid/app/src/main/kotlin/com/zodiak/android/feature/savekids/viewmodel/SaveKidsHomeViewModel.kt)

Improve the `avatar` refresh logic to ensure it stays in sync when XP changes across evolution thresholds.

## Verification Plan

### Automated Tests
- I'll check if there are existing unit tests for `SaveKidsHomeViewModel` and add/update them to verify that `refreshAvatar` is called when XP changes.

### Manual Verification
- Deploy the app.
- Verify that for a profile with > 100 XP, the home screen displays "Charmeleon" (or the appropriate evolution) instead of the base form name.
- Verify that the image and the name are consistent.
