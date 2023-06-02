# NetzwerkeProjekt


# Good to know

Beide folgenden commands machen das selbe, nur 1x mit flag-tag (damit das image einen Namen erhält, hier: "netzwerkprojekt")

    docker build .   
    docker build --tag netzwerkprojekt .     

Beide commands machen das gleiche, nur 1x mit port-forwarding

    docker run -it netzwerkprojekt #nicht sichtbar      
    docker run -it -p 81:80 netzwerkprojekt

# HIER STARTEN für Docker mit Rails <funktionsfähig>

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

username: netz //
password: w3rk3n

# HIER STARTEN für Docker mit Rails + SWARM (überschneidet sich an einigen Punkten mit dem davor) <Nicht  vollständig Funktionsfähig>:

Es folgt eine Allgemeine Anleitung mit jeweiligen Beispielen (Falls es ein Befehl ist, der nicht Individuell angepasst werden muss, kommt kein Beispiel, da es schon allgemein ist) und einer mit --> gegenzeichneten kurzen Erklärung
Wir empfehlen dennoch alle folgenden Beispiele zu Copy Pasten (Es sollte aber immer auf die jeweiligen Verzeichnisse und Docker Hub Benutzer Namen angepasst werden):

# Vorbereitende Schritte:
Ordner aus dem Respoitory mittels ZIP auf den lokalen Rechner ziehen.
Danach YML-Datei mit dem Namen “docker-compose.yml” erstellen (Hierfür beliebigen Texteditor öffnen und dort Datei erstellen und mit .yml abspeichern) --> Der Dateityp muss yml oder yaml sein
Danach Datei in dem “ProjektNetzwerke” Ordner abspeichern (Das ist der Ordner vor dem Todo Ordner)

# Nun müssen folgende Anweisungen in der Eingabeaufforderung erfolgen:
    
    Cd <Dateipfad> # wo der Ordner “ProjektNetzwerke” ist (der, bevor man in den Ordner Todo geht)]
 Bsp:
    
    Cd C:\Users\User\OneDrive\Desktop\ProjektNetzwerke
--> Man geht in den Benannten Ordner

    Docker run -d -e POSTGRES_PASSWORD=password -e POSTGRES_HOST_AUTH_METHOD=trust -p 5432:5432 postgres 
--> Man erstellt denn ersten Docker

    Docker Swarm init
--> Man erstellt einen Docker Swarm

    docker stack deploy -c docker-compose.yml <my_app>
 Bsp:
    
    docker stack deplo docker push ftomuni/netzwerkimage:1.0 y --compose-file docker-compose.yml todo_stack
--> Es wird ein Docker stack basierend auf der yml Datei erstellt (siehe Anhang)
    
    Cd <Dateipfad> (sofern er nicht unbenannt wurde, der Todo Ordner)
Bsp:

    Cd Todo
-->Man springt in den Ordner Todo

    docker build --tag <Name_Docker_Image> .
Bsp:   
    
    docker build --tag netwerkprojekt_rails .
--> Es wird ein Docker Image aus denn Dateien des aktuellen Verzeichneses erstellt und ihm dem Namen netzerkprojekt_rails erstellt

    Docker login 
--> Man meldet sich in seinem Docker Hub an

    docker tag <Name_Docker_Image> <dockerhub_username>/<repository_name>:<tag>
Bsp: 
 
    docker tag netwerkprojekt_rails ftomuni/netzwerkimage:1.0
--> Docker Image bekommt einen neuen Namen und man gibt ihn weitere Daten (Denn eigenen Dockerhub Namen und ein Ziel Verzeichnis) um es mit folgendem Befehl hochzuladen
    
    Docker push <dockerhub_username>/<repository_name>:<tag>
Bsp:
    
    docker push ftomuni/netzwerkimage:1.0
-->Docker Image wird Hochgeladen

    Docker run -d -p 4000:3000 -e DB_Host= <IPV 4 adresse> <Name_Docker_Image>
   Bsp.:
   
    Docker run -d -p 4000:3000 -e DB_Host=172.18.0.2/16 netwerkprojekt_rails
--> startet einen Docker Container basierend auf dem angegeben Docker

    docker service create --name todo-app --publish 3000:3000 --env DATABASE_URL=postgres://postgres:postgres@db:5432/todo_development --replicas 3 todo
--> erstellt einen Docker Dienst und repliziert ihn auf Instanzen

-->Danach kommt Fehlermeldung --> man muss daraufhin die Eingabeaufforderung Neustarten
    
    docker network connect rails-network <CONTAINER_ID> (Vom neuesten _Network Docker [siehe Docker Desktop])
 Bsp:
    
    docker network connect rails-network d7425a0f91e939b50868d91dab69ee4761a9a59172aa9cf1e31bf373e5cf5973
--> verbindet denn Docker mit dem Rails Network

# Letzter Schritt:
Localhost:4000 öffnen in Firefox öffnen

--> Es kommt eine Fehlermeldung vermutlich Auf Grundlage der Fehlermeldung zuvor
Leider wissen wir ab diesem Punkt nicht weiter 

# Befehle für Zwischentest, um zu gucken, ob alles erfolgreich installiert wurde:
    
    docker search <registry_username>/<repository_name> 
    Bsp.:docker search ftomuni/netzwerkimage

-->zeigt an, ob er das Docker Image findet:

    NAME                    DESCRIPTION   STARS     OFFICIAL   AUTOMATED
    ftomuni/netzwerkimage                 0

    docker images
-->zeigt alle Images an Ergebnis müsste sein:

    REPOSITORY              TAG       IMAGE ID       CREATED       SIZE
    postgres                <none>    0c88fbae765e   3 days ago    379MB
    ftomuni/netzwerkimage   1.0       c8b9a48acb79   3 weeks ago   1.02GB
    netzwerkprojekt_rails   latest    c8b9a48acb79   3 weeks ago   1.02GB

    docker service ls
--> zeigt alle Service an Ergebnis müsste sein:

    ID             NAME             MODE         REPLICAS   IMAGE             PORTS
    di6cb5646hg6   todo-app         replicated   0/3        todo:latest       *:3000->3000/tcp
    iyogqg7yrsiw   todo_stack_db    replicated   1/1        postgres:latest   *:5433->5432/tcp
    on321ayauomo   todo_stack_web   replicated   0/1        todo:latest       *:4000->3000/tcp

    
    
“Docker-compose.yml”  Datei:
    
    version: '3'
    services:
    web:
    image: todo
    ports:
      - "4000:3000"
    depends_on:
      - db
    environment:
      DATABASE_URL: postgres://postgres:postgres@db:5432/todo_development
    db:
    image: postgres
    ports:
      - "5432:5432"
    environment:
      POSTGRES_USER: postgres
      POSTGRES_PASSWORD: postgres



