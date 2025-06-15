#!/bin/sh

# Start PocketBase in background
echo "Starting PocketBase..."
/pb/pocketbase serve  --http=0.0.0.0:8090 &

# Wait for PocketBase to be ready
echo "Waiting for PocketBase to start..."
until wget -qO- http://localhost:8090/api/health >/dev/null 2>&1; do
  sleep 1
done

# Create admin user
echo "Creating admin user..."
/pb/pocketbase superuser upsert "$PB_ADMIN_EMAIL" "$PB_ADMIN_PASSWORD"

# Keep container running
wait