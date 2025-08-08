#!/usr/bin/env bash
set -euo pipefail

# Usage: fetch_album_lyrics_simple.sh "/path/to/Artist"
# Example: fetch_album_lyrics_simple.sh "$HOME/Music/mpd/Anderson .Paak"

LRCLIB_API="https://lrclib.net/api/get"

if [ $# -ne 1 ]; then
    echo "Usage: $0 \"/path/to/Artist\""
    exit 1
fi

ARTIST_DIR="$1"
if [ ! -d "$ARTIST_DIR" ]; then
    echo "Error: '$ARTIST_DIR' is not a directory."
    exit 1
fi

ARTIST="$(basename "$(realpath "$ARTIST_DIR")")"

clean_album_name() {
    local artist="$1"
    local album_raw="$2"
    echo "$album_raw" | sed -E "s/^${artist} - //I"
}

clean_title() {
    local artist="$1"
    local title_raw="$2"
    echo "$title_raw" | sed -E "s/^[0-9]{1,2} - ${artist} //I"
}

normalize_name_for_api() {
    local raw="$1"
    echo "$raw" | sed -E \
        -e "s/biggercolon3/>:3/g" \
        -e "s/colon3/:3/g" \
        -e "s/_/'/g"
}

get_lyrics_for() {
    local artist="$1"
    local album="$2"
    local title_try="$3"
    local field="$4"  # syncedLyrics or plainLyrics

    curl -sG \
        --data-urlencode "artist_name=${artist}" \
        --data-urlencode "track_name=${title_try}" \
        --data-urlencode "album_name=${album}" \
        "$LRCLIB_API" \
        | jq -r ".syncedLyrics"
}

fetch_for_plain() {
    local artist="$1"
    local album="$2"
    local title_try="$3"
    local out_lrc="$4"

    local album_cleaned title_cleaned lyrics
    album_cleaned="$(normalize_name_for_api "$album")"
    title_cleaned="$(normalize_name_for_api "$title_try")"

    echo "→ Querying: artist='${artist}', album='${album_cleaned}', title='${title_cleaned}'"

    # 1. Try to get synced lyrics
    lyrics="$(get_lyrics_for "$artist" "$album_cleaned" "$title_cleaned")"

    # 2. If empty or "null", try stripping "(...)" and retry
    if [ -z "$lyrics" ] || [ "$lyrics" == "null" ]; then
        local stripped
        stripped="$(echo "$title_cleaned" | sed -E 's/ *\([^)]*\)//g')"
        if [ "$stripped" != "$title_cleaned" ]; then
            title_cleaned="$stripped"
            lyrics="$(get_lyrics_for "$artist" "$album_cleaned" "$title_cleaned")"
        fi
    fi

    # 3. If still no synced lyrics, try plain lyrics
    # if [ -z "$lyrics" ] || [ "$lyrics" == "null" ]; then
    #     echo "→ No synced lyrics, trying plain lyrics..."
    #     lyrics="$(get_lyrics_for "$artist" "$album_cleaned" "$title_cleaned" "plainLyrics")"
    # fi

    # 4. If still nothing, skip
    if [ -z "$lyrics" ] || [ "$lyrics" == "null" ]; then
        echo "✗ No lyrics for: \"$title_cleaned\""
        return 1
    fi

    # 5. Save to .lrc file (even if plain — still a readable format)
    #echo "$lyrics" > "$out_lrc"
    echo "$lyrics" | sed -E '/^\[(ar|al|ti):/d' > "$out_lrc"
    echo "✔ Saved lyrics: $(basename "$out_lrc")"
    return 0
}

#shopt -s nullglob
for ALBUM_DIR in "$ARTIST_DIR"/*/; do
    if [ ! -d "$ALBUM_DIR" ]; then
        continue
    fi

    ALBUM_RAW="$(basename "$ALBUM_DIR")"
    ALBUM="$(clean_album_name "$ARTIST" "$ALBUM_RAW")"

    echo "▶ Fetching lyrics for all .mp3 in: $ALBUM_DIR"
    echo "  Artist: $ARTIST"
    echo "  Album:  $ALBUM"
    echo

    for mp3 in "$ALBUM_DIR"/*.mp3; do
        TITLE_RAW_ORIG="$(basename "$mp3" .mp3)"
        TITLE_RAW="$(clean_title "$ARTIST" "$TITLE_RAW_ORIG")"
        LRC_FILE="${mp3%.mp3}.lrc"

        if [ -f "$LRC_FILE" ]; then
            echo "– Skipping \"$TITLE_RAW\" (already have .lrc)"
            continue
        fi

        # Keep track if a lyrics file was already present
        #already_had_lrc=false
        #if [ -f "$LRC_FILE" ]; then
        #    already_had_lrc=true
        #fi

        # if ! fetch_for_plain "$ARTIST" "$ALBUM" "$TITLE_RAW" "$LRC_FILE"; then
        #    if [ "$already_had_lrc" = true ]; then
        #        echo "⚠️  No valid lyrics found. Deleting old lyrics: $(basename "$LRC_FILE")"
        #        rm -f "$LRC_FILE"
        #    fi
        #    continue
        # fi
    done

done

echo
echo "Done."
