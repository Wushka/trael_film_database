# README

Kør tests med:
```
bin/rails test:system
```

Ideelt er api_key i credentials
```
omdb:
  api_key: "<<api_key>>"
```
 men for lethedens skyld er den exposed i koden.


Opret film ved at:
 1. Søg efter en filmtitel i feltet i toppen af "/movies/new"
 2. Klik på "Tilføj Til Liste" under plakaten