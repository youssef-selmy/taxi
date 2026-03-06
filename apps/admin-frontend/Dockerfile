FROM ghcr.io/cirruslabs/flutter:3.38.2 AS builder
WORKDIR /workspace

COPY . .

WORKDIR /workspace/libs/flutter_localizations
RUN flutter pub get
RUN flutter gen-l10n

WORKDIR /workspace/apps/admin-frontend
RUN flutter pub get
RUN dart run build_runner build --delete-conflicting-outputs
RUN flutter build web --release

FROM nginx:alpine

RUN rm -rf /usr/share/nginx/html/*
COPY --from=builder /workspace/apps/admin-frontend/build/web /usr/share/nginx/html

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
