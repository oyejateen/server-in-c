set -e
tmpFile=$(mktemp)
gcc -lcurl ./*.c -o $tmpFile
exec "$tmpFile" "$@"
