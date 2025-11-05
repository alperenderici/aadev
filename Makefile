# Makefile for Flutter Web Portfolio Deployment
# Author: Ali Alperen Derici
# Description: Automates build, deployment, and Git operations for the portfolio website

.PHONY: help build deploy build-deploy clean install test format analyze commit-push full-deploy

# Default target - show help
help:
	@echo "🎨 Ali Alperen Derici - Portfolio Deployment Automation"
	@echo ""
	@echo "Available commands:"
	@echo "  make build          - Build Flutter web app for production"
	@echo "  make deploy         - Deploy to Firebase Hosting"
	@echo "  make build-deploy   - Build and deploy in one step"
	@echo "  make clean          - Clean build artifacts"
	@echo "  make install        - Install/update Flutter dependencies"
	@echo "  make test           - Run Flutter tests"
	@echo "  make format         - Format Dart code"
	@echo "  make analyze        - Analyze Dart code for issues"
	@echo "  make commit-push    - Commit changes and push to GitHub (requires MESSAGE variable)"
	@echo "  make full-deploy    - Complete workflow: format, analyze, build, commit, push, deploy"
	@echo ""
	@echo "Examples:"
	@echo "  make build-deploy"
	@echo "  make commit-push MESSAGE=\"Fix navigation bug\""
	@echo "  make full-deploy MESSAGE=\"Update portfolio content\""

# Build Flutter web app for production
build:
	@echo "🔨 Building Flutter web app for production..."
	flutter build web --release
	@echo "✅ Build complete!"

# Deploy to Firebase Hosting
deploy:
	@echo "🚀 Deploying to Firebase Hosting..."
	firebase deploy --only hosting
	@echo "✅ Deployment complete! Live at https://alialperenderici.dev"

# Build and deploy in one step
build-deploy: build deploy
	@echo "✅ Build and deployment complete!"

# Clean build artifacts
clean:
	@echo "🧹 Cleaning build artifacts..."
	flutter clean
	rm -rf build/
	@echo "✅ Clean complete!"

# Install/update Flutter dependencies
install:
	@echo "📦 Installing Flutter dependencies..."
	flutter pub get
	@echo "✅ Dependencies installed!"

# Run Flutter tests
test:
	@echo "🧪 Running Flutter tests..."
	flutter test
	@echo "✅ Tests complete!"

# Format Dart code
format:
	@echo "✨ Formatting Dart code..."
	dart format lib/ test/ --line-length 80
	@echo "✅ Code formatted!"

# Analyze Dart code for issues
analyze:
	@echo "🔍 Analyzing Dart code..."
	flutter analyze
	@echo "✅ Analysis complete!"

# Commit changes and push to GitHub
# Usage: make commit-push MESSAGE="Your commit message"
commit-push:
ifndef MESSAGE
	@echo "❌ Error: MESSAGE variable is required"
	@echo "Usage: make commit-push MESSAGE=\"Your commit message\""
	@exit 1
endif
	@echo "📝 Committing changes..."
	git add .
	git commit -m "$(MESSAGE)"
	@echo "⬆️  Pushing to GitHub..."
	git push origin main
	@echo "✅ Changes committed and pushed!"

# Full deployment workflow: format, analyze, build, commit, push, deploy
# Usage: make full-deploy MESSAGE="Your commit message"
full-deploy:
ifndef MESSAGE
	@echo "❌ Error: MESSAGE variable is required"
	@echo "Usage: make full-deploy MESSAGE=\"Your commit message\""
	@exit 1
endif
	@echo "🚀 Starting full deployment workflow..."
	@echo ""
	@echo "Step 1/6: Formatting code..."
	@$(MAKE) format
	@echo ""
	@echo "Step 2/6: Analyzing code..."
	@$(MAKE) analyze
	@echo ""
	@echo "Step 3/6: Building for production..."
	@$(MAKE) build
	@echo ""
	@echo "Step 4/6: Committing changes..."
	git add .
	git commit -m "$(MESSAGE)" || echo "No changes to commit"
	@echo ""
	@echo "Step 5/6: Pushing to GitHub..."
	git push origin main
	@echo ""
	@echo "Step 6/6: Deploying to Firebase..."
	@$(MAKE) deploy
	@echo ""
	@echo "✅ Full deployment workflow complete!"
	@echo "🌐 Your portfolio is live at https://alialperenderici.dev"

# Quick deploy (build and deploy without Git operations)
quick-deploy: format analyze build deploy
	@echo "✅ Quick deployment complete!"

