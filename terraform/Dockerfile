FROM hashicorp/terraform:light

LABEL vendor="Jobteaser" \
      com.jobteaser.version="0.1.0" \
      com.jobteaser.release-date="2018-12-03" \
      maintainer="dev@jobteaser.com"


# Terraform-docs is responsible for creating the README.md files on the project
ENV TF_DOCS_VERSION_TAG "v0.5.0"
RUN wget https://github.com/segmentio/terraform-docs/releases/download/${TF_DOCS_VERSION_TAG}/terraform-docs-${TF_DOCS_VERSION_TAG}-linux-amd64 && \
    mv terraform-docs-${TF_DOCS_VERSION_TAG}-linux-amd64 /bin/terraform-docs && \
    chmod +x /bin/terraform-docs && \
    terraform-docs --version

# TFlint will be used as a linter for Terraform files
ENV TF_LINT_VERSION_TAG "v0.7.2"
RUN wget https://github.com/wata727/tflint/releases/download/${TF_LINT_VERSION_TAG}/tflint_linux_amd64.zip && \
	unzip tflint_linux_amd64.zip && \
	install tflint /usr/local/bin && \
	tflint -v

# Install landscape for more readable "terraform plan" outputs (useful when CI will be applied to stacks)
RUN apk add --update --no-cache ruby ruby-bundler ruby-dev ruby-rdoc alpine-sdk && \
    rm -rf /var/cache/apk/* && \
    gem install terraform_landscape && \
    landscape --version

ENTRYPOINT ["terraform"]

