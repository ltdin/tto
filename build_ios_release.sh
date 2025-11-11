cd ios && rm -rf Pods/ Podfile.lock && pod install --repo-update
flutter build ipa --release
# bash build_ios_release.sh
