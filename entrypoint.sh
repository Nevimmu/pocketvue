#!/bin/bash

# Start PocketBase in background
/pocketbase/backend serve --http=0.0.0.0:8090 --dir=/pocketbase &

# In development mode, also start Vite dev server
if [ "$NODE_ENV" = "development" ]; then
  cd /web
  npm run dev -- --host 0.0.0.0 &
fi

# Wait for PocketBase to be ready
echo "Waiting for PocketBase to start..."
until wget -qO- http://localhost:8090/api/health >/dev/null 2>&1; do
  sleep 1
done

# Create admin user
echo "Creating admin user..."
/pocketbase/backend superuser upsert "$PB_ADMIN_EMAIL" "$PB_ADMIN_PASSWORD"

# Keep container running
wait