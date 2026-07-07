import SwiftUI

struct SettingsView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var purchases: PurchaseManager
    @AppStorage("jawnote_notifEnabled") private var notifEnabled: Bool = true
    @AppStorage("jawnote_reminderEnabled") private var reminderEnabled: Bool = false

    var body: some View {
        NavigationStack {
            Form {
                Section("Preferences") {
                    Toggle("Notifications", isOn: $notifEnabled)
                    Toggle("Daily Reminder", isOn: $reminderEnabled)
                }
                Section("Subscription") {
                    if purchases.isPro {
                        Label("Pro Unlocked", systemImage: "checkmark.seal.fill")
                            .foregroundStyle(Theme.accent)
                    } else {
                        Text("Free plan")
                    }
                    Button("Restore Purchases") {
                        Task { await purchases.restore() }
                    }
                    .accessibilityIdentifier("restorePurchasesButton")
                }
                Section("About") {
                    Link("Privacy Policy", destination: URL(string: "https://shimondeitel.github.io/jawnote-app/privacy.html")!)
                    Link("Terms of Use", destination: URL(string: "https://shimondeitel.github.io/jawnote-app/terms.html")!)
                    Text("Contact: s0533495227@gmail.com")
                        .font(Theme.captionFont)
                        .foregroundStyle(Theme.textSecondary)
                }
            }
            .navigationTitle("Settings")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") { dismiss() }
                        .accessibilityIdentifier("settingsDoneButton")
                }
            }
        }
        .tint(Theme.accent)
    }
}
