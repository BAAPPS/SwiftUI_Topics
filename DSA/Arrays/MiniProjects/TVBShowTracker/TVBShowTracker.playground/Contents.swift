import Cocoa

// MARK: - Models

struct ShowModel: Codable, Hashable, Identifiable {
    let schedule: String
    let subtitle: String?
    let genres: [String]
    let year: String
    let description: String
    let thumbImageURL: String?
    let cast: [String]
    let title: String
    let bannerImageURL: String?
    var episodes: [EpisodeModel]?

    var id: String {
        "\(title.lowercased().trimmingCharacters(in: .whitespacesAndNewlines))-\(year)"
    }

    enum CodingKeys: String, CodingKey {
        case schedule, subtitle, genres, year, description, cast, title, episodes
        case thumbImageURL = "thumb_image_url"
        case bannerImageURL = "banner_image_url"
    }
}

struct EpisodeModel: Codable, Hashable {
    let title: String?
    let url: String?
    let thumbnailURL: String?

    enum CodingKeys: String, CodingKey {
        case title, url
        case thumbnailURL = "thumbnail_url"
    }
}

// MARK: - Load JSON
guard let url = Bundle.main.url(forResource: "tvb_shows", withExtension: "json"),
      let data = try? Data(contentsOf: url) else {
    fatalError("Missing JSON file in Resources folder")
}

print("✅ JSON loaded successfully, \(data.count) bytes")

// MARK: - Decode JSON
var tvShows: [ShowModel] = []

do {
    tvShows = try JSONDecoder().decode([ShowModel].self, from: data)
    print("✅ Decoded \(tvShows.count) shows")
} catch let DecodingError.dataCorrupted(context) {
    print("❌ Data corrupted:", context.debugDescription)
} catch let DecodingError.keyNotFound(key, context) {
    print("❌ Missing key:", key)
} catch let DecodingError.valueNotFound(value, context) {
    print("❌ Missing value:", value)
} catch let DecodingError.typeMismatch(type, context) {
    print("❌ Type mismatch:", type)
} catch {
    print("⚠️ Unknown error:", error.localizedDescription)
}

// MARK: - Helper: Pretty Print
func prettyPrint<T: Codable>(_ item: T) {
    do {
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.prettyPrinted, .sortedKeys]
        let data = try encoder.encode(item)
        if let jsonString = String(data: data, encoding: .utf8) {
            print(jsonString)
        }
    } catch {
        print("❌ Failed to encode for printing:", error)
    }
}

// MARK: - Slicing / K Elements
let showThreeShowsArray = Array(tvShows.prefix(3))
print("Sliced Shows titles:")
showThreeShowsArray.forEach { print($0.title) }

let allTitles = tvShows.map(\.title)
let allTitlesAscending = allTitles.sorted()
let allTitlesDescending = allTitles.sorted(by: >)
print("All titles ascending:", allTitlesAscending)

let kElements = 10
print("Prefix \(kElements):", allTitlesAscending.prefix(kElements))
print("Suffix \(kElements):", allTitlesAscending.suffix(kElements))

// MARK: - First and Last Show
if let firstShow = tvShows.first { print("First show:", firstShow.title) }
if let lastShow = tvShows.last { print("Last show:", lastShow.title) }

// MARK: - First / Last Crime Show
if let firstCrimeIndex = tvShows.firstIndex(where: { $0.genres.contains("Crime") }) {
    print("First Crime show index:", firstCrimeIndex)
    print("First Crime title:", tvShows[firstCrimeIndex].title)
}

if let lastCrimeIndex = tvShows.lastIndex(where: { $0.genres.contains("Crime") }) {
    print("Last Crime show index:", lastCrimeIndex)
    print("Last Crime title:", tvShows[lastCrimeIndex].title)
}

// MARK: - Collect Titles from First Crime Show
var titleToGenres: [String: Set<String>] = [:]
for show in tvShows {
    titleToGenres[show.title, default: []].formUnion(show.genres)
}

if let firstCrimeIndex = tvShows.firstIndex(where: { $0.genres.contains("Crime") }) {
    var collectedTitles: [String] = []
    let start = firstCrimeIndex
    for i in start..<tvShows.count {
        if i != start && tvShows[i].genres.contains("Crime") { break }
        collectedTitles.append(tvShows[i].title)
    }
    print("Titles from first Crime to next Crime:", collectedTitles)
}

// MARK: - Sliding Windows Between All Crime Shows
let crimeIndices = tvShows.indices.filter { tvShows[$0].genres.contains("Crime") }
var crimeSegments: [[String]] = []

for i in 0..<crimeIndices.count {
    let start = crimeIndices[i]
    let end = (i + 1 < crimeIndices.count) ? crimeIndices[i + 1] : tvShows.count
    crimeSegments.append(Array(tvShows[start..<end].map(\.title)))
}

print("\nSliding windows between Crime shows:")
crimeSegments.enumerated().forEach { i, seg in print("Segment \(i + 1):", seg) }

// MARK: - Efficient Crime Segmentation (Two-Pointer)
let crimeSet = Set(crimeIndices)
var segmentedTitles: [[String]] = []

var i = 0
while i < tvShows.count {
    var window: [String] = []

    if crimeSet.contains(i) {
        window.append("CRIME START")
        var j = i
        repeat {
            window.append(tvShows[j].title)
            j += 1
        } while j < tvShows.count && !crimeSet.contains(j)
        window.append("CRIME END")
        segmentedTitles.append(window)
        i = j
    } else {
        window.append(tvShows[i].title)
        segmentedTitles.append(window)
        i += 1
    }
}

// MARK: - Two-Pointer / Single-Pass Genre Segmentation
@MainActor
func genreSegmentation(for genre: String) -> [[String]] {
    let genreSet = Set(tvShows.indices.filter { tvShows[$0].genres.contains(genre) })
    var segments: [[String]] = []
    var i = 0

    while i < tvShows.count {
        var window: [String] = []

        if genreSet.contains(i) {
            window.append("\(genre.uppercased()) START")
            var j = i
            while j < tvShows.count && !(genreSet.contains(j + 1)) {
                window.append(tvShows[j].title)
                j += 1
            }
            window.append("\(genre.uppercased()) END")
            segments.append(window)
            i = j + 1
        } else {
            window.append(tvShows[i].title)
            segments.append(window)
            i += 1
        }
    }

    return segments
}

// Examples
let crimeBlocks = genreSegmentation(for: "Crime")
let romanceBlocks = genreSegmentation(for: "Romance")

print("\nTwo-Pointer Crime blocks:")
crimeBlocks.enumerated().forEach { i, seg in print("Segment \(i + 1):", seg) }

print("\nTwo-Pointer Romance blocks:")
romanceBlocks.enumerated().forEach { i, seg in print("Segment \(i + 1):", seg) }

// MARK: - Group by Genres
let groupByGenre = tvShows.reduce(into: [String: [String]]()) { dict, show in
    for genre in show.genres {
        dict[genre, default: []].append(show.title)
    }
}

print("\nGroup by genre:")

groupByGenre.forEach { genre, titles in print("\(genre): \(titles)") }

let romanceTitlesCompacted = groupByGenre.compactMap { key, value in
    key == "Romance" ? value : nil
}.flatMap { $0 }

let romanceTitles = groupByGenre["Romance"] ?? []
print("Romance titles:", romanceTitles)




