//
//  ContactService.swift
//  challenge-3-personal
//
//  Created by Dimas Prihady Setyawan on 18/06/26.
//

import Contacts
@MainActor
@Observable
final class ContactService {
    var contacts: [User] = []
    var authorizationStatus: CNAuthorizationStatus = .notDetermined
    
    func requestAccess() async {
        authorizationStatus = CNContactStore.authorizationStatus(for: .contacts)
        
        switch authorizationStatus {
        case .authorized:
            await fetchContacts()
        case .notDetermined:
            do {
                let granted = try await CNContactStore().requestAccess(for: .contacts)
                authorizationStatus = granted ? .authorized : .denied
                if granted { await fetchContacts() }
            } catch {
                authorizationStatus = .denied
            }
        default:
            break
        }
    }
    
    func fetchContacts() async {
        do {
            contacts = try await Self.loadContacts()
        } catch {
            print("Failed to fetch contacts: \(error)")
        }
    }

    nonisolated private static func loadContacts() async throws -> [User] {
        try await Task.detached(priority: .userInitiated) {
            let store = CNContactStore()
            let keys: [CNKeyDescriptor] = [
                CNContactGivenNameKey as CNKeyDescriptor,
                CNContactFamilyNameKey as CNKeyDescriptor,
                CNContactThumbnailImageDataKey as CNKeyDescriptor,
                CNContactPhoneNumbersKey as CNKeyDescriptor
            ]
            let request = CNContactFetchRequest(keysToFetch: keys)

            var fetched: [User] = []
            try store.enumerateContacts(with: request) { contact, _ in
                fetched.append(User(from: contact))
            }

            return fetched
        }.value
    }
}
