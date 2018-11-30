FROM hashicorp/terraform:light

LABEL vendor="Jobteaser" \
      com.jobteaser.version="0.1.0" \
      com.jobteaser.release-date="2018-11-30" \
      maintainer="dev@jobteaser.com"

RUN wget https://github.com/segmentio/terraform-docs/releases/download/v0.5.0/terraform-docs-v0.5.0-linux-amd64 && \
    mv terraform-docs-v0.5.0-linux-amd64 /bin/terraform-docs && \
    chmod +x /bin/terraform-docs && \
    terraform-docs --version

RUN wget https://github.com/wata727/tflint/releases/download/v0.7.2/tflint_linux_amd64.zip && \
	unzip tflint_linux_amd64.zip && \
	mkdir -p /usr/local/tflint/bin && \
	export PATH=/usr/local/tflint/bin:$PATH && \
	install tflint /usr/local/tflint/bin && \
	mv tflint /bin/ && \
	tflint -v

ENTRYPOINT ["terraform"]

