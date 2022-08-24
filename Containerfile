FROM fedora AS build

WORKDIR /

RUN dnf install -y\
        python\
        pip\
        git &&\
    git clone https://github.com/oras-project/oras-www.git

WORKDIR /oras-www

RUN pip3 install -r requirements.txt && mkdocs build -d site

RUN curl -L https://github.com/uor-framework/uor-client-go/releases/download/v0.2.0/client_0.2.0_linux_amd64.tar.gz --output client_0.2.0_linux_amd64.tar.gz

RUN tar -xzvf client_0.2.0_linux_amd64.tar.gz client-linux-amd64 &&\
    mv client-linux-amd64 ./client &&\
    ls ./client

RUN curl -L https://github.com/caddyserver/caddy/releases/download/v2.5.2/caddy_2.5.2_linux_amd64.tar.gz --output caddy.tar.gz &&\
    tar -xzvf caddy.tar.gz

RUN mkdir push &&\
    cp -R site push/build_local &&\
    cp -R site push/build_production &&\
    cp caddy ./push/

COPY dataset-config.yaml .

COPY client-push.sh .
COPY client-pull.sh .
COPY index.html .

FROM fedora AS target

WORKDIR /oras-www

RUN dnf install -y jq

COPY --from=build /oras-www/client .
COPY --from=build /oras-www/push/ ./push/
COPY --from=build /oras-www/dataset-config.yaml .
COPY --from=build /oras-www/client-push.sh .
COPY --from=build /oras-www/client-pull.sh .
COPY --from=build /oras-www/index.html .

