FROM alpine:3.18

ARG YQ_VERSION=4.44.3
ARG SCM_VERSION=1.9.0
ARG SCM_FILE=scm-backup-1.9.0.71ac2df.zip
#ARG DOTNET_FILE=aspnetcore-runtime-3.1.32-linux-musl-x64.tar.gz
#ARG DOTNET_FILE_SHA512=d67edf1ed7817c002e1f444baf3a48b71d6f3328ed3f63287d744445665db846f63d24f4f8dd97f99d85f9d5f28fd0d1f1b8efa0c88ed7545a3ee9cfc491f7d0

ENV SCM_ROOT=/opt/scm-backup
ENV DOTNET_ROOT=/root/.dotnet
ENV PATH=${PATH}:${DOTNET_ROOT}
ENV DOTNET_SYSTEM_GLOBALIZATION_INVARIANT=1

WORKDIR ${SCM_ROOT}

RUN apk add --no-cache \
       bash curl git \
    && apk add pixz \
           libgcc libintl libssl1.1 \
    libstdc++ zlib curl git \
    --no-cache --repository=https://dl-cdn.alpinelinux.org/alpine/edge/community \
    # Install dotnet runtime
    #&& curl -fsL -o ${DOTNET_FILE} https://download.visualstudio.microsoft.com/download/pr/e94c26b7-6ac0-46b9-81f1-e008ce8348cb/41d57ffacf3e151de8039ec3cd007a68/${DOTNET_FILE} \
    #&& echo "${DOTNET_FILE_SHA512}  ${DOTNET_FILE}" > ${DOTNET_FILE}.sha512 \
    #&& sha512sum -c ${DOTNET_FILE}.sha512 \
    #&& mkdir -p ${DOTNET_ROOT} \
    #&& tar zxf ${DOTNET_FILE} -C ${DOTNET_ROOT} \
    # Download and install .NET SDK using the official install script
    && wget https://dot.net/v1/dotnet-install.sh -O dotnet-install.sh \
    && chmod +x dotnet-install.sh \
    && ./dotnet-install.sh --version latest \
    && rm dotnet-install.sh \
    # Install scm-backup
    && curl -fsL -o ${SCM_FILE} https://github.com/christianspecht/scm-backup/releases/download/${SCM_VERSION}/${SCM_FILE} \
    && unzip ${SCM_FILE} \
    && rm -f ${SCM_FILE} \
    # Install yq (config templating)
    && curl -fSL https://github.com/mikefarah/yq/releases/download/v${YQ_VERSION}/yq_linux_amd64 -o /usr/local/bin/yq \
    && chmod +x /usr/local/bin/yq

COPY entrypoint.sh /usr/local/bin
COPY settings.yml .

RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["entrypoint.sh"]
