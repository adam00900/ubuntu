mkdir -p offline_packages && cd offline_packages/repo/amd64
for pack in $(cat ../../../packages.txt); do 
    echo "Processing: $pack" && \
    apt download $(apt-cache depends --recurse --no-recommends --no-suggests \
                   --no-conflicts --no-breaks --no-replaces --no-enhances $pack | \
                   grep "^\w" | grep -v "i386" | sort -u) 2>/dev/null || \
    echo "Failed: $pack"
done 2>&1 | tee download_log.txt
