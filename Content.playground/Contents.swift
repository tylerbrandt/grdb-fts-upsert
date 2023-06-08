// Playground generated with 🏟 Arena (https://github.com/finestructure/arena)
// ℹ️ If running the playground fails with an error "No such module"
//    go to Product -> Build to re-trigger building the SPM package.
// ℹ️ Please restart Xcode if autocomplete is not working.

import GRDB

//: Open a connection to the database

// Open an in-memory database that logs all SQL statements
var configuration = Configuration()
configuration.prepareDatabase { db in
    db.trace { print("SQL> \($0)") }
}
let dbQueue = try DatabaseQueue(configuration: configuration)

try dbQueue.inDatabase({ db in
  try db.create(table: "content", body: { t in
    t.column("id", .text).primaryKey()
    t.column("text", .text)
  })
  
  try db.create(virtualTable: "fts", using: FTS5()) { t in
    t.tokenizer = .porter()
    t.synchronize(withTable: "content")
    t.column("id").notIndexed()
    t.column("text")
  }
})

struct Content: Codable, Hashable, PersistableRecord {
  var id: String
  var text: String
}

do {
  try dbQueue.write { db in
    try Content(id: "foobar", text: "baz").upsert(db)
  }
} catch {
  assertionFailure("Failed to upsert: \(error)")
}
