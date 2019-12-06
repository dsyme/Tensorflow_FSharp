FROM mcr.microsoft.com/dotnet/core/sdk:3.1-bionic

WORKDIR /scripts
COPY . /scripts

RUN apt-get update && apt-get install -y \
    python3-pip

RUN pip3 install jupyter jupyterlab
ENV PATH="$PATH:/root/.dotnet/tools"
RUN dotnet tool install --global dotnet-try
RUN dotnet try jupyter install 

RUN jupyter nbconvert --to notebook --allow-errors --execute scripts/test2.ipynb
RUN jupyter nbconvert --to notebook --allow-errors --execute scripts/test1.ipynb


COPY entrypoint.sh /entrypoint.sh
RUN chmod +x entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]