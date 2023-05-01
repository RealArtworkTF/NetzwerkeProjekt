# NetzwerkeProjekt


# Good to know

Beide folgenden commands machen das selbe, nur 1x mit flag-tag 

    docker build .   
    docker build --tag netzwerkprojekt .     

Beide commands machen das gleiche, nur 1x mit port-forwarding

    docker run -it netzwerkprojekt #nicht sichtbar      
    docker run -it -p 81:80 netzwerkprojekt

# HIER STARTEN!!!

# Datenbank aufbauen
    docker run -d -e POSTGRES_PASSWORD=password -e POSTGRES_HOST_AUTH_METHOD=trust -p 5432:5432 postgres

# Docker Netzwerk bauen (damit die Rails app nachher die Datenbank finden kann)

    docker network create rails-network
    docker network connect rails-network <CONTAINER_ID>

Fuer CONTAINER_ID muss man die richtige ID vom laufenden DB container verwenden (aus dem Docker interface kopieren)

Um die IP fuer die Datenbank-Verbindung zu bekommen:

    docker network inspect rails-network

Dort die IPv4 Addresse kopieren (wird unten verwendet)


# Rails app bauen

https://deallen7.medium.com/how-to-build-a-todo-app-in-rails-e6571fcccac3

    bundle exec rails db:create # erzeugt db
    bundle exec rails generate scaffold Task title:string
    bundle exec rails db:migrate # fuer die db migrationen aus
    bundle exec rails server # startet den server

# Rails in docker

https://github.com/docker/awesome-compose/tree/master/official-documentation-samples/rails/

gehe in todo folder, baue image:

    docker build --tag netzwerkprojekt_rails .

lass das image laufen:

    docker run -d -p 3000:3000 -e DB_HOST=<IPV4_VON_OBEN> netzwerkprojekt_rails

zum netzwerk hinzufügen (wie davor CONTAINER_ID kopieren)

    docker network connect rails-network <CONTAINER_ID>

Dann im Browser localhost:3000 aufrufen
username: netz 
password: w3rk3n