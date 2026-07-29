import Foundation

@main
struct SubjectTagEngineTestRunner {
    static func main() {
        var failures: [String] = []

        func expect(_ condition: @autoclosure () -> Bool, _ message: String) {
            if !condition() {
                failures.append(message)
            }
        }

        func session(
            intention: String,
            actualMinutes: Int = 25,
            completed: Bool = true
        ) -> FocusSession {
            var session = FocusSession(
                plannedSeconds: max(actualMinutes, 1) * 60,
                intention: intention
            )

            session.completed = completed
            session.actualSeconds = actualMinutes * 60

            return session
        }

        let parsedTags = SubjectTagEngine.bracketTags(from: "[Math] [Psychology] Essay planning")
        expect(
            parsedTags == ["Math", "Psychology"],
            "Bracket tags should be extracted, cleaned, deduplicated, and sorted."
        )

        let noTagSubjects = SubjectTagEngine.subjects(from: "General revision without a bracket tag")
        expect(
            noTagSubjects == ["Other"],
            "A non-empty intention without bracket tags should be grouped as Other."
        )

        let emptySubjects = SubjectTagEngine.subjects(from: "   ")
        expect(
            emptySubjects.isEmpty,
            "An empty intention should not produce a subject."
        )

        let sessions = [
            session(intention: "[Math] Algebra", actualMinutes: 25),
            session(intention: "[Math] Geometry", actualMinutes: 15),
            session(intention: "[Psychology] Memory study", actualMinutes: 30),
            session(intention: "No tag revision", actualMinutes: 10),
            session(intention: "[Math] [Physics] Mixed work", actualMinutes: 20)
        ]

        let items = SubjectTagEngine.breakdownItems(from: sessions)
        let itemBySubject = Dictionary(uniqueKeysWithValues: items.map { ($0.subject, $0) })

        expect(
            itemBySubject["Math"]?.sessionCount == 3,
            "Math should count three sessions, including the mixed-subject session."
        )

        expect(
            itemBySubject["Math"]?.focusedMinutes == 60,
            "Math should total 60 focused minutes."
        )

        expect(
            itemBySubject["Psychology"]?.sessionCount == 1
            && itemBySubject["Psychology"]?.focusedMinutes == 30,
            "Psychology should count one 30-minute session."
        )

        expect(
            itemBySubject["Physics"]?.sessionCount == 1
            && itemBySubject["Physics"]?.focusedMinutes == 20,
            "Physics should count the mixed-subject session."
        )

        expect(
            itemBySubject["Other"]?.sessionCount == 1
            && itemBySubject["Other"]?.focusedMinutes == 10,
            "A non-tagged intention should be grouped under Other."
        )

        expect(
            items.first?.subject == "Math",
            "The top subject should be the one with the most focused minutes."
        )

        let summary = SubjectTagEngine.summary(from: sessions)

        expect(
            summary.totalSubjects == 4,
            "Summary should report four subjects: Math, Psychology, Physics, and Other."
        )

        expect(
            summary.topSubject == "Math" && summary.topSubjectMinutes == 60,
            "Summary should identify Math as the top subject with 60 minutes."
        )

        let repeatedA = SubjectTagEngine.summary(from: sessions)
        let repeatedB = SubjectTagEngine.summary(from: sessions)

        expect(
            repeatedA == repeatedB,
            "SubjectTagEngine summary should be deterministic for identical input."
        )

        if failures.isEmpty {
            print("✅ SubjectTagEngine tests passed.")
            print("Checked:")
            print("- bracket tags are extracted and sorted")
            print("- empty intention produces no subject")
            print("- non-tagged intention becomes Other")
            print("- mixed-subject sessions count for each tag")
            print("- focused minutes are totalled by subject")
            print("- top subject is selected by focused minutes")
            print("- summary output is deterministic")
        } else {
            print("❌ SubjectTagEngine tests failed:")
            for failure in failures {
                print("- \(failure)")
            }
            exit(1)
        }
    }
}
