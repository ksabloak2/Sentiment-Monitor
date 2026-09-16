#!/bin/bash
# Run the API locally (no Docker) for development
set -e

cd "$(dirname "$0")/.."

if [ ! -f .env ]; then
  echo "No .env file found. Copying .env.example → .env"
  cp .env.example .env
fi

if [ ! -d .venv ]; then
  echo "Creating virtual environment..."
  python3 -m venv .venv
fi

source .venv/bin/activate
pip install -q -r requirements.txt

export $(grep -v '^#' .env | grep '=' | sed 's/#.*//' | xargs)

uvicorn app.main:app --reload --host 0.0.0.0 --port 8000
